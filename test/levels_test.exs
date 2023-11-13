defmodule SpeedrunClientTest.Levels do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_levels w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: ["categories"]],
        [embed: ["variables"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["categories", "categories.game", "categories.variables", "variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/levels/1",
                  query: ^params
                }} =
                 SpeedrunClient.get_levels(client, "1", params)
      end
    )
  end

  test "get_levels w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_levels(client, "1", params))
      end
    )
  end

  test "get_levels_categories w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [miscellaneous: true],
        [miscellaneous: false],
        [orderby: "name"],
        [orderby: "miscellaneous"],
        [orderby: "pos"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: ["categories"]],
        [embed: ["variables"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["categories", "categories.game", "categories.variables", "variables"]],
        [
          miscellaneous: true,
          orderby: "name",
          direction: "desc",
          embed: ["categories", "variables"]
        ]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/levels/1/categories",
                  query: ^params
                }} =
                 SpeedrunClient.get_levels_categories(client, "1", params)
      end
    )
  end

  test "get_levels_categories w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [miscellaneous: 1],
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_levels_categories(client, "1", params))
      end
    )
  end

  test "get_levels_variables w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [orderby: "name"],
        [orderby: "mandatory"],
        [orderby: "user-defined"],
        [orderby: "pos"],
        [direction: "asc"],
        [direction: "desc"],
        [embed: ["categories"]],
        [embed: ["variables"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["categories", "categories.game", "categories.variables", "variables"]],
        [orderby: "mandatory", direction: "asc", embed: ["categories", "variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/levels/1/variables",
                  query: ^params
                }} =
                 SpeedrunClient.get_levels_variables(client, "1", params)
      end
    )
  end

  test "get_levels_variables w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [orderby: 1],
        [orderby: "invalid"],
        [direction: 1],
        [direction: "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_levels_variables(client, "1", params))
      end
    )
  end

  test "get_levels_records w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [top: 1],
        ["skip-empty": true],
        ["skip-empty": false],
        [embed: ["categories"]],
        [embed: ["variables"]],
        [embed: ["categories.game"]],
        [embed: ["categories.variables"]],
        [embed: ["categories", "categories.game", "categories.variables", "variables"]],
        [top: 1, "skip-empty": false, embed: ["categories"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/levels/1/records",
                  query: ^params
                }} =
                 SpeedrunClient.get_levels_records(client, "1", params)
      end
    )
  end

  test "get_levels_records w/ invalid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [top: "invalid"],
        ["skip-empty": "invalid"],
        [embed: "bad_embed"],
        [embed: ["bad_embed"]],
        [bad_option: 1]
      ]

    Enum.map(
      query_params,
      fn params ->
        catch_error(SpeedrunClient.get_levels_records(client, "1", params))
      end
    )
  end
end
