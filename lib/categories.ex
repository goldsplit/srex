defmodule SpeedrunClient.Categories do
  @moduledoc """
  Categories are the different rulesets for speedruns. Categories are either `per-game` or `per-level` (if the game uses individual levels), both can be accessed via this resource.

  This resource is meant to perform ID-based lookups. That's why there is no `GET /categories` to get a flat list of all categories across all games. If you want to get the categories for a game, use `GET /v1/games/{gameid}/categories`.
  """

  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_categories(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_categories(client, id, options \\ []) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("categories")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/categories/" <> id, query: options)
      end

      @doc """
      """
      @spec get_categories_variables(Tesla.Env.client(), String.t(), List.t()) ::
              Tesla.Env.result()
      def get_categories_variables(client, id, options \\ []) do
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
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("categories")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/categories/" <> id <> "/variables", query: options)
      end

      @doc """
      """
      @spec get_categories_records(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_categories_records(client, id, options \\ []) do
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
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("categories")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/categories/" <> id <> "/records", query: options)
      end
    end
  end
end
