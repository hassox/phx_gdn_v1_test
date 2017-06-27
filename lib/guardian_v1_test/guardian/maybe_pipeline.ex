defmodule GuardianV1Test.Guardian.MaybePipeline do
  use Guardian.Plug.Pipeline, otp_app: :guardian_v1_test

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end
