defmodule SpeedrunClientTest.Profile do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_profile" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/profile"}} =
             SpeedrunClient.get_profile(client)
  end
end
