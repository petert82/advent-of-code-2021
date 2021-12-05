defmodule Advent.Day03 do
  def part1(input) do
    [gamma_rate, epsilon_rate] =
      input
      |> String.split("\n", trim: true)
      |> bit_frequencies()
      |> Enum.map(fn most_common ->
        if most_common == :one or most_common == :equal do
          ["1", "0"]
        else
          ["0", "1"]
        end
      end)
      |> Enum.zip()
      |> Enum.map(fn bits -> Tuple.to_list(bits) |> binary_digits_to_int() end)

    gamma_rate * epsilon_rate
  end

  def part2(input) do
    lines = String.split(input, "\n", trim: true)

    oxygen_generator_rating =
      find_rating(lines, 0, :most_common)
      |> binary_digits_to_int()

    co2_scrubber_rating =
      find_rating(lines, 0, :least_common)
      |> binary_digits_to_int()

    oxygen_generator_rating * co2_scrubber_rating
  end

  defp find_rating([line], _, _), do: line

  defp find_rating(lines, i, search_for) do
    bit_freqs = bit_frequencies(lines)
    most_common = Enum.at(bit_freqs, i)

    filtered =
      lines
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.filter(fn line_bits ->
        bit = Enum.at(line_bits, i)

        if search_for == :most_common do
          cond do
            bit == "1" and most_common == :one -> true
            bit == "1" and most_common == :equal -> true
            bit == "0" and most_common == :zero -> true
            true -> false
          end
        else
          cond do
            bit == "0" and most_common == :one -> true
            bit == "0" and most_common == :equal -> true
            bit == "1" and most_common == :zero -> true
            true -> false
          end
        end
      end)
      |> Enum.map(&Enum.join/1)

    find_rating(filtered, i + 1, search_for)
  end

  # returns a list indicating - for each bit position in the input lines - which value
  # was most common in that position: :one, :zero, or :equal
  defp bit_frequencies(lines) do
    line_count = length(lines)

    lines
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn bits ->
      freq = Enum.count(bits, &(&1 == "1"))

      cond do
        freq > line_count / 2 -> :one
        freq < line_count / 2 -> :zero
        true -> :equal
      end
    end)
  end

  defp binary_digits_to_int(binary_digits) when is_binary(binary_digits) do
    String.to_integer(binary_digits, 2)
  end

  defp binary_digits_to_int(binary_digits) do
    binary_digits |> Enum.join() |> String.to_integer(2)
  end
end
