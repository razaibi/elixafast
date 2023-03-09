### 

Schema - Parent

```elixir
  schema "posts" do
    field :body, :string
    field :title, :string
    has_many :comments, Bloginfo.Blog.Comment

    timestamps()
  end
```

Schema - Child

```elixir
  schema "comments" do
    field :body, :string
    belongs_to :post, Bloginfo.Blog.Post
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body, :post_id])
  end
```


Controller - Parent

```elixir

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, :index, posts: posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, :show, post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, :edit, post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/posts")
  end
```

Controller - Child


```elixir
  def index(conn, _params) do
    comments = Blog.get_comments_with_post_title()
    comments = comments |> Enum.map(fn {comment, value} -> Map.put(comment, :post_title, value) end)
    render(conn, :index, comments: comments)
  end

  def new(conn, _params) do
    changeset = Blog.change_comment(%Comment{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Blog.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    {comment, blog_title} = Blog.get_comment_with_post_title!(id)
    render(conn, :show, comment: comment, blog_title: blog_title )
  end

  def edit(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    changeset = Blog.change_comment(comment)
    render(conn, :edit, comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Blog.get_comment!(id)

    case Blog.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: ~p"/comments/#{comment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blog.get_comment!(id)
    {:ok, _comment} = Blog.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: ~p"/comments")
  end
```


Ecto Queries One to Many

```elixir
  def get_comments_with_post_title do
    from(c in Comment,
      join: p in assoc(c, :post),
      select: {c, p.title}
    )
    |> Repo.all()
  end
```

```elixir
  def get_comment_with_post_title!(id) do
    from(c in Comment,
      where: c.id == ^id,
      join: p in assoc(c, :post),
      select: {c, p.title}
    )
    |> Repo.one()
  end
```


Form - Parent

```heex
<.simple_form :let={f} for={@changeset} action={@action}>
  <.error :if={@changeset.action}>
    Oops, something went wrong! Please check the errors below.
  </.error>
  <.input field={f[:title]} type="text" label="Title" />
  <.input field={f[:body]} type="text" label="Body" />
  <:actions>
    <.button>Save Post</.button>
  </:actions>
</.simple_form>
```

Form - Child

```heex
<.simple_form :let={f} for={@changeset} action={@action}>
  <.error :if={@changeset.action}>
    Oops, something went wrong! Please check the errors below.
  </.error>
  <.input field={f[:body]} type="text" label="Body" />
  <.input field={f[:post_id]} type="select" label="Choose your post" options={Enum.map(Bloginfo.Blog.list_posts(), fn post -> {post.title, post.id} end)}  />
  <:actions>
    <.button>Save Comment</.button>
  </:actions>
</.simple_form>
```

Index - Parent

```heex
<.table id="posts" rows={@posts} row_click={&JS.navigate(~p"/posts/#{&1}")}>
  <:col :let={post} label="Title"><%= post.title %></:col>
  <:col :let={post} label="Body"><%= post.body %></:col>
  <:action :let={post}>
    <div class="sr-only">
      <.link navigate={~p"/posts/#{post}"}>Show</.link>
    </div>
    <.link navigate={~p"/posts/#{post}/edit"}>Edit</.link>
  </:action>
  <:action :let={post}>
    <.link href={~p"/posts/#{post}"} method="delete" data-confirm="Are you sure?">
      Delete
    </.link>
  </:action>
</.table>
```

Index - Child

```heex
<.table id="comments" rows={@comments} row_click={&JS.navigate(~p"/comments/#{&1}")}>
  <:col :let={comment} label="Comment"><%= comment.body %></:col>
  <:col :let={comment} label="Post title"><%= comment.post_title %></:col>
  <:action :let={comment}>
    <div class="sr-only">
      <.link navigate={~p"/comments/#{comment}"}>Show</.link>
    </div>
    <.link navigate={~p"/comments/#{comment}/edit"}>Edit</.link>
  </:action>
  <:action :let={comment}>
    <.link href={~p"/comments/#{comment}"} method="delete" data-confirm="Are you sure?">
      Delete
    </.link>
  </:action>
</.table>
```

