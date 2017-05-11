defmodule Dwylbot.UserFromAuthTest do
  use Dwylbot.ModelCase

  alias Ueberauth.Auth
  alias Dwylbot.UserFromAuth

  test "basic info, with name" do
    name = "simon"
    id = "simon's id"
    avatar = "avatar"

    auth = %Auth{uid: id, info: %{name: name, image: avatar}, credentials: %{token: 42}}
    info = UserFromAuth.basic_info auth

    assert info == %{username: id, name: name, avatar: avatar, token: 42}
  end

  test "basic info, without name" do
    first_name = "simon"
    last_name = "lab"
    id = "simon's id"
    avatar = "avatar"

    auth = %Auth{uid: id, info: %{name: "",  first_name: first_name, last_name: last_name, image: avatar},  credentials: %{token: 42}}
    info = UserFromAuth.basic_info auth

    assert info.name == "simon lab"
  end
end
