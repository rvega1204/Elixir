defmodule ProcessIntro.BasicsModule do
  @moduledoc """
  This module demonstrates basic Elixir process spawning, communication, and supervision patterns.
  """

  @doc """
  The main entry point of the module.
  Spawns a number of child processes and awaits their results.
  """
  def main() do
    num_children = 5
    spawn_some_processes(num_children)
    await_children(num_children, [])
    :main_done
  end

  @doc """
  Spawns `num` child processes, each calling `print_hello_world4`
  and passing the parent's PID.
  """
  def spawn_some_processes(num) do
    IO.puts("Parent PID: #{inspect(self())}")
    Enum.each(1..num, fn(_child_sequence_num) -> spawn(ProcessIntro.BasicsModule, :print_hello_world4, [self()]) end)
  end

  @doc """
  Base case for `await_children`.
  When `num_children` is 0, all children have reported back. Prints all collected results.
  """
  def await_children(0, results) do
    IO.puts("All the work is complete:")
    Enum.each(results, fn(result) -> IO.puts(result) end)
  end

  @doc """
  Recursive case for `await_children`.
  Waits for a message from a child process, collects its result,
  and then recursively calls itself to await the next child.
  """
  def await_children(num_children, results) do
    child_result = receive do
      {:done, result} -> result
    end
    await_children(num_children - 1, [child_result | results])
  end

  @doc """
  A simple function that prints "Hello World!!!" and its own PID.
  """
  def print_hello_world() do
    IO.puts("In print_hello_world() pid: #{inspect(self())}")
    IO.puts("Hello World!!!")
  end

  @doc """
  A simple function that prints "Hello World2!!!" along with a child sequence number.
  """
  def print_hello_world2(child_sequence_num) do
    IO.puts("#{child_sequence_num}: Hello World2!!!")
  end

  @doc """
  A function that prints "Hello World3!!!" and then sends a `:done` atom message
  to the `parent_pid`.
  """
  def print_hello_world3(parent_pid) do
    IO.puts("Hello World3!!!")
    send(parent_pid, :done)
  end

  @doc """
  A function that sends a `{:done, "Hello World4!!!"}` tuple message
  to the `parent_pid`.
  This is used by `spawn_some_processes` to return a specific result.
  """
  def print_hello_world4(parent_pid) do
    send(parent_pid, {:done, "Hello World4!!!"})
  end
end
