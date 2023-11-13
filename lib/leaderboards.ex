defmodule SpeedrunClient.Leaderboards do
  @moduledoc """
  Leaderboards contain non-obsolete runs, sorted by time descending. In contrast to raw runs, leaderboards are automatically grouped according to the game/category/level rules that the moderators have defined.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_leaderboards_category(Tesla.Env.client(), String.t(), String.t(), List.t()) ::
              Tesla.Env.result()
      def get_leaderboards_category(client, game, category, options \\ []) do
        schema = [
          top: [
            type: :integer,
            doc: "only return the top N places (this can result in more than N runs!)"
          ],
          platform: [
            type: :string,
            doc: "platform ID; when given, only returns runs done on that particular platform"
          ],
          region: [
            type: :string,
            doc: "region ID; when given, only returns runs done in that particular region"
          ],
          emulators: [
            type: :boolean,
            doc:
              "when not given, real devices and emulators are shown. When set to a true value, only emulators are shown, else only real devices are shown"
          ],
          "video-only": [
            type: :boolean,
            doc:
              "`false` by default; when set to a true value, only runs with a video will be returned"
          ],
          timing: [
            type: {:in, ["realtime", "realtime_noloads", "ingame"]},
            doc: "controls the sorting; can be one of `realtime`, `realtime_noloads` or `ingame`"
          ],
          # TODO: validate the ISO 8601 string
          date: [
            type: :string,
            doc:
              "[ISO 8601 date string](https://en.wikipedia.org/wiki/ISO_8601#Dates); when given, only returns runs done before or on this date"
          ],
          # TODO: fix this validation
          "var-": [
            type: :string,
            doc: "additional custom variable values (see below)"
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("leaderboards")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/leaderboards/" <> game <> "/category/" <> category, query: options)
      end

      @doc """
      """
      @spec get_leaderboards_level(
              Tesla.Env.client(),
              String.t(),
              String.t(),
              String.t(),
              List.t()
            ) ::
              Tesla.Env.result()
      def get_leaderboards_level(client, game, level, category, options \\ []) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("leaderboards")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)

        get(client, "/leaderboards/" <> game <> "/level/" <> level <> "/" <> category,
          query: options
        )
      end
    end
  end
end
