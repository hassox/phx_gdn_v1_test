defmodule GuardianV1Test.Web.GuardianChannel do
  use GuardianV1Test.Web, :channel
  use Guardian.Phoenix.Channel, module: GuardianV1Test.Guardian

  alias GuardianV1Test.Web.UserView

  def join("guardian:test", payload, socket) do
    if authorized?(payload) do
      json = UserView.render("user.json", %{user: current_resource(socket)})
      {:ok, %{user:  json}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join(_, _, _) do
    {:error, %{reason: "unknown channel"}}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (guardian:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
