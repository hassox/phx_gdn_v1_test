defmodule GuardianV1Test.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use GuardianV1Test.Web, :controller
      use GuardianV1Test.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: GuardianV1Test.Web
      import Plug.Conn
      import GuardianV1Test.Web.Router.Helpers
      import GuardianV1Test.Web.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/guardian_v1_test/web/templates",
                        namespace: GuardianV1Test.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import GuardianV1Test.Web.Router.Helpers
      import GuardianV1Test.Web.ErrorHelpers
      import GuardianV1Test.Web.Gettext

      def current_user(conn, key \\ :default),
        do: GuardianV1Test.Guardian.Plug.current_resource(conn, key: key)

      def current_token(conn, key \\ :default),
        do: GuardianV1Test.Guardian.Plug.current_token(conn, key: key)
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import GuardianV1Test.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
