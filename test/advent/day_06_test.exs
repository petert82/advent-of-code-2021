defmodule Advent.Day06Test do
  use ExUnit.Case
  doctest Advent.Day06

  import Advent.Day06

  @tag :day06
  test "part1" do
    input = """
    3,4,3,1,2
    """

    assert part1(input) == 5934
  end

  @tag :day06
  test "part2" do
    input = """
    """

    assert part2(input) == nil
  end
end
