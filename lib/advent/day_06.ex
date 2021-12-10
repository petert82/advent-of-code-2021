defmodule Advent.Day06 do
  def part1(input) do
    simulate(input, 80)
  end

  def part2(input) do
    simulate(input, 256)
  end

  defp simulate(input, for_days) do
    start_timers =
      input
      |> String.trim_trailing()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    fish =
      for n <- start_timers, reduce: %{} do
        acc -> Map.update(acc, n, 1, &(&1 + 1))
      end

    end_state =
      for _day <- 1..for_days, reduce: fish do
        acc ->
          %{
            0 => Map.get(acc, 1, 0),
            1 => Map.get(acc, 2, 0),
            2 => Map.get(acc, 3, 0),
            3 => Map.get(acc, 4, 0),
            4 => Map.get(acc, 5, 0),
            5 => Map.get(acc, 6, 0),
            6 => Map.get(acc, 7, 0) + Map.get(acc, 0, 0),
            7 => Map.get(acc, 8, 0),
            8 => Map.get(acc, 0, 0)
          }
      end

    Map.values(end_state) |> Enum.sum()
  end
end
