defmodule Ledger.Cache do
  use GenServer

  import Logger, warn: false

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def fetch(key) do
    GenServer.call(__MODULE__, {:fetch, key})
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  # Server

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:fetch, key}, _from, state) do
    Logger.info("debug fetch")
    Process.sleep(5000)
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Logger.info("debug put")
    Process.sleep(5000)
    {:noreply, Map.put(state, key, value)}
  end
end
