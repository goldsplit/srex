defmodule SpeedrunClient.Embeddings do
  @moduledoc """
  Most resources are related to others in some form. A run is related to the category it is done in, as well as the users that have executed it.

  As resources are available as separate entities in the API, fetching a run including the information about its game and users involves making multiple requests (one for getting the run, then parsing it and then one more for the game etc.).

  The speedrun.com API offers a way to reduce the amount of requests by embedding related resources right in the representation of others. This is done via the query string parameter `embed`, which is a comma separated list of resources that should be embedded. Each resource documents what embeds are available for it.
  """

  @embedding_map Map.new([
                   {"categories", MapSet.new(["game", "variables"])},
                   {"games",
                    MapSet.new([
                      "levels",
                      "categories",
                      "moderators",
                      "gametypes",
                      "platforms",
                      "regions",
                      "genres",
                      "engines",
                      "developers",
                      "publishers",
                      "variables"
                    ])},
                   {"leaderboards",
                    MapSet.new([
                      "game",
                      "category",
                      "level",
                      "players",
                      "regions",
                      "platforms",
                      "variables"
                    ])},
                   {"levels", MapSet.new(["categories", "variables"])},
                   {"runs",
                    MapSet.new(["game", "category", "level", "players", "region", "platform"])},
                   {"series", MapSet.new(["moderators"])}
                 ])

  @doc """
    Generates the valid set of embedding options provided a resource type and embedding depth.

    Returns `MapSet([:string])`

    ## Examples

      iex> SpeedrunClient.Embeddings.generate_valid_embeddings("runs")
      MapSet.new(["game", "category", "level", "players", "region", "platform"])

      iex> SpeedrunClient.Embeddings.generate_valid_embeddings("levels")
      MapSet.new(["categories", "categories.game", "categories.variables", "variables"])
  """
  def generate_valid_embeddings(root, depth \\ 2) do
    if !Map.has_key?(@embedding_map, root) or depth <= 0 do
      MapSet.new([])
    else
      Enum.map(
        @embedding_map[root],
        fn child -> _generate_valid_embeddings_helper(child, depth - 1) end
      )
      |> List.flatten()
      |> MapSet.new()
    end
  end

  defp _generate_valid_embeddings_helper(node, depth) do
    if depth <= 0 do
      [node]
    else
      case @embedding_map[node] do
        nil ->
          [node]

        children ->
          [
            node
            | Enum.map(
                children,
                fn child -> _generate_valid_embeddings_helper(child, depth - 1) end
              )
              |> List.flatten()
              |> Enum.map(fn child -> node <> "." <> child end)
          ]
      end
    end
  end
end
