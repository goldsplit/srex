defmodule SpeedrunClient do
  @moduledoc """
  Documentation for an unofficial speedrun.com API client.

  Official REST API documentation can be found at [https://github.com/speedruncomorg/api](https://github.com/speedruncomorg/api)
  """
  use Tesla
  adapter(Tesla.Adapter.Mint)
  plug(Tesla.Middleware.BaseUrl, "https://www.speedrun.com/api/v1")
  plug(Tesla.Middleware.JSON)

  use SpeedrunClient.Categories
  use SpeedrunClient.Developers
  use SpeedrunClient.Engine
  use SpeedrunClient.Games
  use SpeedrunClient.Gametypes
  use SpeedrunClient.Genres
  use SpeedrunClient.Guests
  use SpeedrunClient.Leaderboards
  use SpeedrunClient.Levels
  use SpeedrunClient.Notifications
  use SpeedrunClient.Platforms
  use SpeedrunClient.Profile
  use SpeedrunClient.Publishers
  use SpeedrunClient.Regions
  use SpeedrunClient.Runs
  use SpeedrunClient.Series
  use SpeedrunClient.Users
  use SpeedrunClient.Variables

  @doc """
  Create a new client. Can optionally provided an API key which is require by some endpoints.

  See [Official Authentication Documentation](https://github.com/speedruncomorg/api/blob/master/authentication.md) for instructions on how to create an API key.

  ## Examples

    iex> SpeedrunClient.new()
    %Tesla.Client{
      fun: nil,
      pre: [],
      post: [],
      adapter: {Tesla.Adapter.Mint, :call, [[]]}
      }

    iex> SpeedrunClient.new("my-api-key")
    %Tesla.Client{
      fun: nil,
      pre: [{Tesla.Middleware.Headers, :call, [[{"X-API-Key", "my-api-key"}]]}],
      post: [],
      adapter: {Tesla.Adapter.Mint, :call, [[]]}
      }
  """
  @spec new(String.t()) :: Tesla.Env.client()
  def new(apikey \\ "") do
    case apikey do
      "" ->
        Tesla.client([], Tesla.Adapter.Mint)

      apikey ->
        Tesla.client(
          [
            {Tesla.Middleware.Headers, [{"X-API-Key", apikey}]}
          ],
          Tesla.Adapter.Mint
        )
    end
  end
end
