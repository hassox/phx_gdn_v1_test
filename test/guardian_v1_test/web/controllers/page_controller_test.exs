defmodule GuardianV1Test.Web.PageControllerTest do
  use GuardianV1Test.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
