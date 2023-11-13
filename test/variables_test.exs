defmodule SpeedrunClientTest.Variables do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_variables w/ id" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/variables/1"}} =
             SpeedrunClient.get_variables(client, "1")
  end
end
