# Functional Programming with Elixir Course
[Link to Video](https://www.youtube.com/watch?v=IiIgm_yaoOA&t=831s&ab_channel=freeCodeCamp.org)

## Un-learning OOP
```js
a = 1
```
- You would say 1 is assigned to a variable named `a`
- instead in this case, `=` is a match operator. You are asserting that the two sides are equal. It is more similar to algebra.
- `1=a` should also be true
- Left Hand Side = Right Hand Side (LHS = RHS)
- elixir ships with a REPL type `iex` in your terminal to access it. Type `clear`to clear the terminal.
```elixir
iex(9)> a = 1
1
iex(10)> 1 == a
true
iex(11)> 1 = a
1
```

## Pattern Matching
```elixir
iex(16)> [a,a] = [1,1]
[1, 1]
iex(17)> a
1
```
- The pattern match here is correct, so you get the values back.
```elixir
iex(18)> [a,a] = [1,2]
** (MatchError) no match of right hand side value: [1, 2]
    (stdlib 5.2) erl_eval.erl:498: :erl_eval.expr/6
    iex:18: (file)
```
- We get an errror because the pattern match is not correct. the variable on a is bound to 1, and on the right 2 !== 1, so we get a pattern match error.
- Why is this happening? All of the data types inside of elixir are immutable. This helps for scalability.

```elixir
iex(18)> [a,b] = [1,2]
[1, 2]
```
- `2` gets bound to `b`
- Livebook is like the Jupiter Notebooks for elixir.

```elixir
iex(24)> a = 1
1
iex(25)> a = 2
2
```
- Why does the above work? You can rebind values to variables if the left hand side is a variable, elixir will assume this is waht you want.
- if you use the pin operator `^` you can force a pattern match for a LHS variable
```elixir
iex(30)> a = 1
1
iex(31)> ^a = 1
1
iex(32)> ^a = 2
** (MatchError) no match of right hand side value: 2
    (stdlib 5.2) erl_eval.erl:498: :erl_eval.expr/6
    iex:32: (file)
iex(33)> 2 = a
** (MatchError) no match of right hand side value: 1
    (stdlib 5.2) erl_eval.erl:498: :erl_eval.expr/6
    iex:33: (file)
```
- immutability helps in scalability -- since our data is immutable it can be copied across many different processes, and we don't have to worry about other processes trying to mutate our data.

## Actor Model

- Actor receives some kind of messages, instructions are sent to the actor, and the actor responds with something.
- Processes
    1. Runs in processes
    1. Identified by PID
    1. Inter-communication by message passing
    1. Each process has its own stack & heap allocation. This makes garbage collection really fast.
- Actor
    1. Receives messages in their own mailbox
    1. Executed FIFO
    1. Very cheap to create <3 kb memory
    1. Communicate with message passing
- PID == process ID. You can see which PID our REPL is operating under by using the `self/o` function.
```elixir
iex(33)> self
#PID<0.109.0>
```

## Hello World
- script files takes .exs extensions
- compiled files are .ex
- all of the code inside elixir stays inside its modules.
- for convention, the file name and module name must be the same.

```elixir
#hello.exs
# create a module
defmodule Hello do
  #create function
  def world() do
    IO.puts("Hello Elixir")
  end
end
Hello.world()
```
- elixir is a compiled language. scripts are generall used for internal dev files.
- you can run scripts by typing `elixir hello.exs` in your terminal
- you can compile elixir files by typeing `elixirc hello.exs`. Compiling creates a beam file. Normally we will not compile files this way, but instead we will use the mix tool.
- you can also compile in the elxir repl by using the `c` command.
```elixir
iex(1)> c "hello.exs"
    warning: redefining module Hello (current version loaded from Elixir.Hello.beam)
    │
  2 │ defmodule Hello do
    │ ~~~~~~~~~~~~~~~~~~
    │
    └─ hello.exs:2: Hello (module)

Hello Elixir
[Hello]
```
- once we have the module in memory we can also call the module/function
```elixir
iex(2)> Hello.world()
Hello Elixir
:ok
```
- we can recomplie using the `r`command

```elixir
iex(1)> r Hello
    warning: redefining module Hello (current version loaded from Elixir.Hello.beam)
    │
  2 │ defmodule Hello do
    │ ~~~~~~~~~~~~~~~~~~
    │
    └─ hello.exs:2: Hello (module)


== Compilation error in file hello.exs ==
** (UndefinedFunctionError) function Hello.world/0 is undefined or private. Did you mean:

      * world/1

    Hello.world()
    hello.exs:9: (file)
    (elixir 1.16.1) lib/kernel/parallel_compiler.ex:429: anonymous fn/5 in Kernel.ParallelCompiler.spawn_workers/8
** (MatchError) no match of right hand side value: {:error, [{"/Users/leomeli/Desktop/elixir_notes/scripts/hello.exs", 9, "** (UndefinedFunctionError) function Hello.world/0 is undefined or private. Did you mean:\n\n      * world/1\n\n    Hello.world()\n    hello.exs:9: (file)\n    (elixir 1.16.1) lib/kernel/parallel_compiler.ex:429: anonymous fn/5 in Kernel.ParallelCompiler.spawn_workers/8\n"}], [{"/Users/leomeli/Desktop/elixir_notes/scripts/hello.exs", 2, "redefining module Hello (current version loaded from Elixir.Hello.beam)"}]}
    (iex 1.16.1) lib/iex/helpers.ex:440: IEx.Helpers.r/1
    iex:1: (file)
iex(1)> Hello.world("mel")
Hello mel
:ok
```

## Data Types
### Atom
- takes the format of `:some_name`, or `:"Some Name"`.
- atoms are symbols -- the value and the name are the same. It would be similar to saying `var nike = nike` => `:nike`

```elixir
iex(2)> :nike
:nike
iex(3)> :"The Nike"
:"The Nike"
```

```elixir
:error
{:error, reason} = {:error, "file not found"}
reason
"file not found"
```


```elixir
{:ok , msg} = {:ok, "status 200 ok"}
msg
"status 200 ok"
```

### String
- double quotes only.

```elixir
iex(5)> "Mel" 
"Mel"
iex(6)> i("Mel")
Term
  "Mel"
Data type
  BitString
Byte size
  3
Description
  This is a string: a UTF-8 encoded binary. It's printed surrounded by
  "double quotes" because all UTF-8 encoded code points in it are printable.
Raw representation
  <<77, 101, 108>>
Reference modules
  String, :binary
Implemented protocols
  Collectable, IEx.Info, Inspect, List.Chars, String.Chars
```
- `i/1` gives you information about a data type.
- strings are saved as a collection of bytes, thats why the data type is a `BitString`
- pattern matching with strings. 
    ```elixir
    iex(3)> "M" <> rest  = "Mel"
    "Mel"
    iex(4)> rest
    "el"
    ```
- you can see the code point representation of any character using the `?` operator
    ```elixir
    iex(5)> i "abc"
    Term
    "abc"
    Data type
    BitString
    Byte size
    3
    Description
    This is a string: a UTF-8 encoded binary. It's printed surrounded by
    "double quotes" because all UTF-8 encoded code points in it are printable.
    Raw representation
    <<97, 98, 99>>
    Reference modules
    String, :binary
    Implemented protocols
    Collectable, IEx.Info, Inspect, List.Chars, String.Chars
    iex(6)> ?a
    97
    ```
- you can check if something is a string with `is_binary/1`
    ```elixir
    iex(9)> name = "mel"
    "mel"
    iex(10)> is_binary(name)
    true
    ```
- `<>` is a string concatenation operator.
    ```elixir
    iex(12)> msg = "Hello " <> name
    "Hello mel"
    iex(13)> "Hello " <> name = msg
    "Hello mel"
    iex(14)> name
    "mel"
    ```
    ```elixir
    iex(15)> <<head, rest::binary>> = name
    "mel"
    iex(16)> head
    109
    iex(18)> head == ?m
    true
    ```
- Pattern matching is very powerful and everywhere in Elixir
  ```elixir
  iex(1)> name = "Mel"
  "Mel"
  iex(2)> <<"M", rest::binary>> = name
  "Mel"
  iex(3)> rest
  "el"
  ```
  ```elixir
  iex(2)> <<head::binary-size(2), rest::binary>> = name
  "Mel"
  iex(3)> rest
  "l"
  iex(4)> head 
  "Me"
  ```
## Charlist
- Created by using single quotes.
  ```elixir
  iex(2)> chars = 'Mel'
  'Mel'
  iex(3)> i chars
  Term
    'Mel'
  Data type
   List
  Description
    This is a list of integers that is printed as a sequence of characters
    delimited by single quotes because all the integers in it represent printable
    ASCII characters. Conventionally, a list of Unicode code points is known as a
    charlist and a list of ASCII characters is a subset of it.
  Raw representation
    [77, 101, 108]
  Reference modules
    List
  Implemented protocols
    Collectable, Enumerable, IEx.Info, Inspect, List.Chars, String.Chars     
  ```
- 
