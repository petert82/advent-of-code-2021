defmodule Advent.Day10 do
  @openers %{")" => "(", "]" => "[", "}" => "{", ">" => "<"}
  @closers %{"(" => ")", "[" => "]", "{" => "}", "<" => ">"}

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&is_error/1)
    |> Enum.map(fn {:error, char} -> score_part1(char) end)
    |> Enum.sum()
  end

  def part2(input) do
    scores =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_line/1)
      |> Enum.reject(&is_error/1)
      |> Enum.map(fn line ->
        line
        |> complete_line()
        |> Enum.reduce(0, fn char, acc -> acc * 5 + score_part2(char) end)
      end)
      |> Enum.sort()

    # Get the middle score
    scores
    |> Enum.drop(trunc(length(scores) / 2))
    |> hd()
  end

  defp parse_line(line) do
    parse(String.graphemes(line), [])
  end

  defp parse([], stack), do: stack

  defp parse([char | _rest] = chars, stack) do
    cond do
      is_opener(char) -> parse_opener(chars, stack)
      is_closer(char) -> parse_closer(chars, stack)
      true -> {:error, char}
    end
  end

  defp parse_opener([char | rest], stack) do
    parse(rest, [char | stack])
  end

  defp parse_closer([char | rest], [stack_head | stack_rest]) do
    need = Map.fetch!(@openers, char)

    if stack_head == need do
      parse(rest, stack_rest)
    else
      {:error, char}
    end
  end

  defp complete_line(stack), do: complete_line(stack, [])
  defp complete_line([], result), do: Enum.reverse(result)

  defp complete_line([stack_head | rest], result) do
    complete_line(rest, [Map.fetch!(@closers, stack_head) | result])
  end

  defp is_opener("("), do: true
  defp is_opener("["), do: true
  defp is_opener("{"), do: true
  defp is_opener("<"), do: true
  defp is_opener(_), do: false

  defp is_closer(")"), do: true
  defp is_closer("]"), do: true
  defp is_closer("}"), do: true
  defp is_closer(">"), do: true
  defp is_closer(_), do: false

  defp is_error({:error, _}), do: true
  defp is_error(_), do: false

  defp score_part1(")"), do: 3
  defp score_part1("]"), do: 57
  defp score_part1("}"), do: 1197
  defp score_part1(">"), do: 25137

  defp score_part2(")"), do: 1
  defp score_part2("]"), do: 2
  defp score_part2("}"), do: 3
  defp score_part2(">"), do: 4
end
