defmodule Advent.Day08 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map(fn {_input, output} ->
      Enum.map(output, &decode_easy_digit/1)
      |> Enum.reject(&(elem(&1, 0) == :unknown))
      |> length()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&decode_line/1)
    |> Enum.sum()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [input, output] =
      String.split(line, " | ")
      |> Enum.map(fn line_part ->
        String.split(line_part, " ", trim: true)
        |> Enum.map(&string_to_set/1)
      end)

    {input, output}
  end

  defp string_to_set(digit_string) do
    String.graphemes(digit_string)
    |> MapSet.new()
  end

  # one, four and seven can be worked out just from the number of
  # segments that are lit
  defp decode_easy_digit(digit_set) do
    case MapSet.size(digit_set) do
      2 -> {:one, digit_set}
      3 -> {:seven, digit_set}
      4 -> {:four, digit_set}
      7 -> {:eight, digit_set}
      _ -> {:unknown, digit_set}
    end
  end

  defp decode_line({input, output}) do
    {known, unknown} =
      input
      |> Enum.map(&decode_easy_digit/1)
      |> Keyword.split([:one, :seven, :four, :eight])

    unknown_6_long = unknown |> Enum.map(&elem(&1, 1)) |> Enum.filter(&(MapSet.size(&1) == 6))
    known = known ++ decode_six_segment_digits(unknown_6_long, known)

    unknown_5_long = unknown |> Enum.map(&elem(&1, 1)) |> Enum.filter(&(MapSet.size(&1) == 5))
    known = known ++ decode_five_segment_digits(unknown_5_long, known)

    decode_output(output, known)
  end

  defp decode_six_segment_digits(digits, known_digits) do
    for digit <- digits,
        one_intersection = MapSet.intersection(digit, known_digits[:one]),
        four_intersection = MapSet.intersection(digit, known_digits[:four]) do
      cond do
        MapSet.size(one_intersection) == 1 -> {:six, digit}
        MapSet.size(four_intersection) == 3 -> {:zero, digit}
        true -> {:nine, digit}
      end
    end
  end

  defp decode_five_segment_digits(digits, known_digits) do
    for digit <- digits,
        one_intersection = MapSet.intersection(digit, known_digits[:one]),
        nine_intersection = MapSet.intersection(digit, known_digits[:nine]) do
      cond do
        MapSet.size(one_intersection) == 2 -> {:three, digit}
        MapSet.size(nine_intersection) == 5 -> {:five, digit}
        true -> {:two, digit}
      end
    end
  end

  defp decode_output(output, known_digits) do
    output
    |> Enum.map(&decode_output_digit(&1, known_digits))
    |> Enum.join()
    |> String.to_integer()
  end

  defp decode_output_digit(digit, known_digits) do
    cond do
      MapSet.equal?(digit, known_digits[:zero]) -> "0"
      MapSet.equal?(digit, known_digits[:one]) -> "1"
      MapSet.equal?(digit, known_digits[:two]) -> "2"
      MapSet.equal?(digit, known_digits[:three]) -> "3"
      MapSet.equal?(digit, known_digits[:four]) -> "4"
      MapSet.equal?(digit, known_digits[:five]) -> "5"
      MapSet.equal?(digit, known_digits[:six]) -> "6"
      MapSet.equal?(digit, known_digits[:seven]) -> "7"
      MapSet.equal?(digit, known_digits[:eight]) -> "8"
      MapSet.equal?(digit, known_digits[:nine]) -> "9"
    end
  end
end
