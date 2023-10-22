defmodule Virgule.Config do
  def adminroute, do: Application.get_env(:virgule, :ADMIN_PATH)
end
