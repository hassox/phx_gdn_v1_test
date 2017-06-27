defmodule GuardianV1Test.Web.AuthController do
  use GuardianV1Test.Web, :controller

  alias GuardianV1Test.Accounts
  alias GuardianV1Test.Guardian.Plug, as: GPlug

  def create(conn, %{"email" => email, "password" => password}) when not is_nil(email) do
    case Accounts.find_by_email_password(email, password) do
      {:error, _} ->
        conn
        |> put_flash(:error, "Could not login")
        |> redirect(to: "/login")
      {:ok, user} ->
        conn
        |> GPlug.sign_in!(user, %{}, permissions: %{admin: [:read]})
        |> put_flash(:success, "Logged in!")
        |> redirect(to: "/protected")
    end
  end

  def create(conn, _) do
    conn
    |> put_flash(:error, "Could not login")
    |> redirect(to: "/login")
  end

  def logout(conn, _params) do
    conn
    |> GPlug.sign_out!()
    |> redirect(to: "/")
  end
end
