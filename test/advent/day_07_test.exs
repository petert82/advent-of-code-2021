defmodule Advent.Day07Test do
  use ExUnit.Case
  doctest Advent.Day07

  import Advent.Day07

  @tag :day07
  test "part1" do
    input = """
    16,1,2,0,4,2,7,1,2,14
    """

    assert part1(input) == 37
  end

  @tag :day07
  test "part2" do
    input = """
    """

    assert part2(input) == nil
  end
end
