defmodule SpeedrunClientTest.Developers do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_developers" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/developers"}} =
             SpeedrunClient.get_developers(client)
  end

  test "get_developers w/ valid options" do
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
                  url: "https://www.speedrun.com/api/v1/developers",
                  query: ^params
                }} =
                 SpeedrunClient.get_developers(client, params)
      end
    )
  end

  test "get_developers w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [direction: "invalid"],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_developers(client, params))
      end
    )
  end

  test "get_developers w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/developers/1"}} =
             SpeedrunClient.get_developers(client, "1")
  end
end
