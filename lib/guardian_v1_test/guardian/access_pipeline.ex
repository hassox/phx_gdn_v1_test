defmodule GuardianV1Test.Guardian.AccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :guardian_v1_test

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
