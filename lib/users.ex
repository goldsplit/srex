defmodule SpeedrunClient.Users do
  @moduledoc """
  Users are the individuals who have registered an account on speedrun.com. Users submit (their) runs and moderate games, besides other things that are not covered by this API (like writing posts in the forums).

  The API only returns public user information, so things like the e-mail address, site settings etc. are not accessible.
  """
  defmacro __using__(_opts) do
    quote do
      def get_users(client, options \\ [])

      @doc """
      """
      @spec get_users(Tesla.Env.client(), List.t()) :: Tesla.Env.result()
      def get_users(client, options) when is_list(options) do
        schema = [
          lookup: [
            type: :string,
            doc:
              "when given, searches the value (case-insensitive exact-string match) across user names, URLs and social profiles; all other query string filters are disabled when this is given"
          ],
          name: [
            type: :string,
            doc:
              "only returns users whose name/URL contains the given value; the comparision is case-insensitive"
          ],
          twitch: [
            type: :string,
            doc: "searches for Twitch usernames"
          ],
          hitbox: [
            type: :string,
            doc: "searches for Hitbox usernames"
          ],
          twitter: [
            type: :string,
            doc: "searches for Twitter usernames"
          ],
          speedrunslive: [
            type: :string,
            doc: "searches for SpeedRunsLive usernames"
          ],
          orderby: [
            type: {:in, ["name.int", "name.jap", "signup", "role"]}
          ],
          direction: [
            type: {:in, ["asc", "desc"]}
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/users", query: options)
      end

      @doc """
      """
      @spec get_users(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_users(client, id) when is_binary(id) do
        get(client, "/users/" <> id)
      end

      @doc """
      """
      @spec get_users_personal_bests(Tesla.Env.client(), String.t(), List.t()) ::
              Tesla.Env.result()
      def get_users_personal_bests(client, id, options \\ []) do
        schema = [
          top: [
            type: :integer,
            doc:
              "when given, only PBs with a place equal or better than this value (e.g. `top=1` returns all World Records of the given user)"
          ],
          series: [
            type: :string,
            doc:
              "when given, restricts the result to games and romhacks in that series; can be either a series ID or abbreviation"
          ],
          game: [
            type: :string,
            doc:
              "when given, restricts the result to that game; can be either a game ID or abbreviation"
          ]
        ]

        NimbleOptions.validate!(options, schema)
        get(client, "/users/" <> id <> "/personal-bests", query: options)
      end
    end
  end
end
