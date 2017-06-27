defmodule GuardianV1Test.Web.PageController do
  use GuardianV1Test.Web, :controller

  alias GuardianV1Test.Guardian.Plug, as: GPlug

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def protected(conn, _params) do
    render conn, "protected.html", current_user: GPlug.current_resource(conn)
  end
end
