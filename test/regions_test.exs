defmodule SpeedrunClientTest.Regions do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_regions" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/regions"}} =
             SpeedrunClient.get_regions(client)
  end

  test "get_regions w/ valid options" do
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
                  url: "https://www.speedrun.com/api/v1/regions",
                  query: ^params
                }} =
                 SpeedrunClient.get_regions(client, params)
      end
    )
  end

  test "get_regions w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_regions(client, params))
      end
    )
  end

  test "get_regions w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/regions/1"}} =
             SpeedrunClient.get_regions(client, "1")
  end
end
