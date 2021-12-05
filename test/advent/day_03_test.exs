defmodule Advent.Day03Test do
  use ExUnit.Case
  doctest Advent.Day03

  import Advent.Day03

  @tag :day03
  test "part1" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    assert part1(input) == 198
  end

  @tag :day03
  test "part2" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    assert part2(input) == 230
  end
end
