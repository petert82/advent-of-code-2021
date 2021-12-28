defmodule Advent.Day11.Octopus do
  alias Advent.Day11.FlashCounter
  use GenServer

  def start_link(energy, coord, counter) when is_integer(energy) and is_pid(counter) do
    GenServer.start_link(__MODULE__, {energy, coord, counter})
  end

  def set_neigbours(pid, neighbours) when is_list(neighbours) do
    GenServer.call(pid, {:set_neighbours, neighbours})
  end

  def get_neigbours(pid) do
    GenServer.call(pid, :get_neighbours)
  end

  def get_energy(pid) do
    GenServer.call(pid, :get_energy)
  end

  def increase_energy(pid) do
    GenServer.call(pid, :increase_energy)
  end

  def process_new_energy_level(pid) do
    res = GenServer.call(pid, :process_new_energy_level)

    if res == :flash do
      {:ok, neighbours} = __MODULE__.get_neigbours(pid)

      Enum.each(neighbours, fn pid ->
        :ok = __MODULE__.increase_energy(pid)
        :ok = __MODULE__.process_new_energy_level(pid)
      end)
    end

    :ok
  end

  def end_tick(pid) do
    GenServer.call(pid, :end_tick)
  end

  @impl true
  def init({energy, coord, counter}) do
    {:ok,
     %{
       energy: energy,
       coord: coord,
       counter: counter,
       neighbours: [],
       did_flash: false
     }}
  end

  @impl true
  def handle_call({:set_neighbours, neighbours}, _from, state) do
    {:reply, :ok, Map.put(state, :neighbours, neighbours)}
  end

  @impl true
  def handle_call(:get_neighbours, _from, %{neighbours: neighbours} = state) do
    {:reply, {:ok, neighbours}, state}
  end

  @impl true
  def handle_call(:get_energy, _from, %{energy: energy} = state) do
    {:reply, {:ok, energy}, state}
  end

  @impl true
  def handle_call(:increase_energy, _from, %{energy: energy} = state) do
    {:reply, :ok, Map.put(state, :energy, energy + 1)}
  end

  @impl true
  def handle_call(:process_new_energy_level, _from, %{did_flash: true} = state) do
    # already flashed this tick, do nothing
    {:reply, :already_flashed, state}
  end

  @impl true
  def handle_call(:process_new_energy_level, _from, %{energy: energy} = state) when energy > 9 do
    # increased energy above 9 this tick, do a flash
    Map.fetch!(state, :counter) |> FlashCounter.increment()
    {:reply, :flash, Map.put(state, :did_flash, true)}
  end

  @impl true
  def handle_call(:process_new_energy_level, _from, state) do
    # we didn't flash yet, and energy level is <= 9, nothing to do
    {:reply, :ok, state}
  end

  @impl true
  def handle_call(:end_tick, _from, %{energy: energy} = state) do
    new_state =
      if energy > 9 do
        Map.put(state, :energy, 0)
      else
        state
      end

    {:reply, :ok, Map.put(new_state, :did_flash, false)}
  end
end
