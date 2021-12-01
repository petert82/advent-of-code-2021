defmodule Mix.Tasks.D01.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("01", "1")
end
