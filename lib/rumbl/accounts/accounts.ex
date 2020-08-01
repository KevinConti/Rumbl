defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts module acts as the "public" facing API for all account-related procedures.
  It's the outer boundary for the domain
  """

  alias Rumbl.Accounts.User

  @type accounts_error :: :user_not_found

  def list_users do
    [
      %User{id: "1", name: "Jose", username: "josevalim"},
      %User{id: "2", name: "Bruce", username: "redrapids"},
      %User{id: "3", name: "Chris", username: "chrismccord"}
    ]
  end

  def get_user(id) do
    case Enum.find(list_users(), &(&1.id == id)) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end

  @spec get_user_by(any) ::
          {:error, accounts_error() | {:ok, Rumbl.Accounts.User.t()}}
  @doc """
  A function that gets a user by a map. Very powerful since it lets you search by any propery
  """
  def get_user_by(params) when is_map(params) or is_list(params) do
    case Enum.find(list_users(), fn item ->
           match_key_value(params, item)
         end) do
      nil -> {:error, :user_not_found}
      user = %User{} -> {:ok, user}
    end
  end

  def get_user_by(_params) do
    {:error, "not a map or list"}
  end

  defp match_key_value(params, item) when is_map(params) or is_list(params) do
    Enum.all?(params, fn {key, val} -> Map.get(item, key) == val end)
  end
end
