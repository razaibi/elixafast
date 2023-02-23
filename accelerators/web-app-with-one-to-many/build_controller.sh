APP_NAME=${1}
MODULE_NAME=$(echo $APP_NAME  | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')
APP_AREA_NAME="Blog"
WEB_FOLDER=${1}_web

echo '
defmodule '$MODULE_NAME'Web.CommentController do
  use '$MODULE_NAME'Web, :controller

  alias '$MODULE_NAME'.'$APP_AREA_NAME'
  alias '$MODULE_NAME'.'$APP_AREA_NAME'.Comment

  def index(conn, _params) do
    comments = '$APP_AREA_NAME'.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = '$APP_AREA_NAME'.change_comment(%Comment{})
    post_options = '$APP_AREA_NAME'.list_posts() |> Enum.map(&{&1.title, &1.id})
    render(conn, "new.html", changeset: changeset, post_options: post_options)
  end

  def create(conn, %{"comment" => comment_params}) do
    case '$APP_AREA_NAME'.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = '$APP_AREA_NAME'.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = '$APP_AREA_NAME'.get_comment!(id)
    changeset = '$APP_AREA_NAME'.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = '$APP_AREA_NAME'.get_comment!(id)

    case '$APP_AREA_NAME'.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = '$APP_AREA_NAME'.get_comment!(id)
    {:ok, _comment} = '$APP_AREA_NAME'.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end' > ./$APP_NAME/lib/$WEB_FOLDER/controllers/comment_controller.ex


echo '
defmodule '$MODULE_NAME'Web.PostController do
  use '$MODULE_NAME'Web, :controller

  alias '$MODULE_NAME'.'$APP_AREA_NAME'
  alias '$MODULE_NAME'.'$APP_AREA_NAME'.Post

  def index(conn, _params) do
    posts = '$APP_AREA_NAME'.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = '$APP_AREA_NAME'.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case '$APP_AREA_NAME'.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = '$APP_AREA_NAME'.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = '$APP_AREA_NAME'.get_post!(id)
    changeset = '$APP_AREA_NAME'.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = '$APP_AREA_NAME'.get_post!(id)

    case '$APP_AREA_NAME'.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = '$APP_AREA_NAME'.get_post!(id)
    {:ok, _post} = '$APP_AREA_NAME'.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
' > ./$APP_NAME/lib/$WEB_FOLDER/controllers/post_controller.ex