defmodule SpeedrunClientTest.Users do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_users w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [lookup: "lookup"],
        [name: "name"],
        [twitch: "twitch"],
        [hitbox: "hitbox"],
        [twitter: "twitter"],
        [speedrunslive: "speedrunslive"],
        [orderby: "name.int"],
        [orderby: "name.jap"],
        [orderby: "signup"],
        [orderby: "role"],
        [direction: "asc"],
        [direction: "desc"],
        [twitch: "twitch", orderby: "signup", direction: "desc"]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/users",
                  query: ^params
                }} =
                 SpeedrunClient.get_users(client, params)
      end
    )
  end

  test "get_users w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [lookup: 1],
        [name: 1],
        [twitch: 1],
        [hitbox: 1],
        [twitter: 1],
        [speedrunslive: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_users(client, params))
      end
    )
  end

  test "get_users w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/users/1"}} =
             SpeedrunClient.get_users(client, "1")
  end

  test "basic get_users_personal_bests" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/users/1/personal-bests"}} =
             SpeedrunClient.get_users_personal_bests(client, "1")
  end

  test "get_users_personal_bests w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [top: 1],
        [series: "series"],
        [game: "game"],
        [top: 1, series: "series", game: "game"]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/users/1/personal-bests",
                  query: ^params
                }} =
                 SpeedrunClient.get_users_personal_bests(client, "1", params)
      end
    )
  end

  test "get_users_personal_bests w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [top: "invalid"],
        [series: 1],
        [game: 1],
        [top: "invalid", series: "series", game: "game"],
        [top: 1, series: "series", game: 1],
        [top: 1, series: 1, game: "game"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_users_personal_bests(client, "1", params))
      end
    )
  end
end
