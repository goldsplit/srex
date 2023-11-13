defmodule SpeedrunClient.Guests do
  @moduledoc """
  Sometimes, speedrun.com has runs done by players that have no account on the site yet. These runners are called "guests" in the API. Except for a name, there is nothing we know about them.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_guests(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_guests(client, name) do
        get(client, "/guests/" <> name)
      end
    end
  end
end
