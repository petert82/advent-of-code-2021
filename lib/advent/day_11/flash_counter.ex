defmodule Advent.Day11.FlashCounter do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 0)
  end

  def increment(pid) do
    GenServer.call(pid, :incr)
  end

  def get_count(pid) do
    GenServer.call(pid, :get_count)
  end

  def reset(pid) do
    GenServer.call(pid, :reset)
  end

  @impl true
  def init(count) do
    {:ok, count}
  end

  @impl true
  def handle_call(:incr, _from, count), do: {:reply, {:ok, count + 1}, count + 1}

  @impl true
  def handle_call(:get_count, _from, count), do: {:reply, {:ok, count}, count}

  @impl true
  def handle_call(:reset, _from, _count), do: {:reply, {:ok, 0}, 0}
end
