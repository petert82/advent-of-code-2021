defmodule Advent.Day07 do
  def part1(input) do
    solve(input, &calc_part1_fuel_use/2)
  end

  def part2(input) do
    solve(input, &calc_part2_fuel_use/2)
  end

  defp solve(input, fuel_fn) do
    nums =
      String.trim_trailing(input)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {min, max} = Enum.min_max(nums)

    possible_fuel_costs =
      for pos <- min..max,
          costs = fuel_fn.(nums, pos),
          sum = Enum.sum(costs) do
        sum
      end

    Enum.min(possible_fuel_costs)
  end

  defp calc_part1_fuel_use(nums, pos) do
    Enum.map(nums, fn cur_pos -> abs(cur_pos - pos) end)
  end

  defp calc_part2_fuel_use(nums, pos) do
    Enum.map(nums, fn cur_pos ->
      dist = abs(cur_pos - pos)
      Enum.sum(0..dist)
    end)
  end
end
