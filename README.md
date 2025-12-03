# Elixir Learning Projects

A collection of Elixir exercises and examples covering fundamental concepts and advanced topics in functional programming.

## 📁 Project Structure
```
code/
├── closures.exs
├── funcs.exs
├── funcsMath.exs
├── lists.exs
├── maps.exs
├── math.exs
├── modules_maps.exs
├── poker_probabilities.exs
├── range_enum.exs
├── recursion.exs
├── simple.exs
├── tuples.exs
├── part1/              # Additional exercises
└── process_intro/      # Mix project - Process basics
    └── lib/
        └── process_intro/
            └── basics_module.ex
```

## 🚀 Getting Started

### Prerequisites

- Elixir 1.19.3 or higher
- Erlang/OTP 28 or higher

### Running Scripts

For standalone scripts in the root directory:
```bash
cd code
elixir script_name.exs
```

**Examples:**
```bash
elixir recursion.exs
elixir poker_probabilities.exs
elixir closures.exs
```

### Running Mix Projects

For the `process_intro` Mix project:
```bash
cd process_intro
iex.bat -S mix
```

Then call functions interactively:
```elixir
iex(1)> ProcessIntro.BasicsModule.main()
Inside the main() process (pid): #PID<0.110.0>
:main_done
```

## 📚 Topics Covered

### Core Fundamentals (Root Scripts)

| File | Topic | Description |
|------|-------|-------------|
| `simple.exs` | Basics | Introduction to Elixir syntax |
| `funcs.exs` | Functions | Function definitions and calls |
| `closures.exs` | Closures | Anonymous functions and scope |
| `math.exs` | Mathematics | Basic arithmetic operations |
| `funcsMath.exs` | Math Functions | Advanced mathematical functions |
| `lists.exs` | Lists | List operations and transformations |
| `tuples.exs` | Tuples | Tuple manipulation |
| `maps.exs` | Maps | Map data structure |
| `modules_maps.exs` | Modules | Module organization with maps |
| `range_enum.exs` | Enumerables | Ranges and Enum module |
| `recursion.exs` | Recursion | Recursive algorithms |
| `poker_probabilities.exs` | Applied Math | Combinatorics and probability |
| `name_formatter_test.exs` | Tests | Testing functions |

### Process Intro (Mix Project)

- **Process Basics**: Creating and managing processes
- **Message Passing**: Inter-process communication
- **Process IDs**: Understanding PIDs and self()

## 🔧 Key Concepts Demonstrated

### Recursion Example

Implementations include factorial, n-choose-k, and recursive list processing:
```elixir
# From recursion.exs
def n_choose_k_helper(n, k) do
  sets_without_x = n_choose_k_helper(n - 1, k)
  sets_with_x = n_choose_k_helper(n - 1, k - 1)
  sets_without_x + sets_with_x
end
```

### Process Management
```elixir
# From process_intro/lib/process_intro/basics_module.ex
defmodule ProcessIntro.BasicsModule do
  def main() do
    IO.puts("Inside the main() process (pid): #{inspect(self())}")
    :main_done
  end
end
```

## 📖 Learning Path

The exercises are designed to progress through:

1. **Basic Syntax** → `simple.exs`
2. **Functions** → `funcs.exs`, `closures.exs`
3. **Data Structures** → `lists.exs`, `tuples.exs`, `maps.exs`
4. **Algorithms** → `recursion.exs`, `funcsMath.exs`
5. **Applied Problems** → `poker_probabilities.exs`
6. **Concurrency** → `process_intro/`

## 🛠️ Development Tips

### Running in IEx
```bash
# Load a script in IEx
iex script_name.exs

# Or compile and run
elixirc script_name.exs
```

### Recompiling in IEx (for Mix projects)
```elixir
recompile()
```

### Getting Help
```elixir
h Enum
h Enum.map
```

## 📝 Key Elixir Principles

- **Immutability**: Data cannot be changed after creation
- **Pattern Matching**: Destructuring and matching values
- **Recursion**: Preferred over traditional loops
- **Higher-Order Functions**: Functions that accept/return functions
- **Process-Based Concurrency**: Lightweight processes for concurrent operations

---

## 📚 Resources

- **Official Docs**: https://hexdocs.pm/elixir/
- **Getting Started**: https://elixir-lang.org/getting-started/introduction.html
- **Elixir School**: https://elixirschool.com/en

---

- **Author**: Ricardo Vega
- **Environment**: Windows PowerShell with Elixir 1.19.3 / OTP 28
- **Course**: Elixir Programming Fundamentals