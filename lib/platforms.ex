defmodule SpeedrunClient.Platforms do
  @moduledoc """
  Platforms are hardware devices that run games, for example PC, NES, PS2 etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_platforms(client, options \\ [])

      @doc """
      """
      @spec get_platforms(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_platforms(client, options) when is_list(options) do
        schema = [
          orderby: [
            type: {:in, ["name", "released"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/platforms", query: options)
      end

      @doc """
      """
      @spec get_platforms(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_platforms(client, id) when is_binary(id) do
        get(client, "/platforms/" <> id)
      end
    end
  end
end
