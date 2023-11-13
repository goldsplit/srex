defmodule SpeedrunClient.Genres do
  @moduledoc """
  Genres are classifications for games, for example Action, JRPG, Rogue-like etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_genres(client, options \\ [])

      @doc """
      """
      @spec get_genres(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_genres(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/genres", query: options)
      end

      @doc """
      """
      @spec get_genres(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_genres(client, id) when is_binary(id) do
        get(client, "/genres/" <> id)
      end
    end
  end
end
