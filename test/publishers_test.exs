defmodule SpeedrunClientTest.Publishers do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_publishers" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/publishers"}} =
             SpeedrunClient.get_publishers(client)
  end

  test "get_publishers w/ valid options" do
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
                  url: "https://www.speedrun.com/api/v1/publishers",
                  query: ^params
                }} =
                 SpeedrunClient.get_publishers(client, params)
      end
    )
  end

  test "get_publishers w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_publishers(client, params))
      end
    )
  end

  test "get_publishers w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/publishers/1"}} =
             SpeedrunClient.get_publishers(client, "1")
  end
end
