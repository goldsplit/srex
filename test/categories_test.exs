defmodule SpeedrunClientTest.Categories do
  use ExUnit.Case, async: true

  setup do
    Tesla.Mock.mock(fn env -> env end)
    :ok
  end

  test "get_categories w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [embed: []],
        [embed: ["game"]],
        [embed: ["variables"]],
        [embed: ["game", "variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/categories/1",
                  query: ^params
                }} =
                 SpeedrunClient.get_categories(client, "1", params)
      end
    )
  end

  test "get_categories w/ invalid options" do
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
        catch_error(SpeedrunClient.get_categories(client, params))
      end
    )
  end

  test "get_categories_variables w/ valid options" do
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
        [embed: []],
        [embed: ["game"]],
        [embed: ["variables"]],
        [embed: ["game", "variables"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/categories/1/variables",
                  query: ^params
                }} =
                 SpeedrunClient.get_categories_variables(client, "1", params)
      end
    )
  end

  test "get_categories_variables w/ invalid options" do
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
        catch_error(SpeedrunClient.get_categories_variables(client, params))
      end
    )
  end

  test "get_categories_records w/ valid options" do
    client = Tesla.client([], Tesla.Mock)

    query_params =
      [
        [],
        [top: 1],
        ["skip-empty": true],
        ["skip-empty": false],
        [embed: []],
        [embed: ["game"]],
        [embed: ["variables"]],
        [embed: ["game", "variables"]],
        [top: 1, "skip-empty": false, embed: ["game"]]
      ]

    Enum.map(
      query_params,
      fn params ->
        assert {:ok,
                %{
                  method: :get,
                  url: "https://www.speedrun.com/api/v1/categories/1/records",
                  query: ^params
                }} =
                 SpeedrunClient.get_categories_records(client, "1", params)
      end
    )
  end

  test "get_categories_records w/ invalid options" do
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
        catch_error(SpeedrunClient.get_categories_records(client, params))
      end
    )
  end
end
