defmodule SpeedrunClient.Profile do
  @moduledoc """
  The profile is the user resource of the currently authenticated user. This is useful to see what user a given API key belongs to.

  Note: Accessing this obviously requires a valid API key.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_profile(Tesla.Env.client()) :: Tesla.Env.result()
      def get_profile(client) do
        get(client, "/profile")
      end
    end
  end
end
