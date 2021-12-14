defmodule Advent.Day09 do
  def part1(input) do
    grid = parse(input)

    grid
    |> Enum.filter(fn {coord, value} ->
      is_low_point(value, Map.values(adjacent_points(coord, grid)))
    end)
    |> Enum.map(fn {_coord, value} -> value + 1 end)
    |> Enum.sum()
  end

  def part2(input) do
    grid = parse(input)

    low_points =
      grid
      |> Enum.filter(fn {coord, value} ->
        is_low_point(value, Map.values(adjacent_points(coord, grid)))
      end)

    basins = Enum.map(low_points, &get_basin(elem(&1, 0), grid))

    Enum.map(basins, &length/1)
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.product()
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
    %{
      {x - 1, y} => Map.get(grid, {x - 1, y}),
      {x + 1, y} => Map.get(grid, {x + 1, y}),
      {x, y - 1} => Map.get(grid, {x, y - 1}),
      {x, y + 1} => Map.get(grid, {x, y + 1})
    }
    |> Map.reject(fn {_coord, value} -> value == nil end)
  end

  defp is_low_point(value, compared_to) do
    value < Enum.min(compared_to)
  end

  defp get_basin(around_coord, grid) do
    [around_coord | get_basin([around_coord], grid, MapSet.new())]
  end

  defp get_basin([], _grid, _checked), do: []

  defp get_basin([coord | rest], grid, checked) do
    poss_members = adjacent_points(coord, grid)

    new_members =
      Map.reject(poss_members, fn {coord, value} ->
        value == 9 or MapSet.member?(checked, coord)
      end)
      |> Map.keys()

    checked =
      Map.keys(poss_members)
      |> MapSet.new()
      |> MapSet.union(checked)
      |> MapSet.put(coord)

    new_members ++ get_basin(rest ++ new_members, grid, checked)
  end
end
