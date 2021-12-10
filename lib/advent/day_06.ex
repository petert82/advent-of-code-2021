defmodule Advent.Day06 do
  def part1(input) do
    start_state =
      input
      |> String.trim_trailing()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    end_state =
      for _day <- 1..80, reduce: start_state do
        acc -> Enum.reduce(acc, [], &simulate/2)
      end

    length(end_state)
  end

  def part2(_input) do
  end

  defp simulate(0, acc), do: [6, 8] ++ acc
  defp simulate(timer, acc), do: [timer - 1 | acc]
end
