defmodule Advent.Day04.Board do
  # 00 01 02 03 04
  # 50 06 07 08 09
  # 10 11 12 13 14
  # 15 16 17 18 19
  # 20 21 22 23 24
  defstruct nums: nil, runs: nil

  def new(num_list) do
    rows_lists = Enum.chunk_every(num_list, 5)
    rows = Enum.map(rows_lists, &MapSet.new/1)
    cols = Enum.zip(rows_lists) |> Enum.map(fn row -> Tuple.to_list(row) |> MapSet.new() end)

    %Advent.Day04.Board{
      nums: MapSet.new(num_list),
      runs: rows ++ cols
    }
  end

  def find_winning_run(%__MODULE__{} = board, played_nums) do
    board.runs
    |> Enum.find(fn run -> MapSet.subset?(run, played_nums) end)
  end

  def score(%__MODULE__{nums: nums}, played_nums) do
    last_num = hd(played_nums)
    unmarked_nums = MapSet.difference(nums, MapSet.new(played_nums))
    last_num * Enum.sum(unmarked_nums)
  end
end

defmodule Advent.Day04.Bingo do
  defstruct draw: [], boards: [], played_nums: nil

  def parse(input) do
    [draw_nums | board_strings] = String.split(input, "\n", trim: true)

    boards =
      board_strings
      |> Enum.chunk_every(5, 5, :discard)
      |> Enum.map(fn board_lines ->
        nums =
          Enum.join(board_lines, " ")
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)

        Advent.Day04.Board.new(nums)
      end)

    %Advent.Day04.Bingo{
      draw: parse_draw_nums(draw_nums),
      boards: boards,
      played_nums: []
    }
  end

  defp parse_draw_nums(draw_nums) do
    draw_nums
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def first_winning_board(%__MODULE__{} = bingo) do
    alias Advent.Day04.Board
    [num | rest] = bingo.draw
    played_nums = [num | bingo.played_nums]
    played_nums_set = MapSet.new(played_nums)

    winning_board =
      Enum.find(bingo.boards, fn board ->
        Board.find_winning_run(board, played_nums_set)
      end)

    new_bingo = %__MODULE__{
      draw: rest,
      boards: bingo.boards,
      played_nums: played_nums
    }

    case winning_board do
      nil -> first_winning_board(new_bingo)
      _ -> {winning_board, new_bingo}
    end
  end

  def last_winning_board(%__MODULE__{} = bingo) do
    last_winning_board(bingo, [])
  end

  def last_winning_board(%__MODULE__{draw: []}, winning_boards) do
    hd(winning_boards)
  end

  def last_winning_board(%__MODULE__{} = bingo, winning_boards) do
    alias Advent.Day04.Board
    [num | rest] = bingo.draw
    played_nums = [num | bingo.played_nums]
    played_nums_set = MapSet.new(played_nums)

    indexed_boards = Enum.with_index(bingo.boards)

    wins =
      Enum.filter(indexed_boards, fn {board, _idx} ->
        Board.find_winning_run(board, played_nums_set) != nil
      end)

    case length(wins) do
      0 ->
        new_bingo = %__MODULE__{
          draw: rest,
          boards: bingo.boards,
          played_nums: played_nums
        }

        last_winning_board(new_bingo, winning_boards)

      _ ->
        new_winning_boards =
          Enum.map(wins, fn {winning_board, _idx} ->
            %{board: winning_board, played_nums: played_nums}
          end)

        win_idxs = Enum.map(wins, &elem(&1, 1))

        remaining_boards =
          Enum.reject(indexed_boards, fn {_, idx} -> Enum.any?(win_idxs, &(&1 == idx)) end)
          |> Enum.map(&elem(&1, 0))

        new_bingo = %__MODULE__{
          draw: rest,
          boards: remaining_boards,
          played_nums: played_nums
        }

        last_winning_board(new_bingo, new_winning_boards ++ winning_boards)
    end
  end
end

defmodule Advent.Day04 do
  alias Advent.Day04.Bingo
  alias Advent.Day04.Board

  def part1(input) do
    {winning_board, end_state} =
      Bingo.parse(input)
      |> Bingo.first_winning_board()

    Board.score(winning_board, end_state.played_nums)
  end

  def part2(input) do
    %{board: winning_board, played_nums: played_nums} =
      Bingo.parse(input)
      |> Bingo.last_winning_board()

    Board.score(winning_board, played_nums)
  end
end
