defmodule SpeedrunClient.Publishers do
  @moduledoc """
  Publishers are companies that publish games, for example Capcom, SEGA, Midway Games etc.
  """
  defmacro __using__(_opts) do
    quote do
      def get_publishers(client, options \\ [])

      @doc """
      """
      @spec get_publishers(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_publishers(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/publishers", query: options)
      end

      @doc """
      """
      @spec get_publishers(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_publishers(client, id) when is_binary(id) do
        get(client, "/publishers/" <> id)
      end
    end
  end
end
