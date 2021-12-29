defmodule Advent.Day11 do
  alias Advent.Day11.Octopus
  alias Advent.Day11.FlashCounter

  def part1(input) do
    {world, flash_counter} = init_world(input)

    Enum.map(1..100, fn _i -> tick(world, flash_counter) end)
    |> Enum.sum()
  end

  def part2(input) do
    {world, flash_counter} = init_world(input)
    octopus_count = Enum.count(world)

    step_count =
      Stream.repeatedly(fn -> tick(world, flash_counter) end)
      |> Enum.take_while(fn flash_count -> flash_count != octopus_count end)
      # want the first step to be "step 1"
      |> Enum.with_index(1)
      |> Enum.to_list()
      |> List.last()
      |> elem(1)

    # step_count is the step _before_ all the octopuses flashed together
    step_count + 1
  end

  defp init_world(input) do
    {:ok, flash_counter} = FlashCounter.start_link()

    world =
      parse_values(input)
      |> Map.map(fn {coord, value} ->
        {:ok, pid} = Octopus.start_link(value, coord, flash_counter)
        pid
      end)

    Enum.each(world, fn {coord, pid} ->
      :ok = Octopus.set_neigbours(pid, neighbours(coord, world))
    end)

    {world, flash_counter}
  end

  defp tick(world, flash_counter) do
    Enum.each(world, fn {_coord, pid} ->
      :ok = Octopus.increase_energy(pid)
    end)

    Enum.each(world, fn {_coord, pid} ->
      :ok = Octopus.process_new_energy_level(pid)
    end)

    Enum.each(world, fn {_coord, pid} ->
      :ok = Octopus.end_tick(pid)
    end)

    {:ok, flash_count} = FlashCounter.get_count(flash_counter)
    FlashCounter.reset(flash_counter)
    flash_count
  end

  defp parse_values(input) do
    lines = String.split(input, "\n", trim: true)

    for {line, y} <- Enum.with_index(lines), reduce: %{} do
      acc ->
        row_values =
          String.graphemes(line)
          |> Enum.with_index()
          |> Enum.map(fn {num, x} -> {{x, y}, String.to_integer(num)} end)
          |> Map.new()

        Map.merge(acc, row_values)
    end
  end

  defp neighbours({x, y}, grid) do
    %{
      # Ordinal points
      {x - 1, y} => Map.get(grid, {x - 1, y}),
      {x + 1, y} => Map.get(grid, {x + 1, y}),
      {x, y - 1} => Map.get(grid, {x, y - 1}),
      {x, y + 1} => Map.get(grid, {x, y + 1}),
      # Diagonals
      {x - 1, y - 1} => Map.get(grid, {x - 1, y - 1}),
      {x + 1, y + 1} => Map.get(grid, {x + 1, y + 1}),
      {x + 1, y - 1} => Map.get(grid, {x + 1, y - 1}),
      {x - 1, y + 1} => Map.get(grid, {x - 1, y + 1})
    }
    |> Map.reject(fn {_coord, value} -> value == nil end)
    |> Map.values()
  end

  # defp as_string(world) do
  #   for y <- 0..9 do
  #     for x <- 0..9 do
  #       Map.fetch!(world, {x, y})
  #       |> Octopus.get_energy()
  #     end
  #     |> Enum.map(&elem(&1, 1))
  #     |> Enum.join()
  #   end
  #   |> Enum.join("\n")
  # end
end
