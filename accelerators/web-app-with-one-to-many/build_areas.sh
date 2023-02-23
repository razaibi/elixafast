APP_NAME=${1}
MODULE_NAME=$(echo $APP_NAME  | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')
APP_AREA_NAME="Blog"

cd ${1}
mix phx.gen.html $APP_AREA_NAME Post posts title:string body:text
yes | mix phx.gen.html $APP_AREA_NAME Comment comments body:text post_id:integer
cd ..

echo '
defmodule '$MODULE_NAME'.'$APP_AREA_NAME'.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :post, '$MODULE_NAME'.'$APP_AREA_NAME'.Post
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body, :post_id])
  end
end' > ./$APP_NAME/lib/$APP_NAME/blog/comment.ex



echo '
defmodule '$MODULE_NAME'.'$APP_AREA_NAME'.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :title, :string
    has_many :comments, '$MODULE_NAME'.'$APP_AREA_NAME'.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
' > ./$APP_NAME/lib/$APP_NAME/blog/post.ex