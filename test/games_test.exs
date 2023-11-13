defmodule SpeedrunClientTest.Games do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_games w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [name: "name"],
        [abbreviation: "abbreviation"],
        [released: 1],
        [gametype: "gametype"],
        [platform: "platform"],
        [region: "region"],
        [genre: "genre"],
        [engine: "engine"],
        [developer: "developer"],
        [publisher: "publisher"],
        [moderator: "moderator"],
        [orderby: "name.int"],
        [orderby: "name.jap"],
        [orderby: "abbreviation"],
        [orderby: "released"],
        [orderby: "created"],
        [orderby: "similarity"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
        [name: "name", genre: "genre", orderby: "created", embed: ["levels",  "categories.game"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games",
                  query: ^params
                }} =
                 SpeedrunClient.get_games(client, params)
      end
    )
  end

  test "get_games w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [name: 1],
        [abbreviation: 1],
        [released: "invalid"],
        [gametype: 1],
        [platform: 1],
        [region: 1],
        [genre: 1],
        [engine: 1],
        [developer: 1],
        [publisher: 1],
        [moderator: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games(client, params))
      end
    )
  end

  test "get_games w/ id and valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1",
                  query: ^params
                }} =
                 SpeedrunClient.get_games(client, "1", params)
      end
    )
  end

  test "get_games w/ id and invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games(client, "1", params))
      end
    )
  end

  test "get_games_categories w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [miscellaneous: "miscellaneous"],
        [orderby: "name"],
        [orderby: "miscellaneous"],
        [orderby: "pos"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
        [orderby: "miscellaneous", direction: "desc", embed: ["engines", "publishers"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1/categories",
                  query: ^params
                }} =
                 SpeedrunClient.get_games_categories(client, "1", params)
      end
    )
  end

  test "get_games_categories w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [miscellaneous: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games_categories(client, "1", params))
      end
    )
  end

  test "get_games_levels w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [orderby: "name"],
        [orderby: "pos"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
        [orderby: "name", embed: ["categories"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1/levels",
                  query: ^params
                }} =
                 SpeedrunClient.get_games_levels(client, "1", params)
      end
    )
  end

  test "get_games_levels w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [miscellaneous: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games_levels(client, "1", params))
      end
    )
  end

  test "get_games_variables w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [orderby: "name"],
        [orderby: "mandatory"],
        [orderby: "user-defined"],
        [orderby: "pos"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
        [orderby: "user-defined", embed: ["gametypes", "categories.variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1/variables",
                  query: ^params
                }} =
                 SpeedrunClient.get_games_variables(client, "1", params)
      end
    )
  end

  test "get_games_variables w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [miscellaneous: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games_variables(client, "1", params))
      end
    )
  end

  test "get_games_derived_games w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1/derived-games",
                  query: ^params
                }} =
                 SpeedrunClient.get_games_derived_games(client, "1", params)
      end
    )
  end

  test "get_games_derived_games w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games_derived_games(client, "1", params))
      end
    )
  end

  test "get_games_records w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [top: 1],
        [scope: "full-game"],
        [scope: "levels"],
        [scope: "all"],
        [miscellaneous: true],
        [miscellaneous: false],
        ["skip-empty": true],
        ["skip-empty": false],
        [embed: []],
        [embed: ["levels"]],
        [embed: ["levels.categories"]],
        [embed: ["levels.variables"]],
        [embed: ["categories"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["moderators"]],
        [embed: ["gametypes"]],
        [embed: ["platforms"]],
        [embed: ["regions"]],
        [embed: ["genres"]],
        [embed: ["engines"]],
        [embed: ["developers"]],
        [embed: ["publishers"]],
        [embed: ["variables"]],
        [
          embed: [
            "levels",
            "levels.categories",
            "levels.variables",
            "categories",
            "categories.game",
            "categories.variables",
            "moderators",
            "gametypes",
            "platforms",
            "regions",
            "genres",
            "engines",
            "developers",
            "publishers",
            "variables"
          ]
        ],
        [top: 10, scope: "full-game", embed: ["regions", "genres", "levels.variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/games/1/records",
                  query: ^params
                }} =
                 SpeedrunClient.get_games_records(client, "1", params)
      end
    )
  end

  test "get_games_records w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [top: "invalid"],
        [scope: 1],
        [scope: "invalid"],
        [miscellaneous: "invalid"],
        ["skip-empty": "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_games_records(client, "1", params))
      end
    )
  end
end
