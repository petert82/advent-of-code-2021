defmodule Mix.Tasks.D05.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("05", "1")
end
