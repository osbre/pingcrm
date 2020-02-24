defmodule PingWeb.ErrorView do
  use PingWeb, :view

  def render("500.html", _assigns), do: "Internal Server Error"
  def render("400.html", _assigns), do: "Bad Request"
  def render("404.html", _assigns), do: "Not Found"

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
