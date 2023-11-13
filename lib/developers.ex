defmodule SpeedrunClient.Developers do
  @moduledoc """
  Developers are the persons and/of studios responsible for developing games, for example Acclaim Entertainment, Bethesda Softworks, Edmund McMillen etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_developers(client, options \\ [])

      @doc """
      """
      @spec get_developers(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_developers(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/developers", query: options)
      end

      @doc """
      """
      @spec get_developers(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_developers(client, id) when is_binary(id) do
        get(client, "/developers/" <> id)
      end
    end
  end
end
