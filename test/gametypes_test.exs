defmodule SpeedrunClientTest.Gametypes do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_gametypes" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/gametypes"}} =
             SpeedrunClient.get_gametypes(client)
  end

  test "get_gametypes w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [direction: "asc"],
        [direction: "desc"]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/gametypes",
                  query: ^params
                }} =
                 SpeedrunClient.get_gametypes(client, params)
      end
    )
  end

  test "get_gametypes w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_gametypes(client, params))
      end
    )
  end

  test "get_gametypes w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/gametypes/1"}} =
             SpeedrunClient.get_gametypes(client, "1")
  end
end
