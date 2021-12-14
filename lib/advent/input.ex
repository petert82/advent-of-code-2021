defmodule Advent.Input do
  @moduledoc """
  Allows puzzle input for each day to be placed in files under the project's "input" directory.
  """

  @doc """
  Gets the input for a puzzle from a file in the "input" directory.

  Input files are expected to be named following the pattern: `"day" + [day_num]`

  For example, the input for day one should be in a file called "day01".
  """
  def read!(suffix) do
    input_file = Path.join([input_root() <> "/day" <> suffix])

    if File.exists?(input_file) do
      File.open!(input_file, [:read, :utf8])
      |> IO.read(:eof)
    else
      raise "Input file '#{input_file}' does not exist"
    end
  end

  defp input_root() do
    # TODO: add default input_path/error if unset
    Application.get_env(:aoc2021, __MODULE__)
    |> Keyword.get(:input_path)
  end
end
