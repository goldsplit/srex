defmodule SpeedrunClientTest.Guests do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_guests w/ name" do
    client = Tesla.client([], Tesla.Mock)

    assert {:ok, %{method: :get, url: "https://www.speedrun.com/api/v1/guests/1"}} =
             SpeedrunClient.get_guests(client, "1")
  end
end
