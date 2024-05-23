defmodule MyAppWeb.Auth do
  use Joken.Config
  # alias MyApp.Schemas.{User}
  # alias MyApp.Repo


  @key "your_secret_key"

  def token_config do
    default_claims()
    |> add_claim("aud", fn -> "my_app" end, &(&1 == "my_app"))
  end

  def generate_token(user) do

    claims = %{"sub" => user.id}
    {:ok, token, _claims} = MyAppWeb.Auth.generate_and_sign(claims, signing_key())
    {:ok, _claims} = MyAppWeb.Auth.verify_and_validate(token, signing_key())
    token
  end

  def verify_token(token) do
    # TODO: Implement token verification using Joken
    MyAppWeb.Auth.verify_and_validate(token, signing_key())
  end

  defp signing_key() do
    Joken.Signer.create("HS256", @key)
  end


end
