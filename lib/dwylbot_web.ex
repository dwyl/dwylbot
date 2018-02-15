defmodule DwylbotWeb do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use DwylbotWeb, :controller
      use DwylbotWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """
  def controller do
    quote do
      use Phoenix.Controller, namespace: DwylbotWeb
      import DwylbotWeb.Router.Helpers
      import DwylbotWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/dwylbot_web/templates",
                        namespace: DwylbotWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [
        get_csrf_token: 0,
        get_flash: 2,
        view_module: 1
      ]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import DwylbotWeb.Router.Helpers
      import DwylbotWeb.ErrorHelpers
      import DwylbotWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import DwylbotWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
