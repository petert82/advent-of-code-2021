defmodule Advent.Day05 do
  def part1(input) do
    count_overlapping_points(input, &is_not_diagonal/1)
  end

  def part2(input) do
    count_overlapping_points(input, fn _ -> true end)
  end

  defp count_overlapping_points(input, filter_fn) do
    input
    |> parse()
    |> Enum.filter(filter_fn)
    |> plot_lines()
    |> Enum.filter(fn {_pt, count} -> count > 1 end)
    |> length()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    # 0,9 -> 5,9
    regex = ~r/(?<x1>\d+),(?<y1>\d+) \-> (?<x2>\d+),(?<y2>\d+)/
    parts = Regex.named_captures(regex, line)

    %{
      start: {String.to_integer(parts["x1"]), String.to_integer(parts["y1"])},
      end: {String.to_integer(parts["x2"]), String.to_integer(parts["y2"])}
    }
  end

  defp is_not_diagonal(%{start: {x, _y1}, end: {x, _y2}}), do: true
  defp is_not_diagonal(%{start: {_x1, y}, end: {_x2, y}}), do: true
  defp is_not_diagonal(_), do: false

  defp plot_lines(lines) do
    points =
      lines
      |> Enum.map(&line_points/1)
      |> Enum.concat()

    for p <- points, reduce: %{} do
      acc -> Map.update(acc, p, 1, &(&1 + 1))
    end
  end

  defp line_points(%{start: {x, y1}, end: {x, y2}}) do
    for y <- y1..y2, do: {x, y}
  end

  defp line_points(%{start: {x1, y}, end: {x2, y}}) do
    for x <- x1..x2, do: {x, y}
  end

  defp line_points(%{start: {x1, y1}, end: {x2, y2}}) do
    Enum.zip([x1..x2, y1..y2])
  end
end
