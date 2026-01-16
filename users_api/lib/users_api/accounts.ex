defmodule UsersApi.Accounts do
  import Ecto.Query
  alias UsersApi.Repo
  alias UsersApi.Accounts.User

  def list_users(params \\ %{}) do
    User
    |> Repo.all()
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs) do
    %User{} |> User.changeset(attrs) |> Repo.insert()
  end

  def update_user(user, attrs) do
    user |> User.changeset(attrs) |> Repo.update()
  end

  def delete_user(user), do: Repo.delete(user)
end
