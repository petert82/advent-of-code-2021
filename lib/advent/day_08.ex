defmodule Advent.Day08 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(fn {_input, output} ->
      Enum.map(output, &output_digit_to_easy_digit/1)
      |> Enum.reject(&(elem(&1, 0) == :unknown))
      |> length()
    end)
    |> Enum.sum()
  end

  def part2(_input) do
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [input, output] =
      String.split(line, " | ")
      |> Enum.map(&String.split(&1, " ", trim: true))

    {input, output}
  end

  defp output_digit_to_easy_digit(output_digit) do
    case String.length(output_digit) do
      2 -> {:one, output_digit}
      3 -> {:seven, output_digit}
      4 -> {:four, output_digit}
      7 -> {:eight, output_digit}
      _ -> {:unknown, output_digit}
    end
  end
end
