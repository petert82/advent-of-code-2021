defmodule Mix.Tasks.D10.P2 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("10", "2")
end
