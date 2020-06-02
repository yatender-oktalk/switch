defmodule Switch do
  @moduledoc """
  Documentation for `Switch`.
  """
  use GenStateMachine

  # callbacks

  def handle_event(:cast, :flip, :off, data) do
    {:next_state, :on, data + 1}
  end

  def handle_event(:cast, :flip, :on, data) do
    {:next_state, :off, data}
  end

  def handle_event({:call, from}, :get_count, state, data) do
    {:next_state, state, data, [{:reply, from, data}]}
  end

  def handle_event({:call, from}, :get_state, state, data) do
    {:next_state, state, data, [{:reply, from, state}]}
  end
end
