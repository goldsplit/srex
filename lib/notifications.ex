defmodule SpeedrunClient.Notifications do
  @moduledoc """
  Notifications are system-generated messages sent to users when certain events concerning them happen on the site, like somebody liking a post or a run being verified.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_notifications(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_notifications(client, options \\ []) do
        schema = [
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/notifications", query: options)
      end
    end
  end
end
