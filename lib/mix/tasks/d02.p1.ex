defmodule Mix.Tasks.D02.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("02", "1")
end
