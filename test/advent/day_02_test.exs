defmodule Advent.Day02Test do
  use ExUnit.Case
  doctest Advent.Day02

  import Advent.Day02

  @tag :day02
  test "part1" do
    input = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """

    assert part1(input) == 150
  end
end
