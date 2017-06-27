defmodule GuardianV1Test.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]
  
  alias GuardianV1Test.Accounts.User


  schema "accounts_users" do
    field :password, :string, virtual: true
    field :email, :string
    field :encrypted_password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> maybe_encrypt_password()
    |> validate_required([:email, :encrypted_password])
  end

  def valid_password?(nil, _), do: dummy_checkpw()
  def valid_password?(_, nil), do: dummy_checkpw()

  def valid_password?(%User{encrypted_password: crypt_pass}, password) do
    checkpw(password, crypt_pass)
  end

  def maybe_encrypt_password(cset) do
    new_pass = get_change(cset, :password)
    if new_pass do
      new_crypted = hashpwsalt(new_pass)
      put_change(cset, :encrypted_password, new_crypted)
    else
      cset
    end
  end
end
