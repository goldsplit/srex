defmodule SpeedrunClient.Games do
  @moduledoc """
  Games are the things users do speedruns in. Games are associated with regions (US, Europe, ...), platforms (consoles, handhelds, ...), genres, engines, developers, game types, publishers, categories, levels and custom variables (like speed=50/100/150cc in Mario Kart games).

  Games that are not part of a series are categorized in the "N/A" series for backwards compatibility.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      def get_games(client, id_or_options \\ [], options \\ []) do
        case id_or_options do
          options when is_list(id_or_options) -> _get_games(client, options)
          id when is_binary(id_or_options) -> _get_games(client, id, options)
        end
      end

      @spec _get_games(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      defp _get_games(client, options) do
        schema = [
          name: [
            type: :string,
            doc: "when given, performs a fuzzy search across game names and abbreviations"
          ],
          abbreviation: [
            type: :string,
            doc: "when given, performs an exact-match search for this abbreviation"
          ],
          released: [
            type: :integer,
            doc: "when given, restricts to games released in that year"
          ],
          gametype: [
            type: :string,
            doc: "game type ID; when given, restricts to that game type"
          ],
          platform: [
            type: :string,
            doc: "platform ID; when given, restricts to that platform"
          ],
          region: [
            type: :string,
            doc: "region ID; when given, restricts to that region"
          ],
          genre: [
            type: :string,
            doc: "genre ID; when given, restricts to that genre"
          ],
          engine: [
            type: :string,
            doc: "engine ID; when given, restricts to that engine"
          ],
          developer: [
            type: :string,
            doc: "developer ID; when given, restricts to that developer"
          ],
          publisher: [
            type: :string,
            doc: "publisher ID; when given, restricts to that publisher"
          ],
          moderator: [
            type: :string,
            doc: "moderator ID; when given, only games moderated by that user will be returned"
          ],
          romhack: [
            type: :boolean,
            doc:
              "legacy parameter, do not use this in new code; whether or not to include games with game types (if this parameter is not set, game types are included; if it is set to a true value, only games with game types will be returned, otherwise only games without game types are returned)",
            deprecated: "legacy parameter, do not use this in new code"
          ],
          _bulk: [
            type: :boolean,
            doc: "enable bulk access"
          ],
          orderby: [
            type:
              {:in, ["name.int", "name.jap", "abbreviation", "released", "created", "similarity"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games", query: options)
      end

      @spec _get_games(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      defp _get_games(client, id, options) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id, query: options)
      end

      @doc """
      """
      @spec get_games_categories(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_games_categories(client, id, options \\ []) do
        schema = [
          miscellaneous: [
            type: :string,
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
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id <> "/categories", query: options)
      end

      @doc """
      """
      @spec get_games_levels(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_games_levels(client, id, options \\ []) do
        schema = [
          orderby: [
            type: {:in, ["name", "pos"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id <> "/levels", query: options)
      end

      @doc """
      """
      @spec get_games_variables(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_games_variables(client, id, options \\ []) do
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
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id <> "/variables", query: options)
      end

      @doc """
      """
      @spec get_games_derived_games(Tesla.Env.client(), String.t(), List.t()) ::
              Tesla.Env.result()
      def get_games_derived_games(client, id, options \\ []) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id <> "/derived-games", query: options)
      end

      @doc """
      """
      @spec get_games_records(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_games_records(client, id, options \\ []) do
        schema = [
          top: [
            type: :integer,
            doc:
              "only return the top N places (this can result in more than N runs!); this is set to 3 by default"
          ],
          scope: [
            type: {:in, ["full-game", "levels", "all"]},
            doc:
              "when set to `full-game`, only full-game categories will be included; when set to `levels`, only individual levels are returned; default is `all`"
          ],
          miscellaneous: [
            type: :boolean,
            doc: "when set to a false value, miscellaneous categories will not be included"
          ],
          "skip-empty": [
            type: :boolean,
            doc: "when set to a true value, empty leaderboards will not show up in the result"
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("games")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/games/" <> id <> "/records", query: options)
      end
    end
  end
end
