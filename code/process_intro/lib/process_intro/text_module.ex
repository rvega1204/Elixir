defmodule ProcessIntro.BasicsModule do
  # Main function to demonstrate text processing
  def main() do
    some_text = ["Alan Mathison Turing", "Grace Hopper", "Charles Babbage", "Linus Torvalds", "Steve Wozniak", "Barbara Liskov"]
    ProcessIntro.TextModule.run(some_text)
    
    :main_done
  end

  # Spawns a specified number of child processes, each sending a message to the parent.
  def spawn_some_processes(num) do
    IO.puts("Parent PID: #{inspect(self())}")
    Enum.each(1..num, fn(_child_sequence_num) -> spawn(ProcessIntro.BasicsModule, :print_hello_world4, [self()]) end)
  end

  # Base case for awaiting children: prints all collected results when no children are left.
  def await_children(0, results) do
    IO.puts("All the work is complete:")
    Enum.each(results, fn(result) -> IO.puts(result) end)
  end

  # Recursive case for awaiting children: receives a message from a child and continues awaiting.
  def await_children(num_children, results) do
    child_result = receive do
      {:done, result} -> result
    end
    await_children(num_children - 1, [child_result | results])
  end

  # Prints a simple "Hello World!!!" message along with its PID.
  def print_hello_world() do
    IO.puts("In print_hello_world() pid: #{inspect(self())}")
    IO.puts("Hello World!!!")
  end

  # Prints a "Hello World2!!!" message with a sequence number.
  def print_hello_world2(child_sequence_num) do
    IO.puts("#{child_sequence_num}: Hello World2!!!")
  end

  # Prints "Hello World3!!!" and sends a simple :done atom to the parent PID.
  def print_hello_world3(parent_pid) do
    IO.puts("Hello World3!!!")
    send(parent_pid, :done)
  end

  # Prints "Hello World4!!!" and sends a {:done, message} tuple to the parent PID.
  def print_hello_world4(parent_pid) do
    send(parent_pid, {:done, "Hello World4!!!"})
  end
end
