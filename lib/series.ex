defmodule SpeedrunClient.Series do
  @moduledoc """
  Series are collections of games that have been released in context to each other, for example the "GTA" series contains all the games of this franchise. As a series is most often formed after a number of games have been published, many games do not belong to a specific series and are therefore categorized in the "Other" series. As time progresses, games can be moved in their own series, so be prepared for the series-game relationship to change.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      def get_series(client, id_or_options \\ [], options \\ []) do
        case id_or_options do
          options when is_list(id_or_options) -> _get_series(client, options)
          id when is_binary(id_or_options) -> _get_series(client, id, options)
        end
      end

      @spec _get_series(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      defp _get_series(client, options) do
        schema = [
          name: [
            type: :string,
            doc: "when given, performs a fuzzy search across series names and abbreviations"
          ],
          abbreviation: [
            type: :string,
            doc: "when given, performs an exact-match search for this abbreviation"
          ],
          moderator: [
            type: :string,
            doc: "moderator ID; when given, only series moderated by that user will be returned"
          ],
          orderby: [
            type: {:in, ["name.int", "name.jap", "abbreviation", "created"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ],
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("series")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/series", query: options)
      end

      @spec _get_series(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      defp _get_series(client, id, options) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("series")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/series/" <> id, query: options)
      end

      @doc """
      """
      @spec get_series_games(Tesla.Env.client(), String.t(), List.t()) :: Tesla.Env.result()
      def get_series_games(client, id, options \\ []) do
        schema = [
          embed: [
            type: {
              :list,
              {:in, SpeedrunClient.Embeddings.generate_valid_embeddings("series")}
            }
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/series/" <> id <> "/games", query: options)
      end
    end
  end
end
