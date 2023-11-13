defmodule SpeedrunClientTest.Series do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_series w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [name: "name"],
        [abbreviation: "abbreviation"],
        [moderator: "moderator"],
        [orderby: "name.int"],
        [orderby: "name.jap"],
        [orderby: "abbreviation"],
        [orderby: "created"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: []],
        [embed: ["moderators"]],
        [name: "name", orderby: "name.jap", embed: ["moderators"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/series",
                  query: ^params
                }} =
                 SpeedrunClient.get_series(client, params)
      end
    )
  end

  test "get_series w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [name: 1],
        [abbreviation: 1],
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
        catch_error(SpeedrunClient.get_series(client, params))
      end
    )
  end

  test "get_series w/ id & valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []],
        [embed: ["moderators"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/series/1",
                  query: ^params
                }} =
                 SpeedrunClient.get_series(client, "1", params)
      end
    )
  end

  test "get_series w/ id & invalid options" do
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
        catch_error(SpeedrunClient.get_series(client, "1", params))
      end
    )
  end

  test "get_series_games w/ id & valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []],
        [embed: ["moderators"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/series/1/games",
                  query: ^params
                }} =
                 SpeedrunClient.get_series_games(client, "1", params)
      end
    )
  end

  test "get_series_games w/ id & invalid options" do
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
        catch_error(SpeedrunClient.get_series_games(client, "1", params))
      end
    )
  end
end
