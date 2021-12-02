defmodule Advent.Day02 do
  def part1(input) do
    {pos, depth} =
      String.split(input, "\n", trim: true)
      |> Enum.reduce({0, 0}, &parse_part1_command/2)

    pos * depth
  end

  defp parse_part1_command("forward " <> n, {pos, depth}) do
    # forward X increases the horizontal position by X units.
    {pos + String.to_integer(n), depth}
  end

  defp parse_part1_command("down " <> n, {pos, depth}) do
    # down X increases the depth by X units.
    {pos, depth + String.to_integer(n)}
  end

  defp parse_part1_command("up " <> n, {pos, depth}) do
    # up X decreases the depth by X units.
    {pos, depth - String.to_integer(n)}
  end

  def part2(input) do
    {pos, depth, _aim} =
      String.split(input, "\n", trim: true)
      |> Enum.reduce({0, 0, 0}, &parse_part2_command/2)

    pos * depth
  end

  defp parse_part2_command("forward " <> n, {pos, depth, aim}) do
    # forward X does two things:
    # - It increases your horizontal position by X units.
    # - It increases your depth by your aim multiplied by X.
    delta = String.to_integer(n)
    {pos + delta, depth + aim * delta, aim}
  end

  defp parse_part2_command("down " <> n, {pos, depth, aim}) do
    # down X increases your aim by X units
    {pos, depth, aim + String.to_integer(n)}
  end

  defp parse_part2_command("up " <> n, {pos, depth, aim}) do
    # up X decreases your aim by X units
    {pos, depth, aim - String.to_integer(n)}
  end
end
