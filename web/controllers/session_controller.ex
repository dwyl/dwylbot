defmodule Dwylbot.SessionController do
  use Dwylbot.Web, :controller
  alias Dwylbot.{Auth, User}

  def create(conn, user) do
    # do not save the token in Postgres, only in the user session
    user_changeset = User.changeset(%User{}, user)

    case Repo.insert(user_changeset) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> put_flash(:info, "Successful signup, welcome to dwylbot!!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        case elem(changeset.errors[:username], 0) do
          "has already been taken" ->
            conn
            |> Auth.login(user)
            |> put_flash(:info, "Successful signin, welcome back!")
            |> redirect(to: page_path(conn, :index))
          _ ->
            conn
            |> put_flash(:error, "Sorry there was an error during the login process, please try again")
            |> redirect(to: page_path(conn, :index))
        end
    end
  end

end
