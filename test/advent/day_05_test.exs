defmodule Advent.Day05Test do
  use ExUnit.Case
  doctest Advent.Day05

  import Advent.Day05

  @tag :day05
  test "part1" do
    input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    assert part1(input) == 5
  end

  @tag :day05
  test "part2" do
    input = """
    """

    assert part2(input) == nil
  end
end
