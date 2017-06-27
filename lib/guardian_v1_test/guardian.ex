defmodule GuardianV1Test.Guardian do
  use Guardian, otp_app: :guardian_v1_test,
                permissions: %{admin: [:read, :write]}

  use Guardian.Permissions.Bitwise
  alias GuardianV1Test.Accounts
  alias Accounts.{User}


  def subject_for_token(_, %{"sub" => sub}),
    do: {:ok, sub}

  def subject_for_token(%User{id: id}, _),
    do: {:ok, "User:#{id}"}

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    Accounts.get_user(id)
  end

  def build_claims(claims, _resource, opts) do
    claims =
      claims
      |> encode_permissions_into_claims!(Keyword.get(opts, :permissions))

    {:ok, claims}
  end
end
