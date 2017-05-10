defmodule Dwylbot.UserFromAuth do

  def basic_info(auth) do
    %{uid: id, info: info, info: %{image: avatar}} = Map.merge(%{info: %{image: nil}}, auth)
    %{id: id, name: name_from_info(info), avatar: avatar}
  end

  @doc """
  ## Name from info
    iex> Dwylbot.UserFromAuth.name_from_info(%{name: "simon"})
    "simon"
    iex> Dwylbot.UserFromAuth.name_from_info(%{name: "", first_name: "simon", last_name: "lab"})
    "simon lab"
  """

  defp name_from_info(info) do
    case info do
      %{name: name} when not is_nil(name) and name != "" ->
        name
      _ ->
        name = [info.first_name, info.last_name]
        |> Enum.filter(&(&1 != nil and &1 != ""))

        cond do
          length(name) == 0 -> Map.get info, :nickname
          true -> Enum.join(name, " ")
        end
    end
  end

end
