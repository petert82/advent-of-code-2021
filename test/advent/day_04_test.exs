defmodule Advent.Day04Test do
  use ExUnit.Case
  doctest Advent.Day04

  import Advent.Day04

  @tag :day04
  test "can parse input" do
    input = """
    7,4,9,5,11,17

    22 13 17 11  0
    8  2 23  4 24
    21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19

    3 15  0  2 22
    9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6
    """

    bingo = Advent.Day04.Bingo.parse(input)

    expect = %Advent.Day04.Bingo{
      draw: [7, 4, 9, 5, 11, 17],
      boards: [
        %Advent.Day04.Board{
          nums:
            MapSet.new([
              22,
              13,
              17,
              11,
              0,
              8,
              2,
              23,
              4,
              24,
              21,
              9,
              14,
              16,
              7,
              6,
              10,
              3,
              18,
              5,
              1,
              12,
              20,
              15,
              19
            ]),
          runs: [
            MapSet.new([22, 13, 17, 11, 0]),
            MapSet.new([8, 2, 23, 4, 24]),
            MapSet.new([21, 9, 14, 16, 7]),
            MapSet.new([6, 10, 3, 18, 5]),
            MapSet.new([1, 12, 20, 15, 19]),
            MapSet.new([22, 8, 21, 6, 1]),
            MapSet.new([13, 2, 9, 10, 12]),
            MapSet.new([17, 23, 14, 3, 20]),
            MapSet.new([11, 4, 16, 18, 15]),
            MapSet.new([0, 24, 7, 5, 19])
          ]
        },
        %Advent.Day04.Board{
          nums:
            MapSet.new([
              3,
              15,
              0,
              2,
              22,
              9,
              18,
              13,
              17,
              5,
              19,
              8,
              7,
              25,
              23,
              20,
              11,
              10,
              24,
              4,
              14,
              21,
              16,
              12,
              6
            ]),
          runs: [
            MapSet.new([3, 15, 0, 2, 22]),
            MapSet.new([9, 18, 13, 17, 5]),
            MapSet.new([19, 8, 7, 25, 23]),
            MapSet.new([20, 11, 10, 24, 4]),
            MapSet.new([14, 21, 16, 12, 6]),
            MapSet.new([3, 9, 19, 20, 14]),
            MapSet.new([15, 18, 8, 11, 21]),
            MapSet.new([0, 13, 7, 10, 16]),
            MapSet.new([2, 17, 25, 24, 12]),
            MapSet.new([22, 5, 23, 4, 6])
          ]
        }
      ],
      played_nums: []
    }

    assert bingo == expect
  end

  @tag :day04
  test "part1" do
    input = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
    8  2 23  4 24
    21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19

    3 15  0  2 22
    9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
    2  0 12  3  7
    """

    assert part1(input) == 4512
  end

  @tag :day04
  test "part2" do
    input = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
    8  2 23  4 24
    21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19

    3 15  0  2 22
    9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
    2  0 12  3  7
    """

    assert part2(input) == 1924
  end
end
