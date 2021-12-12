defmodule Mix.Tasks.D09.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("09", "1")
end
