defmodule Advent.Day07 do
  def part1(input) do
    nums =
      String.trim_trailing(input)
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {min, max} = Enum.min_max(nums)

    possible_fuel_costs =
      for pos <- min..max,
          costs = calc_fuel_use(nums, pos),
          sum = Enum.sum(costs) do
        sum
      end

    Enum.min(possible_fuel_costs)
  end

  def part2(_input) do
  end

  defp calc_fuel_use(nums, pos) do
    Enum.map(nums, fn cur_pos -> abs(cur_pos - pos) end)
  end
end
