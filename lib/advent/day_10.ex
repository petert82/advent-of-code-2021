defmodule Advent.Day10 do
  @openers %{")" => "(", "]" => "[", "}" => "{", ">" => "<"}

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&is_error/1)
    |> Enum.map(fn {:error, char} -> score(char) end)
    |> Enum.sum()
  end

  def part2(_input) do
  end

  defp parse_line(line) do
    parse(String.graphemes(line), [], [])
  end

  defp parse([], parsed, _stack), do: Enum.reverse(parsed)

  defp parse([char | _rest] = chars, parsed, stack) do
    cond do
      is_open(char) -> parse_open(chars, parsed, stack)
      is_close(char) -> parse_close(chars, parsed, stack)
      true -> {:error, char}
    end
  end

  defp parse_open([char | rest], parsed, stack) do
    parse(rest, [char | parsed], [char | stack])
  end

  defp parse_close([char | rest], parsed, [stack_head | stack_rest]) do
    need = Map.fetch!(@openers, char)

    if stack_head == need do
      parse(rest, [char | parsed], stack_rest)
    else
      {:error, char}
    end
  end

  defp is_open("("), do: true
  defp is_open("["), do: true
  defp is_open("{"), do: true
  defp is_open("<"), do: true
  defp is_open(_), do: false

  defp is_close(")"), do: true
  defp is_close("]"), do: true
  defp is_close("}"), do: true
  defp is_close(">"), do: true
  defp is_close(_), do: false

  defp is_error({:error, _}), do: true
  defp is_error(_), do: false

  defp score(")"), do: 3
  defp score("]"), do: 57
  defp score("}"), do: 1197
  defp score(">"), do: 25137
end
