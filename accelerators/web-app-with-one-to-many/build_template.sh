APP_NAME=${1}
MODULE_NAME=$(echo $APP_NAME  | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')
APP_AREA_NAME="Blog"
WEB_FOLDER=${1}_web

echo '
<.form let={f} for={@changeset} action={@action}>
  <%= if @changeset.action do %>
    <div class="alert alert-danger">
      <p>Oops, something went wrong! Please check the errors below.</p>
    </div>
  <% end %>

  <%= label f, :body %>
  <%= textarea f, :body %>
  <%= error_tag f, :body %>

  <%= label f, :post_id %>
  <%= select f, :post_id, @post_options, prompt: "Select a post" %>
  <%= error_tag f, :post_id %>

  <div>
    <%= submit "Save" %>
  </div>
</.form>

' > ./$APP_NAME/lib/$WEB_FOLDER/templates/comment/form.html.heex