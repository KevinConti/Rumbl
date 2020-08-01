defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts

  def show(conn, %{"id" => id}) do
    case Accounts.get_user(id) do
      {:ok, user} ->
        render(conn, "show.html", user: user)

      # Show all users on error
      # TODO: Should also show some sort of error
      _err ->
        render(conn, "index.html", users: Accounts.list_users())
    end
  end

  def index(conn, _args) do
    render(conn, "index.html", users: Accounts.list_users())
  end
end
