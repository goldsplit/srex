defmodule SpeedrunClient.Regions do
  @moduledoc """
  Regions represent the different distribution zones in which games are published, for example the US, Europe or Japan.
  """
  defmacro __using__(_opts) do
    quote do
      def get_regions(client, options \\ [])

      @doc """
      """
      @spec get_regions(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_regions(client, options) when is_list(options) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/regions", query: options)
      end

      @doc """
      """
      @spec get_regions(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_regions(client, id) when is_binary(id) do
        get(client, "/regions/" <> id)
      end
    end
  end
end
