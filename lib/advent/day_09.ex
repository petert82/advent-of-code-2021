defmodule Advent.Day09 do
  def part1(input) do
    grid =
      input
      |> parse()

    grid
    |> Enum.filter(fn {coord, value} ->
      is_low_point(value, adjacent_points(coord, grid))
    end)
    |> Enum.map(fn {_coord, value} -> value + 1 end)
    |> Enum.sum()
  end

  def part2(_input) do
  end

  defp parse(input) do
    lines =
      input
      |> String.split("\n", trim: true)

    for line <- lines, reduce: %{height: 0, width: 0, values: %{}} do
      acc ->
        nums = String.graphemes(line) |> Enum.map(&String.to_integer/1)
        acc = Map.put(acc, :width, length(nums))
        y = Map.get(acc, :height)

        acc =
          Map.update!(acc, :values, fn values ->
            row_values =
              nums
              |> Enum.with_index()
              |> Enum.map(fn {num, x} -> {{x, y}, num} end)
              |> Map.new()

            Map.merge(values, row_values)
          end)

        Map.update!(acc, :height, &(&1 + 1))
    end
    |> Map.get(:values)
  end

  defp adjacent_points({x, y}, grid) do
    [
      Map.get(grid, {x - 1, y}),
      Map.get(grid, {x + 1, y}),
      Map.get(grid, {x, y - 1}),
      Map.get(grid, {x, y + 1})
    ]
    |> Enum.reject(&(&1 == nil))
  end

  defp is_low_point(value, compared_to) do
    value < Enum.min(compared_to)
  end
end
