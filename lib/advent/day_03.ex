defmodule Advent.Day03 do
  def part1(input) do
    lines = String.split(input, "\n", trim: true)

    # each element here is a count of how often the bit in the corresponding
    # position in each input line was set to 1
    freq_1s =
      lines
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn bits -> Enum.count(bits, &(&1 == "1")) end)

    line_count = length(lines)

    [gamma_rate, epsilon_rate] =
      freq_1s
      |> Enum.map(fn freq ->
        if freq >= line_count / 2 do
          ["1", "0"]
        else
          ["0", "1"]
        end
      end)
      |> Enum.zip()
      |> Enum.map(fn bits -> Tuple.to_list(bits) |> Enum.join() |> String.to_integer(2) end)

    gamma_rate * epsilon_rate
  end

  def part2(_input) do
  end
end
