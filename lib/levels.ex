defmodule SpeedrunClient.Levels do
  @moduledoc """
  Levels are the stages/worlds/maps within a game. Not all games have levels.

  This resource is meant to perform ID-based lookups. That's why there is no `GET /levels` to get a flat list of all levels across all games. To only get the levels for one game, use the `/levels` collection on the game itself.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_levels(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_levels(client, id, options \\ []) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("levels")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/levels/" <> id, query: options)
      end

      @doc """
      """
      @spec get_levels_categories(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_levels_categories(client, id, options \\ []) do
        schema = [
          miscellaneous: [
            type: :boolean,
            doc: "when given, filters (out) misc categories"
          ],
          orderby: [
            type: {:in, ["name", "miscellaneous", "pos"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("levels")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/levels/" <> id <> "/categories", query: options)
      end

      @doc """
      """
      @spec get_levels_variables(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_levels_variables(client, id, options \\ []) do
        schema = [
          orderby: [
            type: {:in, ["name", "mandatory", "user-defined", "pos"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("levels")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/levels/" <> id <> "/variables", query: options)
      end

      @doc """
      """
      @spec get_levels_records(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_levels_records(client, id, options \\ []) do
        schema = [
          top: [
            type: :integer,
            doc:
              "only return the top N places (this can result in more than N runs!); this is set to 3 by default"
          ],
          "skip-empty": [
            type: :boolean,
            doc: "when set to a true value, empty leaderboards will not show up in the result"
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("levels")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/levels/" <> id <> "/records", query: options)
      end
    end
  end
end
