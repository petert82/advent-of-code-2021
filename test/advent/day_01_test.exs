defmodule Advent.Day01Test do
  use ExUnit.Case
  doctest Advent.Day01

  import Advent.Day01

  @tag :day01
  test "part1" do
    input = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """

    assert part1(input) == 7
  end

  @tag :day01
  test "part2" do
    input = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """

    assert part2(input) == 5
  end
end
