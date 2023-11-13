defmodule SpeedrunClientTest.Platforms do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_platforms" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/platforms"}} =
             SpeedrunClient.get_platforms(client)
  end

  test "get_platforms w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [direction: "asc"],
        [direction: "desc"],
        [orderby: "name"],
        [orderby: "released"],
        [direction: "asc", orderby: "name"],
        [direction: "asc", orderby: "released"],
        [direction: "desc", orderby: "name"],
        [direction: "desc", orderby: "released"]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/platforms",
                  query: ^params
                }} =
                 SpeedrunClient.get_platforms(client, params)
      end
    )
  end

  test "get_platforms w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [orderby: "invalid", direction: "asc"],
        [orderby: "name", direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_platforms(client, params))
      end
    )
  end

  test "get_platforms w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/platforms/1"}} =
             SpeedrunClient.get_platforms(client, "1")
  end
end
