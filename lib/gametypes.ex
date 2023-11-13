defmodule SpeedrunClient.Gametypes do
  @moduledoc """
  Game types are classifications for unofficial games, for example ROM Hack, Fangame, Modification etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_gametypes(client, options \\ [])

      @doc """
      """
      @spec get_gametypes(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_gametypes(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/gametypes", query: options)
      end

      @doc """
      """
      @spec get_gametypes(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_gametypes(client, id) when is_binary(id) do
        get(client, "/gametypes/" <> id)
      end
    end
  end
end
