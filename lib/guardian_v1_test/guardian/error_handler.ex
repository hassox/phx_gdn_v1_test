defmodule GuardianV1Test.Guardian.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {kind, _reason}, _opts) do
    body = Poison.encode!(%{message: to_string(kind)})
    send_resp(conn, 401, body)
  end
end
