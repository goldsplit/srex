defmodule SpeedrunClientTest.Engines do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_engines" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/engines"}} =
             SpeedrunClient.get_engines(client)
  end

  test "get_engines w/ valid options" do
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
                  url: "https://www.speedrun.com/api/v1/engines",
                  query: ^params
                }} =
                 SpeedrunClient.get_engines(client, params)
      end
    )
  end

  test "get_engines w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_engines(client, params))
      end
    )
  end

  test "get_engines w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/engines/1"}} =
             SpeedrunClient.get_engines(client, "1")
  end
end
