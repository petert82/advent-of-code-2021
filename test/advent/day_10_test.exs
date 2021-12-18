defmodule Advent.Day10Test do
  use ExUnit.Case
  doctest Advent.Day10

  import Advent.Day10

  @input """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  @tag :day10
  test "part1" do
    assert part1(@input) == 26397
  end

  @tag :day10
  test "part2" do
    assert part2(@input) == nil
  end
end
