defmodule Advent.Day09Test do
  use ExUnit.Case
  doctest Advent.Day09

  import Advent.Day09

  @tag :day09
  test "part1" do
    input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    assert part1(input) == 15
  end

  @tag :day09
  test "part2" do
    input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    assert part2(input) == 1134
  end
end
