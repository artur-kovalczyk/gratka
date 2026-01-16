defmodule UsersApiWeb.ImportController do
  use UsersApiWeb, :controller
  alias UsersApi.ImportService

  def create(conn, _params) do
    ImportService.import()
    json(conn, %{status: "ok"})
  end
end
