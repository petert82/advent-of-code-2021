defmodule Mix.Tasks.D08.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("08", "1")
end
