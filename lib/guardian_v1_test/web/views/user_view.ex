defmodule GuardianV1Test.Web.UserView do
  use GuardianV1Test.Web, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
    }
  end
end
