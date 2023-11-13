defmodule SpeedrunClientTest.Leaderboards do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_leaderboards_category w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [top: 1],
        [platform: "platform"],
        [region: "region"],
        [emulators: true],
        [emulators: false],
        ["video-only": true],
        ["video-only": false],
        [timing: "realtime"],
        [timing: "realtime_noloads"],
        [timing: "ingame"],
        [date: "2023-11-13"],
        [embed: ["game"]],
        [embed: ["category"]],
        [embed: ["level"]],
        [embed: ["players"]],
        [embed: ["regions"]],
        [embed: ["platforms"]],
        [embed: ["variables"]],
        [embed: ["game", "category", "level", "players", "regions", "platforms", "variables"]],
        [
          top: 1,
          region: "region",
          timing: "realtime",
          "video-only": true,
          embed: ["game", "category"]
        ]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/leaderboards/1/category/2",
                  query: ^params
                }} =
                 SpeedrunClient.get_leaderboards_category(client, "1", "2", params)
      end
    )
  end

  test "get_leaderboards_category w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [top: "invalid"],
        [platform: 1],
        [region: 1],
        [emulators: "invalid"],
        ["video-only": "invalid"],
        [timing: 1],
        [timing: "invalid"],
        [date: 1],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1],
        [top: 1, emulators: true, date: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_leaderboards_category(client, "1", "2", params))
      end
    )
  end

  test "get_leaderboards_level w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: ["game"]],
        [embed: ["category"]],
        [embed: ["level"]],
        [embed: ["players"]],
        [embed: ["regions"]],
        [embed: ["platforms"]],
        [embed: ["variables"]],
        [embed: ["game", "category", "level", "players", "regions", "platforms", "variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/leaderboards/1/level/2/3",
                  query: ^params
                }} =
                 SpeedrunClient.get_leaderboards_level(client, "1", "2", "3", params)
      end
    )
  end

  test "get_leaderboards_level w/ invalid options" do
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
        catch_error(SpeedrunClient.get_leaderboards_level(client, "1", "2", "3", params))
      end
    )
  end
end
