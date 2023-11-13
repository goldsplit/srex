defmodule SpeedrunClient.Runs do
  @moduledoc """
  Runs are the meat of our business at speedrun.com. A run is a finished attempt to play a game, adhering to that game's ruleset. Invalid attempts (use of cheats etc) or obsolete runs (the ones superseded by a better time by the same player(s) in the same ruleset) still count as runs and are available via API.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      def get_runs(client, id_or_options \\ [], options \\ []) do
        case id_or_options do
          options when is_list(id_or_options) -> _get_runs(client, options)
          id when is_binary(id_or_options) -> _get_runs(client, id, options)
        end
      end

      @spec _get_runs(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      defp _get_runs(client, options) do
        schema = [
          user: [
            type: :string,
            doc: "user ID; when given, only returns runs played by that user"
          ],
          guest: [
            type: :string,
            doc: "when given, only returns runs done by that guest"
          ],
          examiner: [
            type: :string,
            doc: "user ID; when given, only returns runs examined by that user"
          ],
          game: [
            type: :string,
            doc: "game ID; when given, restricts to that game"
          ],
          level: [
            type: :string,
            doc: "level ID; when given, restricts to that level"
          ],
          category: [
            type: :string,
            doc: "category ID; when given, restricts to that category"
          ],
          platform: [
            type: :string,
            doc: "platform ID; when given, restricts to that platform"
          ],
          region: [
            type: :string,
            doc: "region ID; when given, restricts to that region"
          ],
          emulated: [
            type: :boolean,
            doc: "when `true`, only games run on emulator will be returned"
          ],
          status: [
            type: {:in, ["new", "verified", "rejected"]},
            doc:
              "filters by run status; `new`, `verified` and `rejected` are possible values for this parameter"
          ],
          orderby: [
            type:
              {:in,
               [
                 "game",
                 "category",
                 "level",
                 "platform",
                 "region",
                 "emulated",
                 "date",
                 "submitted",
                 "status",
                 "verify-date"
               ]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("runs")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/runs", query: options)
      end

      @spec _get_runs(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      defp _get_runs(client, id, options) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("runs")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/runs/" <> id, query: options)
      end

      @doc """
      """
      @spec post_runs(Tesla.Env.client(), Tesla.Env.body()) :: Tesla.Env.result()
      def post_runs(client, body) do
        post(client, "/runs", body)
      end

      @doc """
      """
      @spec put_runs_status(Tesla.Env.client(), String.t(), Tesla.Env.body()) ::
              Tesla.Env.result()
      def put_runs_status(client, id, body) do
        put(client, "/runs/" <> id <> "/status", body)
      end

      @doc """
      """
      @spec put_runs_players(Tesla.Env.client(), String.t(), Tesla.Env.body()) ::
              Tesla.Env.result()
      def put_runs_players(client, id, body) do
        put(client, "/runs/" <> id <> "/players", body)
      end

      @doc """
      """
      @spec delete_runs(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def delete_runs(client, id) do
        delete(client, "/runs/" <> id)
      end
    end
  end
end
