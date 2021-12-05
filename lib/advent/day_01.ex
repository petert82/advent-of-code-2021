defmodule Advent.Day01 do
  def part1(input) do
    String.split(input)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({nil, 0}, &increase_check/2)
    |> elem(1)
  end

  def part2(input) do
    String.split(input)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce({nil, 0}, &increase_check/2)
    |> elem(1)
  end

  defp increase_check(n, {nil, 0}), do: {n, 0}
  defp increase_check(n, {prev, count}) when n > prev, do: {n, count + 1}
  defp increase_check(n, {_prev, count}), do: {n, count}
end
