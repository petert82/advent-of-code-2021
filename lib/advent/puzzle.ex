defmodule Advent.Puzzle do
  @doc """
  Helper macro to make writing Mix tasks for each part of each day less repetitive.

  `day` is expected to be a day number, with leading zero. `part` is expected to be `"1"` or `"2"`.
  """
  defmacro run_day_part(day, part) do
    module = String.to_existing_atom("Elixir.Advent.Day#{day}")

    quote do
      def run(_args) do
        Advent.Input.read!(unquote(day))
        |> unquote(module).unquote(:"part#{part}")()
        |> IO.inspect(label: "Day #{unquote(day)} Part #{unquote(part)} Results")
      end
    end
  end
end
