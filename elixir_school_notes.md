# Elixir Notes

## Types

### Integers
  - Supports binary, octal, hex
### Floats
  - 64-bit double precision, `e` for exponent values
### Booleans
### Atoms
  - Atoms are symbols, they are a constant whose name is its value.
  - Names of modules in elixir are also atoms.
  - `:foo`
### Str
  - Double quotes only

##Basic Operations
### Arithmetic
  - / will always return a float
  - integer division: `div(10,5)`
  - modulo: `rem(10,3)`
### Boolean
  - `||`, `&&` and `!` takes any types for arguments
  - `and`, `or` and `not` are operators whose first argument must be `true` or `false`
### Comparison
  - `==`, `!=`, `===`, `!==`, `<=`, `>=`, `<`, and `>`
  - strict comparator applies to ints and floats
  - any two types can be compared, here is the sort order:
    - `number < atom < reference < function < port < pid < tuple < map < list < bitstring`
### String interpolation
  - `"Hello #{name}"`
### String concatenation
  - uses the `<>` operator
  - ```elixir
    name = "Sean"
    "Hello " <> name``

## Collections
### Lists
  - May include non-unique values
  > Elixir implements list collections as linked lists. This means that accessing the list length is an operation that runs in O(n). It is always faster to prepend rather than append
  ```elixir
  list = [3.14, :pie, "Apple"]
  # Prepending (fast)
  ```
  - Appending is in O(n). It is always faster to prepend rather than append
  ```elixir
  list = [3.14, :pie, "Apple"]
  ["pi"| list]
  # returns ["pi", 3.14, :pie, "Apple"]
  # Appending (slow)
  list ++ ["Cherry"] 
  # returns ["pi", 3.14, :pie, "Apple", "Cherry"]
  ```
### List concatenation 
  - concat with `++/2` operator
  - note: the `/2` above referes to the operator's arity -- which is number of arguments a given function takes.
### List subtraction
  - subtraction is provided via the `--/2` operator; it's safe to subtract a missing val.
  - list subtraction uses strict comparison to match values.
### Head/Tail
  - There are two function for accessing the head/tail `hd` and `tl`, the head is the list's first element, while the tail is a list containing the remaining elements
  ```elixir
    list = ["neck", "back", "p*ssy", "crack"]
    hd list
    # returns "neck"
    tl list
    # returns ["back", "p*ssy", "crack]
  ```
  - When you declare the list you're actually typing `["neck"|["back"|["p*ssy"|["crack"|[]]]]]`
  - you can use pattern matching to split a list into a head and tail.
  `[head | tail] = list`
 
### Tuples
  - tuples are lioke lists but stored contiguously in memory. This makes accessing their length fast, but modificiation is very expensive; the new tuple must be copied entirely to memory. The are instantiated with `{}`
  - `{"neck", "back", "p*ssy", "crack"}`
  - Tuples can be used as a mechanism to return addl info from functions.

### Keyword lists
  - Keyword lists and maps are the associate collection. A keyword list is a special list of two-element tuples, whose first element is an atom; they share performance with lists
  ```elixir
  keyword_list = [foo: "bar", hello: "world"]
  # can also be typed as
  keyword_list = [{:foo,"bar"}, {:hello, "world}]
  ```
  - keys are atoms, keys are ordered, keys do not have be unique. 
  - often used to pass options to functions.

### Maps
  - they are the "go-to" kv store. They allow keys of any type and are un-ordered. Define maps with `%{}` syntax.
  ```map = %{:foo => "bar", "hello", "hello" => :world}```
  - as of 1.2 variables are allowed as map keys
  ```map = %{key => "world"}```
  - if a duplicate is added to a map it replaces the former value.
  - there exists a special syntax for only atom keys
  ```map = %{foo: "bar", hello: "world"}```
  - maps provide their own syntax for updates (note, this creates a new map). Do this using the syntax `%{ mapName | atom: "value"}`
  ```elixir 
    map = %{foo: "bar", hello: "world"
      %{map | foo: "baz"} 
  ```

  - This syntax only works for keys that exist in the map, to create a new key instead use `Map.put/3`
  `Map.put(map, :foo, "baz"`

## Enum
  - Enum is a set of algo for enumerating over enumberables
  - The `Enum` module includes over 70 functions. All collections except tuples are enumerables.
 ### Common Enum Functions
  - `all?/2` we supply a function to apply to our collection's items, the entire collection must evaluate to `true` otherwise `false` will be returned.
  ```elixir 
  Enum.all?(["neck", "back", "p*ssy", "crack"], fn(s) -> String.length(s) == 3 end)
  #evaluates to false
  Enum.all?(["neck", "back", "p*ssy", "crack"], fn(s) -> String.length(s) != 3 end)
  #evaluated to true
```
  - `any?/2` will return `true` if at least one item evaluates to `true`:
  ```elixir
  Enum.any?(list, fn(s) -> String.length(s) == 5 end)
  #evaluates to true
  ```
  - `chunk_every/2` allows you to break your collection up into smaller groups
  ```elixir
  Enum.chunk_every(list, 2)
  #returns [["neck", "back"], ["p*ssy", "crack"]]
  ```
  - `chunk_by/2` groups a collection based on something other than size. It takes an enumerable and then a function, and when the return on that function changes, a new group is started and being the creation of the next.
  ```elixir
  Enum.chunk_by(list, fn(x) -> String.length(x) end)
  #return [["neck", "back"], ["p*ssy", "crack"]]
  ```
  - `map.every/3` will hit every `nth` items, always hitting the first one.
  ```elixir
  Enum.map_every(list, 1, fn x -> "straighten your #{x}" end)
  #returns ["straighten your neck", "straighten your back",
 "straighten your p*ssy", "straighten your crack"]
  ```
  - `each/2` will iterate over a collection without returning a new value.
  ```elixir
  Enum.each(list, fn(s) -> IO.puts(s) end)
  #neck
  #back
  #p*ssy
  #crack
  #returns :ok
  ```
  - `map/2` applies a function on each item and produces a new collection.
  ```elixir
  Enum.map(list, fn(x) -> "my #{x}" end)
  #returns ["my neck", "my back", "my p*ssy", "my crack"]
  ```
  - `min/1` finds minimal value in the collection, `min/2` will allow you to specify a function to produce a min value if the collection is empty.
  - `max/1` reutrn the maximal value in the collection, `max/2` will also allow you to specify a function in the case that the collection is empty.
  - `filter/3` enables us to filter to include elements that only evaluate `true` using the provided function.
  ```elixir
  Enum.filter(list, fn(x)-> x == "back" end)
  #return ["back"]
  ```
  - `reduce/3` reduces a collection down to a single value. The first argument is an optional accumulate and then a reduction function.
  ```elixir
  Enum.reduce(list, 0, fn(x, acc) -> x + acc end)
  #returns 2520
  ```
  - `sort/1` uses Erlang's term ordering to determine the sorted order.
  ```elixir
  Enum.sort(list)
  #returns [42, 69, 420, 1989]
  ```
  - `sort/2` allows us to sort providing a function of our own
  ```elixir
  listMap = [%{:val => 4}, %{:val => 1}]
  Enum.sort(listMap, fn(x,y) -> x[:val] > y[:val] end)
  #returns [%{val: 4}, %{val: 1}]
  ```
  - For convenience `sort/2` allows us to pass `:asc` or `:desc` as the sorting function
  - `uniq/1` removed duplicates from enumerables
  ```elixir
  list = [1,1,1,2]
  Enum.uniq(list)
  #returns [1, 2]
  ```
  - `uniq_by/2` also removes duplicates from enumerables, but we can use a function to do uniqueness comparisons

## Capture Operator &
  - & can turn a function into  an anonymous function which can be passed as argument to other functions or be bound to a variable. 
  - this is similar to JS
  ```js
  const butts =  () => {
  return "butts"
  }
  ```
  - & can capture two types of functions, 
    1. a function with a given name and arity
    ```elixir
    speak = &(I.0.puts/1)
    speak.("hello") 
    ```
    1. local function
    ```elixir
    defmodule Issues.TableFormatter do
      def put_in_columns(data_by_columns, format) do
	      Enum.each(data_by_columns, &put_in_one_row/1)
      end

      def put_in_one_row(fields) do
  	    # Do some things...
      end
    end
    ```
  - The capture operator can also be used to create anonymous functions,
  ```elixir
  add_one = &(&1 + 1)
  add_one.(1) #2
  ``` 
  is the same as
  ```elixir
  add_one = fn x -> x +1 end
  add_one(1) #2
  ```
## Pattern Matching
  - Allows us to match simple values, data structures and functions.
### Match Operator
  - The `=` operator is actually a match operator, comparable to the equals sign in algebra.
  - The match operator performs assignment when the left side of the match includes a variable. 
  - When sides do not match a `MatchError` is raised

### Pattern Matching
  - The match operator is also useful for destructuriung more complex data types
  ```elixir
  {a, b, c} = {:hello, "world", 42}
  #{:hello, "world", 42}
  iex(2)> a
  #:hello
  ```
  - This will also throw an error if the left and right hand of the matching operator do not have the same size
  - We 




  - We can also assert things with the match operator. The following will only match if the first element of the tuple is :ok on both the left and right sides:
  ```elixir
  {:ok, result} = {:ok, 13}
  #{:ok, 13}
  iex(6)> result 
  #13
  ```
  - We can also pattern match on lists, it supports matching the `[head | tail]`
  - Pattern matching allows developers to easily destructure data types. It is also one of the foundations of recursion in Elixir.

### Pin Operator
  - Variables in Elixir can be rebound -- but in the case when we don't want variables to be rebound, we use the pin operator `^`
  ```elixir
  iex(1)> x = 1 
  #1
  iex(2)> ^x =2
  #** (MatchError) no match of right hand side value: 2
  ```
  this is equivalent to
  ```elixir
  iex > 1=2
  ```
  - we can use the pin operator inside pattern matches such as tuples or lists
  ```elixir
  iex(1)> x = 1
  #1
  iex(2)> [^x, 2, 3] = [1,2,3]
  #[1, 2, 3]
  ```
  - if a variable is mention more than once in a pattern, all references must bind to the same value
  ```elixir
  iex(1)> {x,x} = {1,1} 
  {1, 1}
  iex(2)> {x,x} = {1,2}
  ** (MatchError) no match of right hand side value: {1, 2}
  ```
  - if we generall do not care about a particular value in a pattern, we can bind it to `_`  
  ```elixir
  iex(2)> [head | _] = [1,2,3]
  #[1, 2, 3]
  iex(3)> head
  #1
  ```
  - the variable `_` is special, it can never be ready from, trying to read it give a compile error
  ```elixir
  iex(4)> _
  ** (CompileError) iex:4: invalid use of _. "_" represents a value to be ignored in a pattern and cannot be used in expressions
  ```
  - you cannot make function calls on the left side of a match.
  ```elixir
  iex(4)> length([1,2,3]) = 3
  ** (CompileError) iex:4: cannot invoke remote function :erlang.length/1 inside a match
  ```
## case, cond and if 
### case
  - `case` allows us to compare a value against many patterns until we find a matching one
  ```elixir
  iex(1)> case {1,2,3} do
  ...(1)>   {4,5,6} ->
  ...(1)>     "this clause won't match"
  ...(1)>   {1,x,3} ->
  ...(1)>     "this clause will match and bind x to 2"       
  ...(1)>   _ ->
  ...(1)>     "this clause will match any value"
  ...(1)> end
  #warning: variable "x" is unused (if the variable is not meant to be used, prefix it with an underscore)
  #"this clause will match and bind x to 2"
  ```
  - you can also pattern match against an existing variable using the `^` pinning operator.  
  ```elixir
  iex(2)> case  {1,2,3} do
  ...(2)>   {1, x, 3} when x > 0 ->
  ...(2)>     "Will match"
  ...(2)> _ ->
  ...(2)>   "Would match, if guard condition were not satisfied" 
  ...(2)> end
  #"Will match"
  ```
  - the above will only match if `x` is positive
  - if no clauses are matched an error is raised.
  
### cond
  - `cond` checks different conditions and finds the first one that does not evaluate to `nil` or `false`.
  ```elixir
  iex(3)> cond do
  ...(3)>   2 + 2 == 5 ->
  ...(3)>     "this will not be true"
  ...(3)>   2 * 3 == 3 ->
  ...(3)>     "nor this"             
  ...(3)>   1 + 1 == 2 ->
  ...(3)>     "but this will be"
  ...(3)> end 
  #"but this will be"
  ```
### if/unless
  - Elixir also provides `if/2` and `unles/2` which are useful if you want to check for one condition.
  ```elixir
  iex(4)> if true do
  ...(4)>   "this works"
  ...(4)> end
  "this works"
  iex(5)> unless true do
  ...(5)>   "this will never be seen"
  ...(5)> end
  nil
  ```
  - Elixir also supports `else` blocks
  ```elixir
  iex(1)> if nil do 
  ...(1)>   "this won't be seen"
  ...(1)> else
  ...(1)>   "this will"
  ...(1)> end 
  #"this will"
  ```
  - if a variable is declared or changed inside of an `if`, `case` constructu, the declaration and change is only visible inside the construct.

