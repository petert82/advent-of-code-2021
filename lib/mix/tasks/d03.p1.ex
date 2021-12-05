defmodule Mix.Tasks.D03.P1 do
  use Mix.Task
  require Advent.Puzzle

  Advent.Puzzle.run_day_part("03", "1")
end
