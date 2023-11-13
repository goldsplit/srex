defmodule SpeedrunClientTest.Runs do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_runs w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [user: "user"],
        [guest: "guest"],
        [examiner: "examiner"],
        [game: "game"],
        [level: "level"],
        [category: "category"],
        [platform: "platform"],
        [region: "region"],
        [emulated: true],
        [emulated: false],
        [status: "new"],
        [status: "verified"],
        [status: "rejected"],
        [orderby: "game"],
        [orderby: "category"],
        [orderby: "level"],
        [orderby: "platform"],
        [orderby: "region"],
        [orderby: "emulated"],
        [orderby: "date"],
        [orderby: "submitted"],
        [orderby: "status"],
        [orderby: "verify-date"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: ["game"]],
        [embed: ["category"]],
        [embed: ["level"]],
        [embed: ["players"]],
        [embed: ["region"]],
        [embed: ["platform"]],
        [embed: ["game", "category", "level", "players", "region", "platform"]],
        [
          user: "user",
          emulated: false,
          status: "verified",
          orderby: "verify-date",
          direction: "asc",
          embed: ["game", "category", "platform"]
        ]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/runs",
                  query: ^params
                }} =
                 SpeedrunClient.get_runs(client, params)
      end
    )
  end

  test "get_runs w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [user: 1],
        [guest: 1],
        [examiner: 1],
        [game: 1],
        [level: 1],
        [category: 1],
        [platform: 1],
        [region: 1],
        [emulated: 1],
        [status: "invalid"],
        [status: 1],
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
        catch_error(SpeedrunClient.get_runs(client, params))
      end
    )
  end

  test "get_runs w/ id and valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/runs/1",
                  query: ^params
                }} =
                 SpeedrunClient.get_runs(client, "1", params)
      end
    )
  end

  test "get_runs w/ id and invalid options" do
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
        catch_error(SpeedrunClient.get_runs(client, "1", params))
      end
    )
  end

  test "post_runs" do
    client = Tesla.client([], Tesla.Mock)
    body = %{"run" => %{"category" => "category"}}

    assert {:ok,
            %{
              method: :post,
              url: "https://www.speedrun.com/api/v1/runs",
              body: ^body
            }} =
             SpeedrunClient.post_runs(client, body)
  end

  test "put_runs_status" do
    client = Tesla.client([], Tesla.Mock)
    body = %{"status" => %{"status" => "verified"}}

    assert {:ok,
            %{
              method: :put,
              url: "https://www.speedrun.com/api/v1/runs/1/status",
              body: ^body
            }} =
             SpeedrunClient.put_runs_status(client, "1", body)
  end

  test "put_runs_players" do
    client = Tesla.client([], Tesla.Mock)
    body = %{"players" => [%{"rel" => "user", "id" => "1"}]}

    assert {:ok,
            %{
              method: :put,
              url: "https://www.speedrun.com/api/v1/runs/1/players",
              body: ^body
            }} =
             SpeedrunClient.put_runs_players(client, "1", body)
  end

  test "delete_runs" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok,
            %{
              method: :delete,
              url: "https://www.speedrun.com/api/v1/runs/1"
            }} =
             SpeedrunClient.delete_runs(client, "1")
  end
end
