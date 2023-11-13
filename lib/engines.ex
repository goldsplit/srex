defmodule SpeedrunClient.Engine do
  @moduledoc """
  Engines are software frameworks used in the creation of games, for example the DOOM engine, Unreal Engine, Geo-Mod etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_engines(client, options \\ [])

      @doc """
      """
      @spec get_engines(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_engines(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/engines", query: options)
      end

      @doc """
      """
      @spec get_engines(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_engines(client, id) when is_binary(id) do
        get(client, "/engines/" <> id)
      end
    end
  end
end
