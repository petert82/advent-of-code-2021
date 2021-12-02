defmodule Advent.Day02 do
  def part1(input) do
    {pos, depth} =
      String.split(input, "\n", trim: true)
      |> Enum.reduce({0, 0}, &parse_command/2)

    pos * depth
  end

  defp parse_command("forward " <> n, {pos, depth}) do
    {pos + String.to_integer(n), depth}
  end

  defp parse_command("down " <> n, {pos, depth}) do
    {pos, depth + String.to_integer(n)}
  end

  defp parse_command("up " <> n, {pos, depth}) do
    {pos, depth - String.to_integer(n)}
  end

  def part2(_input) do
  end
end
