defmodule Dwylbot.UserFromAuthTest do
  use Dwylbot.ModelCase

  alias Ueberauth.Auth
  alias Dwylbot.UserFromAuth

  test "basic info, with name" do
    name = "simon"
    id = "simon's id"
    avatar = "avatar"

    auth = %Auth{uid: id, info: %{name: name, image: avatar}}
    info = UserFromAuth.basic_info auth

    assert info == %{id: id, name: name, avatar: avatar}
  end

  test "basic info, without name" do
    first_name = "simon"
    last_name = "lab"
    id = "simon's id"
    avatar = "avatar"

    auth = %Auth{uid: id, info: %{name: "",  first_name: first_name, last_name: last_name, image: avatar}}
    info = UserFromAuth.basic_info auth

    assert info.name == "simon lab"
  end
end
