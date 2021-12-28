defmodule Mix.Tasks.D11.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("11", "1")
end
