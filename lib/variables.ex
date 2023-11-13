defmodule SpeedrunClient.Variables do
  @moduledoc """
  Variables are custom criteria to distinguish between runs done in the same category or level. The speed in Mario Kart games (which can be 50cc, 100cc or 150cc) is an example for a variable that has 3 possible values.

  Variables are defined per-game and can be applicable to either all runs for this game or just full-game or individual-level (IL) runs. Variables can also be restricted to a category. It is therefore important to understand how to get the correct set of variables:

  - Use `GET /game/<id>/variables` to get all defined variables of that game, no matter how they are configured.
  - Use `GET /categories/<id>/variables` to only get the variables that apply to the given category.
  - Use `GET /levels/<id>/variables` to only get the variables that apply to the given level.
  """
  defmacro __using__(_opts) do
    quote do
      @doc """
      """
      @spec get_variables(Tesla.Env.client(), String.t()) :: Tesla.Env.result()
      def get_variables(client, id) do
        get(client, "/variables/" <> id)
      end
    end
  end
end
