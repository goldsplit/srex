defmodule SpeedrunClientTest.Embeddings do
  use ExUnit.Case, async: true
  doctest SpeedrunClient.Embeddings

  test "invalid embedding key" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("invalid") == MapSet.new([])
  end

  test "0-depth embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("runs", 0) == MapSet.new([])
  end

  test "1-depth categories embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("categories", 1) ==
             MapSet.new(["game", "variables"])
  end

  test "1-depth games embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("games", 1) ==
             MapSet.new([
               "levels",
               "categories",
               "moderators",
               "gametypes",
               "platforms",
               "regions",
               "genres",
               "engines",
               "developers",
               "publishers",
               "variables"
             ])
  end

  test "1-depth leaderboards embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("leaderboards", 1) ==
             MapSet.new([
               "game",
               "category",
               "level",
               "players",
               "regions",
               "platforms",
               "variables"
             ])
  end

  test "1-depth levels embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("levels", 1) ==
             MapSet.new(["categories", "variables"])
  end

  test "1-depth runs embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("runs", 1) ==
             MapSet.new(["game", "category", "level", "players", "region", "platform"])
  end

  test "1-depth series embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("series", 1) ==
             MapSet.new(["moderators"])
  end

  test "2-depth categories embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("categories", 2) ==
             MapSet.new(["game", "variables"])
  end

  test "2-depth games embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("games", 2) ==
             MapSet.new([
               "levels",
               "levels.categories",
               "levels.variables",
               "categories",
               "categories.game",
               "categories.variables",
               "moderators",
               "gametypes",
               "platforms",
               "regions",
               "genres",
               "engines",
               "developers",
               "publishers",
               "variables"
             ])
  end

  test "2-depth leaderboards embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("leaderboards", 2) ==
             MapSet.new([
               "game",
               "category",
               "level",
               "players",
               "regions",
               "platforms",
               "variables"
             ])
  end

  test "2-depth levels embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("levels", 2) ==
             MapSet.new(["categories", "categories.game", "categories.variables", "variables"])
  end

  test "2-depth runs embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("runs", 2) ==
             MapSet.new(["game", "category", "level", "players", "region", "platform"])
  end

  test "2-depth series embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("series", 2) ==
             MapSet.new(["moderators"])
  end

  test "3-depth games embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("games", 3) ==
             MapSet.new([
               "levels",
               "levels.categories",
               "levels.categories.game",
               "levels.categories.variables",
               "levels.variables",
               "categories",
               "categories.game",
               "categories.variables",
               "moderators",
               "gametypes",
               "platforms",
               "regions",
               "genres",
               "engines",
               "developers",
               "publishers",
               "variables"
             ])
  end

  test "3-depth levels embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("levels", 3) ==
             MapSet.new(["categories", "categories.game", "categories.variables", "variables"])
  end

  test "4-depth games embeddings" do
    assert SpeedrunClient.Embeddings.generate_valid_embeddings("games", 4) ==
             MapSet.new([
               "levels",
               "levels.categories",
               "levels.categories.game",
               "levels.categories.variables",
               "levels.variables",
               "categories",
               "categories.game",
               "categories.variables",
               "moderators",
               "gametypes",
               "platforms",
               "regions",
               "genres",
               "engines",
               "developers",
               "publishers",
               "variables"
             ])
  end
end
