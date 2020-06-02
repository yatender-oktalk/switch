defmodule Climber do
  use GenServer

  def start_link(default \\ %{state: :ready}) do
    GenServer.start_link(__MODULE__, default)
  end

  def on_belay(pid) do
    GenServer.call(pid, :on_belay)
  end

  def climbing(pid) do
    GenServer.call(pid, :climbing)
  end

  def climb(pid, f) do
    GenServer.call(pid, {:climb, f})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:on_belay, _from, %{state: :ready} = state) do
    {:reply, :belay_on, Map.put(state, :state, :belay_on)}
  end

  @impl true
  def handle_call(:climbing, _from, %{state: :belay_on} = state) do
    {:reply, :climb_on, Map.put(state, :state, :climb_on)}
  end

  @impl true
  def handle_call({:climb, f}, _from, %{state: :climb_on} = state) do
    f.()
    {:reply, :ready, Map.put(state, :state, :ready)}
  end
end
