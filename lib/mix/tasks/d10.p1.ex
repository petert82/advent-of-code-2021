defmodule Mix.Tasks.D10.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("10", "1")
end
