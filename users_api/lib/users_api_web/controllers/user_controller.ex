defmodule UsersApiWeb.UserController do
  use UsersApiWeb, :controller
  alias UsersApi.Accounts

  def index(conn, _params) do
    json(conn, Accounts.list_users())
  end

  def show(conn, %{"id" => id}) do
    json(conn, Accounts.get_user!(id))
  end

  def create(conn, params) do
    {:ok, user} = Accounts.create_user(params)
    json(conn, user)
  end

  def update(conn, %{"id" => id} = params) do
    user = Accounts.get_user!(id)
    {:ok, user} = Accounts.update_user(user, params)
    json(conn, user)
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    Accounts.delete_user(user)
    send_resp(conn, :no_content, "")
  end
end
