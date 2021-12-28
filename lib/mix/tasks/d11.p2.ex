defmodule Mix.Tasks.D11.P2 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("11", "2")
end
