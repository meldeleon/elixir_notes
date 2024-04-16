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
  - tuples are like lists but stored contiguously in memory. This makes accessing their length fast, but modificiation is very expensive; the new tuple must be copied entirely to memory. The are instantiated with `{}`
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
  iex(2)> {x,x} = {1,2}
  ** (MatchError) no match of right hand side value: {1, 2}
  {1, 1}
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
  - if a variable is declared or changed inside of an `if`, `case` construct, the declaration and change is only visible inside the construct.
  ```elixir
  iex(1)> x=1           
  1
  iex(2)> x = if true do
  ...(2)>   x+1
  ...(2)> else
  ...(2)>   x
  ...(2)> end
  2
  ```
## Anonymous Function
  - Anonymous functions allow us to store and pass executable code as if it was an int or string.
### Defining anonymous functions
  - Anon functions are delimited by the keywords `fn` and `end`
  ```elixir
  iex(3)> add  = fn a,b -> a + b end
  #Function<43.65746770/2 in :erl_eval.expr/5>
  iex(4)> add.(1,2)
  #3
  iex(5)> is_function(add)
  #true
  ```
  - We can invoke anon function with a `.()`, and pass arguments to it within the parentheses.
  - The dot makes it clear you are calling an anon function stored in a variable, and not calling a function named `add/2`
  - the arity of an anon function matters -- we can check its arity by calling `is_function()` such as in the following:
  ```elixir
  iex(6)> is_function(add, 2)
  true
  iex(7)> is_function(add, 1)
  false
  ```
### Closure
  - A closure is an anon function that uses variable defined in its scope.
  ```elixir
  iex(8)> double = fn a -> add.(a, a) end
  #Function<44.65746770/1 in :erl_eval.expr/5>
  iex(9)> double.(2)
  #4
  ```
  - A var assigned inside a func does not affect its surrounding enivornments.

### Classes and Guards
  - you can pattern match on the args of anon functions and define multiple clauses and guards:
  ```elixir
  iex(10)> f = fn 
  ...(10)>   x, y when x > 0 -> x + y
  ...(10)>   x, y -> x * y
  ...(10)> end
  #Function<43.65746770/2 in :erl_eval.expr/5>
  iex(11)> f.(1, 3)
  #4
  iex(12)> f.(-1, 3)
  #-3
  ```
  - clauses must have the same arguments in each clause or it will throw an error.

### The capture operator
  - the `name/arity` notation can be used to capture an existing function into a data-type that we can pass around, similar to how anonymous functions behave.
  ```elixir
  iex(13)> fun = &is_atom/1
  #&:erlang.is_atom/1
  iex(14)> is_function(fun)
  #true
  iex(15)> fun.(:hello)
  #true
  iex(16)> fun.(123)
  #false
  ```
  - We can also capture functions defined in modules
  ```elixir
  iex(17)> add = &+/2
  #&:erlang.+/2
  iex(18)> add.(1,2)
  #3
  ```
  - The capture syntax can also be used as shortcut for creating functions. Useful for functions that wrap existing function/operators.

## Binaries, strings and charlists
  - strings in elixir are represented internally by contiguous sequences of bytes known as binaries.
  - you can use `is_binary/1` function for checks.
  ```elixir
  iex(20)> string = "leostera"
  #"leostera"
  iex(21)> is_binary(string)
  #true
  ```
### Unicode and Code Points
  - The unicode standard acts as an official registry of all the characters we know, from classical text to emojis and formatting characters.
  - These are stored in code charts and each character is given an unique numerical index, known as a code point.
  - In elixir you can use a `?` in front of the characters in its repertoire 
  ```elixir
  iex(22)> ?a
  #97
  iex(23)> ?ł
  #322
  ```
  - Most unicode charts will refer to a code point by its hexidecimal representation.
  ```elixir
  iex(1)> "\u0061" == "a"
  #true
  iex(2)> 0x0061 = 97 = ?a
  #97
  ```
### UTF-8 and Encodings
  - Codes points are what store, and encoding deals with how we store it/encoding is an implementation. We need some mechanis to convert the code point number into bytes so they can be stored in memory/written to disk, etc.
  - Elixir uses UTF-8 to encode its strings, which measn that the code points are encoded as a series of 8-bit bytes. It is a variable width characters encoding that uses 1-4 bytes to store each code point.
  ```elixir
  iex(2)> String.length(string)
  #5
  iex(3)> byte_size(string)
  #6
  ```
  - UTF-8 also provides a notion of graphemes. 
  - In order to see the exact bytes that a string would be stored in file, a common trick is to concat a null byte `<<0>>`, or by using `IO.inspect/2`
  ```elixir
  iex(4)> "hełło" <> <<0>>        
  #<<104, 101, 197, 130, 197, 130, 111, 0>>
  iex(5)> IO.inspect("hełło", binaries: :as_binaries)
  #<<104, 101, 197, 130, 197, 130, 111>>
  "hełło"
  ```
### Bitstrings
  - A bitstring is a fundamental data type in ELixir, denoted with `<<>>/1` syntax. A bitsring is a contiguous sequence of bits in memory.
  - By default, 8 bits (1 byte) is used to store each number,but you can manually specify the number bits via `::n` modifier to denote the size on `n` bits, or you can use the more verbose declaration `::size(n)`:
  ```elixir
  iex(6)> <<42>>  == <<42::8>>
  #true
  iex(7)> <<3::4>>
  #<<3::size(4)>>
  ```

### Binaries
  - A binary is a bitstring where the number of bits is divisible by 8. Every binary is a bitstring, but not every bitstring is a binary. We uise the `is_bitstring/1` and `is_binary/1` functions to demonstrate this?
  ```elixir
  iex(1)> is_bitstring(<<3::4>>) 
  #true
  iex(2)> is_binary(<<3::4>>)
  #false
  iex(3)> is_bitstring(<<0, 255, 42>>)
  #true
  iex(4)> is_binary(<<0, 255, 42>>)
  #true
  iex(5)> is_binary(<<42::16>>)
  #true
  ```
  - We can pattern match on binaries/bitstrings
  ```elixir
  iex(6)> <<0,1,x>> = <<0, 1, 2>>
  #<<0, 1, 2>>
  iex(7)> x
  #2
  iex(8)> <<0,1,x>> = <<0,1,2,3>>
  # ** (MatchError) no match of right hand side value: <<0, 1, 2, 3>>
  ```
  - The string concatenation operatore `<>` is actually as binary concatenation operator
  ```elixir
  iex(8)> "a" <> "ha"
  #"aha"
  iex(9)> << 0,1>> <> <<2,3>>
  #<<0, 1, 2, 3>>
  ```
  - Given that strings are binaries, we can also pattern match on strings
  ```elixir
  iex(10)> <<head, rest::binary>> = "banana"
  "banana"
  iex(11)> head == ?b
  true
  iex(12)> rest
  "anana"
  ```

### Charlists
  - A charlist is a list of integers where all the integers are valid code points.
  ```elixir
  iex(13)> ~c"hello"
  #'hello'
  iex(14)> [?h, ?e, ?l, ?l, ?o]
  #'hello'
  ```
  - the `~c` sigil indicates the fact that we are dealing with a charlist and not a regular string.
  - `to_string/1` and `to_charlist/1` are functions that convert anything to strings and charlists respectively.
  - This may lead to surprising behavior. For example if you are storing a list of integers that happen to range between 0, 127, by default the REPL will interpret this as a charlist.
  ```elixir
  iex(5)> hbpm =  [99, 97, 116]                  
  'cat'
  ```
  - You can always force charlists to be printed in their list representation by calling the `inspect/2` function
  ```elixir
  iex(6)> inspect(hbpm, charlists: :as_list)
  "[99, 97, 116]"
  ```

## Keyword lists and maps
  - Elixir has two different associative structues -- keyword lists and maps.

### Keyword lists
  - Keyword lists are a data-strucutre used to pass options to functions. Example: There exists a string of numbers we'd like to split, but there is an additional space between the numbers
  ```elixir
  iex(1)> String.split("1 2 3", " ", [trim: true]) 
  #["1", "2", "3"]
  iex(2)> String.split("1 2 3", " ", trim: true)   
  #["1", "2", "3"]
  ```
  - In the example above, `[trim: true]` is a keyword list, when a keyword list is the last arg of a function, we can even skip the brqckets.
  - Keyword lists are mostly used as optional arguments to functions.
  - They are lists that containing two item tuples, where the first element (the key) is an atom, and the second element can be any value.
  - Since keyword lists are lists, you use all operations available to lists.
  ```elixir
  iex(7)> list = [a: 1, b: 2]
  [a: 1, b: 2]
  iex(8)> list ++
  ...(8)> [c: 3]
  [a: 1, b: 2, c: 3]
  iex(9)> [a: 0] ++ list
  [a: 0, a: 1, b: 2]
  ```
  - You can have duplicate keys in a keyword list, the left most value is retrieved when fetched.
  - Keyword lists are important because they have 3 special characteristics
  1. Keys must be atoms.
  1. Keys are ordered, as specified by the developer.
  1. Keys can be given more than once.
  - Do not pattern match on keyword lists.
 
### `do`-blocks and keywords
  - `do` block are nothing more than a syntax convenience on top of keywords, for example:
  ```elixir
  iex(1)> if true do
  ...(1)>   "This will be seen"
  ...(1)> else 
  ...(1)>   "This won't"
  ...(1)> end
  "This will be seen"
  ``` can be rewritten to
  ```elixir
  iex(2)> if true, do: "This will be seen", else: "This wont'"
  "This will be seen"
  ```
## Maps as key-value pairs
  - maps are the go to structure for key-value pairs. A map is created, using the `%{}` syntax:
  ```elixir
  iex(8)> map = %{:a => 1, 2 => :b}
  {2 => :b, :a => 1}
  ex(9)> map[:a]
  
  ex(10)> map[2]
  b
  ex(11)> map[:c]
  nil
  ```
  - Maps allow any values as a key.
  - Maps' keys do not follow any ordering.
  - Maps are very useful for pattern matching. WHen a map is used in a pattern, it will always match on a subset of the given value.
  ```elixir
  iex(13)> %{:a => a} = %{:a => 1, 2 => :b}
  %{2 => :b, :a => 1}
  iex(14)> a
  1
  iex(15)> %{:c => c} = %{:a => 1, 2 => :b}
  ** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}
  ```
  - a map matches as long as the keys in the pattern exist, therfore an empty map matches all maps.
  - the `Map` module has a very similar API to the `Keyword` module, with functions to add, remove, and update maps keys.
  ```elixir
  iex(1)> butts = %{:a => 1, 2 => :b} 
  %{2 => :b, :a => 1}
  iex(2)> Map.get(butts, :a)
  1
  iex(3)> Map.put(butts, :c, 3)
  %{2 => :b, :a => 1, :c => 3} 
  iex(4)> Map.to_list(butts) 
  [{2, :b}, {:a, 1}]
  ```
### Maps of predefined Keys
  - It is common to create maps with pre-defined keys, their values may be updated but new keys are never added nor removed. This is useful when we know the shape of data we are working with -- and getting a different keys likely means there was an error elsewhere.
  - We can define this with the same `%{}` syntax, but all the keys must be atoms.
  ```elixir
  iex(2)> butts = %{name: "John", age: 23}
  %{age: 23, name: "John"}
  iex(3)> butts.name 
  "John"
  iex(4)> butts.agee
  ** (KeyError) key :agee not found in: %{age: 23, name: "John"}. Did you mean one of:
   * :age
  ```
  - there is a syntax for updating keys which raises if the key has not yet been defined.
  ```elixir
  iex(1)> butts = %{name: "John", age: 23}
  %{age: 23, name: "John"}
  iex(2)> %{butts | name: "Mary"}
  %{age: 23, name: "Mary"}
  iex(3)> %{butts | agee: 27}
  ** (KeyError) key :agee not found in: %{age: 23, name: "John"}. Did you mean one of:
    * :age
  ```
  - These operations have one large benefit: they raise an error if the key does not exist in the map and the compiler may even detect/warn. 
  - Elixir devs generally prefer to use `map.key` syntax/pattern matching instead of using functions in `Map` module.

### Nested data structures
  - often maps and keyword lists will exist inside maps.
  - functions for manipulating nested data structures `put_in/2`, `update_in/2`
  - Take the following example:
  ```elixir
  iex(1)> users = [                                           
...(1)>   ryan: %{name: "Ryan", age: 42, languages: [       
...(1)> "Erlang", "Elixir", "Bash"]},                       
...(1)>   leo: %{name: "Leo", age: 34, languages: [ "Erlang", "Elixir", "OCaMel"]}
...(1)> ]
[
  ryan: %{
    age: 42,
    languages: ["Erlang", "Elixir", "Bash"],
    name: "Ryan"
  },
  leo: %{
    age: 34,
    languages: ["Erlang", "Elixir", "OCaMel"],
    name: "Leo"
  }
]
  ```
  - we can use the same syntax for updating the value:
  ```elixir
  iex(3)> users = put_in users[:leo].age, 32
  [
    ryan: %{
      age: 42,
      languages: ["Erlang", "Elixir", "Bash"],
      name: "Ryan"
    },
    leo: %{
      age: 32,
      languages: ["Erlang", "Elixir", "OCaMel"],
      name: "Leo"
    }
  ]
  ```
  - the `update_in/2` macro is similarl but it allows us to pass a function that controls how the value changes, for example, let's remove "OCaMel" from Leo's list of liked languages:
  ```elixir
    iex(4)> users  = update_in users[:leo].languages, fn languages -> List.delete(languages, "OCaMel") end 
    [ 
      ryan: %{ age: 42, languages: ["Erlang", "Elixir", "Bash"], name: "Ryan"
    },
    leo: %{age: 32, languages: ["Erlang", "Elixir"], name: "Leo"  }
  ]
  ```
  - There are additional macros such as `get_and_update_in/2` that allows us to extract a value and update the data structure at the same time. There also exists `put_in/3`, `update_in/3`, `get_and_update_in/3`. 
  - Key takeaways:
    1. Use keyword lists for passing optional values to functions.
    1. Use maps for general key-value data structures
    1. Use maps when working with data that has a predefined set of keys.

## Modules and Functions
  - In order to create our own modules, we use the `defmodule` macro. The first letter of the module must be uppercase, and we use the `def` macro to define functions in that modules, the first letter of functions must be lowercase or underscore.
  ```elixir
  iex(6)> defmodule Math do
  ...(6)>   def sum(a,b) do 
  ...(6)>     a+b
  ...(6)>   end
  ...(6)> end
  {:module, Math,
  <<70, 79, 82, 49, 0, 0, 4, 232, 66, 69, 65, 77, 65, 116, 85,
     56, 0, 0, 0, 136, 0, 0, 0, 15, 11, 69, 108, 105, 120, 105,
     114, 46, 77, 97, 116, 104, 8, 95, 95, 105, 110, 102, 111,
    95, 95, 10, 97, ...>>, {:sum, 2}}
  iex(7)> Math.sum(1,2)
  3
  ```
### Compilation
  - We can create elixir files to be compiled using the `.ex` extension. We can compile this file using the terminal command `elixirc`
  - This will generate a file named `Elixir.Math.beam` containing the bytecode for the defined module. Then when we run the REPL in that directory, our module definition will then be available.
  - Elixir projects, are generally separated into `_build`, `lib` and `test` directories. 
  - In the future, the `mix` build tool will handle compiling and path set up for us. 

### Scripting Mode
  - In addition to the Elixir file extension, `.ex`, there is `.exs` files for scripting.
  - To run scripts from the terminal use the `elixir` terminal commands, to run scripts from the REPL, use `c "file_name.exs"`
  ```elixir
  defmodule Math do
    def sum(a, b) do
      a + b
    end
  end

  IO.puts Math.sum(1, 2)
  ```
  - to execute in terminal: 
  ```
  $ elixir math.exs
  489
  ```

### Function definition.
  - Within a module, we define functions using `def/2` and private functions using `defp/2`. A function can be invoked from other modules, while a private function can only be invoked locally.

  ```elixir
  defmodule Math do
    def sum(a, b) do
      do_sum(a, b)
    end

    defp do_sum(a, b) do
      a + b
    end
  end

  IO.puts Math.sum(1, 2)    #=> 3
  IO.puts Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)
  ```
  - function declarations supporets guards and multiple clauses. If a function has multiple clauses, it will try each clause until it finds a match. Here is an example:

  ```elixir
  defmodule Math do
    def zero?(0) do
      true
    end

    def zero?(x) when is_integer(x) do
      false
    end
  end

  IO.puts Math.zero?(0)  #=> true
  IO.puts Math.zero?(1)  #=> false
  IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)
  IO.puts Math.zero(0.0) #=> ** (FunctionClauseError)
  ```
  - note on `?` this is a naming convention to indicate that the funciton returns a boolean.
  - if an argument does not match any of the clauses, this will raise a clause error.
  - `do:` can be used for one liners but multiple lines must be handled in `do` blocks. For example the above can be rewritten as the following

  ```elixir
  defmodule Math do
    def zero?(0) do: true
    def zero?(0) when is_integer(x), do: false
  end
  ```

### Default arguments
  - function defs support default args

  ```elixir
  defmodule Concat do
    def join(a, b, c, d, sep \\ ", my ") do
      a <> sep <> b <> sep <> c <> sep <> d
    end
  end

  IO.puts Concat.join("my neck", "back", "pussy", "crack") #=> my neck, my back, my pussy, my crack
  IO.puts Concat.join("neck", "back", "pussy", "crack", ", ")  #=> neck, back, pussy, crack
  ```
  - Any expression is allowed to serve as a default value, but will only be evaluated when the function is invoked and a default value is necessary.
  - If a function  with default values has multiple clauses, you need to create dunction head for declaring defaults.
  ```elixir 
  defmodule Concat do
    # A function head declaring defaults
    def join(a, b \\ nil, sep \\ " ")
    
    def join(a, b, _sep) when is_nil(b) do
      a
    end

    def join(a, b, sep) do
      a <> sep <> b
    end
  end

  IO.puts Concat.join("Hello", "world" ) #=> Hello world
  IO.puts Concat.join("Hello", "world", "_") #=> Hello_world
  IO.puts Concat.join("Hello")
  ```
## Recursion

## Loops through recursion
  - Loops in imperative languages mutate a variable i, and in some cases the enumerable you are iterating over etc. Since Elixir data structures are immutable,this method does not work.
  - Elixir relies on recursion: a function is called recursively until some condition reached (base case). No data is mutated in this process. Example:
  ```elixir
  defmodule Recursion do
    def print_multiple_times(msg, n) when n > 0 do
      IO.puts(msg)
      print_multiple_times(msg, n-1)
    end

    def print_multiple_times(_msg, 0) do
      :ok
    end
  end
  Recursion.print_multiple_times("Hello!", 3)
  # Hello
  # Hello
  # Hello
  ```
  - Similar to `case`, a function may have many clauses. A particular clause is executed when the arguments passed to the function match the clause's argument patterns and its guards evaluate to `true`
  - In the first three runs of `print_multiple_times/2`, the first clause is invoked because `n>0`, in the last run, it hits the termination clause, because `n=0`, and then it ignores the msg by assigning it to a `_msg` varible, and returns the atom `:ok`

### Reduce & Map Algorithms                                                   
```elixir
defmodule Math do
  def sum_list([head |  tail], acc) do
    sum_list(tail, head + acc)
  end

  def sum_list([], acc) do
    acc
  end
end

IO.puts Math.sum_list([1, 2, 3], 0)
```
- The process of taking a list and reducing it down to one value is know as the reduce algo , and its central to FP.

```elixir
  defmodule Math do
    def double_each([head | tail]) do
      [head * 2 | double_each(tail)]
    end

    def double_each([]) do
      []
    end
  end
```
- The process of taking a list and then mapping over it is known as a map algorithm. 
- The `Enum` module has functions for simplifying the above:

```elixir
  iex(1)> Enum.reduce([1,2,3], 0, fn x, acc -> x + acc end)
  6
  iex(2)> Enum.map([1,2,3], fn x -> x *2 end)
  [2, 4, 6]
```

```elixir
  iex(3)> Enum.reduce([1, 2, 3], &+/2) 
  6
  iex(4)> Enum.map([1, 2, 3], &(&1 *2))
  [2, 4, 6]
```

## Enumerables
- `Enum` module provides functions to work with enumerables.
- `=~` is a contains operator. When the RHS is a string, it checks if LHS contains RHS.
- Functions in the `Enum` module are limited to enumerating values in data structures. There are more specific modules for data types that might be a better fit for your use cases.
- Functions in the `Enum` module are polymorphic because they work on multiple data types, speicifcally ones that implement the `Enumerable` protocol.

### Eager vs. Lazy
  ```elixir
  iex(3)> odd? = fn x -> rem(x, 2) !=0 end
  #Function<42.105768164/1 in :erl_eval.expr/6>
  iex(4)> Enum.filter(1..3, odd?)
  [1, 3]
  iex(5)> 1..100_000 |> Enum.map(&(&1 *3)) |> Enum.filter(odd?) |> Enum.sum()
  7500000000
  ```
The last line in the code above is a pipeline of operations 

#### The pipe operator
- The `|>` takes the output from the expression on the left side and passes it as the first argument to the function call on its right side.

#### Eager
- All the functions in then `Enum` modules are eager. 
  - In eager evaluation, the entire collection is processed at once, and the result is immediately returned.
  - Eager evaluation is the defaulty behavior for most Elixir functions that work with collections, such as `Enum.map`, `Enum.filter`, etc.
  - With eager evalution, all elements of the collection are processed, even if not all of them are needed for the final result. This can lead to inefficiencies, especially with large datasets.

#### Lazy
- In lazy evaluation, elements of the collection are processed one at a time, and only as needed. This is achieved using streams in Elixir.
- Lazy evaluation is useful when working with large datasets or when you only need a portion of the processed data.
- With lazy evaluation, you can chain multiple operations without creating intermediate colelctions, which can lead to more efficient usage and performance.


### Streams
- As an alternative `Enum`, Elixir provides `Stream` module which supports lazy operations. 

```elixir
  iex(7)> 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum()
  7500000000
```
- Streams are lazy, composable enumerables. In the example above `1..100_000 |> Stream.map(&(&1 * 3))` returns a data type, an actual stream that represents the `map` and computation over the range `1..100_000`

```elixir
  iex(8)> 1..100_000 |> Stream.map(&(&1 * 3))
  #Stream<[enum: 1..100000, funs: [#Function<48.53678557/1 in Stream.map/2>]]>
```

- Instead of generating intermediate lists, streams build a series of computations that are invoked only when we pass the underlying stream to the `Enum` module. Streams are useful when working with large, possibly infinite, collections.

- Many functions in the `Stream` module accept any enumerable as an argument and return a stream as a result. It also provides functions for creating streams. For example, `Stream.cycle/1` can be used to create a stream that cycles a given enumberable infinitely. Be careful not to call a function like `Enum.map/2`on such streams, as they would cycle forever.

```elixir
  iex(10)> stream = Stream.cycle([1, 2, 3])
  #Function<63.53678557/2 in Stream.unfold/2>
  iex(11)> Enum.take(stream, 10)
  [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
```

- Another interesting function is `Stream.resource/3` which can be used to wrap around resources, guaranteeing they are opened right before enumeration and closed afterwards, even in the case of failures. For example `File.stream!/1` builds on top of `Stream.resource/3` to stream files.

- `Enum` and `Stream` modules provide a wide range of functions, but you don't have to know all of them by heart. In general being familiar with `Enum.map/2`, `Enum.reduce/3` and other function with either `map` or `reduce` in their names and you will naturally build an inuition around the most important use cases


## Processes

- All code reuns insice of processes. Processes are isolate from each other, run concurrent to one another and communicate via message passing. Processes are not only the basis for concurrency in Elixir, they provide the means for building distributed/fault-tolerant programs.

- Processes in Elixir are lightweight in terms of memory and CPU, even compared to threads as used in other languages. Because of this, it is not uncommon to have to have tens or even hundreds/thousands of processes running simultaneously.

### Spawning Processes
- The primary mechanism for spawning new processes is the `spawn/1` function. It takes a function which it will execute in another process:
```elixir
  iex(1)> spawn(fn -> 1 + 2 end)
  #PID<0.110.0>
  Process.alive?(v)
  false
```
- `v` is a magic variable that only works in the REPL, it signifies the last thing that was returned.
- We can retrieve the PID of the current process by calling `self/0`

```elixir
  iex(8)> self()  
  #PID<0.109.0>
```

### Sending and Receiving messages
- We can send messages to a process with `send/2` and receive `receive/1`

```elixir
  iex(9)> send(self(), {:hello, "world"})
  {:hello, "world"}
  iex(10)> receive do
  ...(10)>   {:hello, msg} -> msg
  ...(10)>   {:world, _msg} -> "won't match"
  ...(10)> end
  "world"
```
- When a message is sent to a process, the message is stored in the process mailbox. The `receive/1` block goes through the curren process mailbox searching for a message that matches any of the given patterns. `recieve/1` supports guards and many clauses, such as `case/2`

- a process that sends a message does not block on `send/2`, it will put a message in the recipients mailbox and continue. A process can send messages to itself. 

- If a there is not matching messages, a current process will wait until a matching message arrives, additionally a timeout can be specified.

```elixir
  iex(11)> receive do
  ...(11)>   {:hello, msg} -> msg
  ...(11)> after
  ...(11)>   1_000 -> "nothing after 1s"
  ...(11)> end
  "nothing after 1s"
```

- Here is an example of a spawned process sending a message to the default REPL process that we have named parent. Once the process is complete, there is message waiting in the parent process mailbox that can be received and used as an argument to a function:

```elixir
  iex(12)> parent = self()
  #PID<0.109.0>
  iex(13)> spawn(fn -> send(parent, {:hello, self()}) end)
  #PID<0.120.0>
  iex(14)> receive do
  ...(14)>   {:hello, pid} -> "Got hello from #{inspect pid}"
  ...(14)> end
  "Got hello from #PID<0.120.0>"
```

### Links

- We usually spawn processes as a linked processes.


```elixir
iex(18)> spawn(fn -> raise "oops" end)
#PID<0.122.0>

17:53:11.235 [error] Process #PID<0.122.0> raised an exception
** (RuntimeError) oops
```

- When a process started with `spawn/1` fails, the spawned process fails -- but the parent process is still running. If we want the failure in one process to propagate

- We can spawn a link process by using `spawn_link/1`. If the link process fails, it will propagate the failure to any linked process. In the example below we have spawned a new process that is linked to the REPL shell process that terminate once an error is raised.

```elixir
  iex(2)> self()
  #PID<0.110.0>
  iex(3)> spawn_link(fn -> raise "oops" end)
  ** #(EXIT from #PID<0.110.0>) shell process exited with reason: an exception was raised:
      ** (RuntimeError) oops
          (stdlib 3.17) erl_eval.erl:683: :erl_eval.do_apply/6

  Interactive Elixir (1.12.2) - press Ctrl+C to exit (type h() ENTER for help)
  iex(1)> 
  11:23:05.026 [error] Process #PID<0.114.0> raised an exception
  ** (RuntimeError) oops
      (stdlib 3.17) erl_eval.erl:683: :erl_eval.do_apply/6
```
- 

### Tasks
- Tasks are built on top of spawn functions, provide more granular error reports/introspection.
```elixir
iex(3)> Task.start(fn -> raise "oopsie woopsie" end)
#{:ok, #PID<0.119.0>}
iex(4)> 
11:43:16.030 [error] Task #PID<0.119.0> started from #PID<0.115.0> terminating
** (RuntimeError) oopsie woopsie
    (stdlib 3.17) erl_eval.erl:683: :erl_eval.do_apply/6
    (elixir 1.12.2) lib/task/supervised.ex:90: Task.Supervised.invoke_mfa/2
    (stdlib 3.17) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Function: #Function<45.65746770/0 in :erl_eval.expr/5>
    Args: []
```
- `Task.start/1` and `Task.start_link/1` are comparable to `spawn/1` and `spawn_link/1`, but return `{:ok, pid}` rather than just the PID. `Task` also has `Task.async/1` and `Task.await/1` to ease distribution.

### State
- State can be handled in a process. We can loop processes infinitely, maintain state and send an receive messages. The example below, is a module that starts new processes that work as key-value store in a file named `kv.exs`

```elixir
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end
```
- if we import the KV module to IEX, we can try and send a `:get` message, but becasue our process has no messages, a flush will return nil

```elixir
iex(1)> c "kv.exs"                  
[KV]
iex(2)> {:ok, pid} = KV.start_link()
{:ok, #PID<0.120.0>}
iex(3)> send(pid, {:get, :hello, self()})
{:get, :hello, #PID<0.110.0>}
iex(4)> flush()
nil
:ok
```
- however in the below examples, when we send a `:put`, we then see a response for our `:get` message, and flushing will return all the messages the process has received.

```elixir
iex(5)> send(pid, {:put, :hello, :world})
{:put, :hello, :world}
iex(6)> send(pid, {:get, :hello, self()})
{:get, :hello, #PID<0.110.0>}
iex(7)> flush()
:world
:ok
```
- Anyone who know the process ID can update this state -- we can also name the process to allow other processes to update this state easier:

```elixir
iex(12)> Process.register(pid, :kv)
true
iex(13)> send(pid, {:put, :hello, :world})
{:put, :hello, :world}
iex(14)> flush()               
:ok
iex(15)> send(pid, {:get, :hello, self()})
{:get, :hello, #PID<0.110.0>}
iex(16)> flush()
:world
:ok
```
- Elixir ships with a number of abstractions around state, like `Agent`s, the code above and be written as:

```elixir
iex(19)> {:ok, pid} = Agent.start_link(fn -> %{} end)
{:ok, #PID<0.137.0>}
iex(20)> Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
:ok
iex(21)> Agent.get(pid, fn map -> Map.get(map, :hello) end)
:world
```
- In the code above, we did not need to define `get` or `update` methods in our `kv.exs` file, since the `Agent` abstraction takes an anon function for its `get` and `update` methods. `Agent.start_link/2` also takes a `:name` which automatically registers 

## IO and the file system
### The `IO` module
- usage of the `IO` module is pretty straight forward. Standard input/out is `:stdio`, standard error `:stderr`

```elixir
iex(28)> IO.puts("hello world")
hello world
:ok
iex(29)> IO.gets("yes or no? ")
yes or no? yes
"yes\n"
```
- By default, the `IO` module will write to stdio, but we can change that by passing an argument such as `:stderr`

```elixir
iex(1)> IO.puts(:stderr, "hello world")
hello world
:ok
```

### The `File` module

- The `File` module allows us to open files as IO devices. Files are opened in binary mode, we use `IO.binread/2` and `IO.binwrite/2` function from the `IO` module.

```elixir
iex(9)> IO.binwrite(file, "butts")
:ok
iex(10)> {:ok, file} = File.open("butts.txt", [:write])
{:ok, #PID<0.127.0>}
iex(11)> IO.binwrite(file, "butts")                    
:ok
iex(12)> File.close(file)
:ok
iex(13)> File.read("butts.txt")
{:ok, "butts"}
```
- A file can also be opened with `:utf8` encoding. 
- `File.rm/1` removes files, `File.mkdir/1` makes directories, `File.mkdir_p/1` will make a directory and it's parent directories.
- `File.cp_r/2` and `File.rm_rf/1` will respectively copy/remove recursively.

- adding a trailing bang will return just contents instead of the tuple. If there are no contents to return, it will raise an error.
```elixir
iex(21)> File.read("butts.txt")
{:ok, "butts"}
iex(22)> File.read!("butts.txt")
"butts"
iex(23)> File.read!("butts2.txt")
** (File.Error) could not read file "butts2.txt": no such file or directory
    (elixir 1.12.2) lib/file.ex:355: File.read!/1
```

### The `Path` module
- `Path` module provides methods for working with file paths
```elixir
iex(4)> Path.join("butts", "cheeks")
"butts/cheeks"
iex(5)> Path.expand("butts")
"/home/leomeli/elixir_notes/butts"
```

### Processes
-The `IO` module works with processes. When you write to file that has been close, you are actually sending a message to a process which has been terminated.

```elixir
iex(1)> {:ok, file} = File.open("hello", [:write])
{:ok, #PID<0.112.0>}
iex(2)> File.close(file)
:ok
iex(3)> IO.write(file, "hello?")
** (ErlangError) Erlang error: :terminated
    (stdlib 3.17) io.erl:94: :io.put_chars(#PID<0.112.0>, "hello?")
```

```elixir
iex(1)> pid = spawn(fn ->
...(1)>   receive do: (msg -> IO.inspect(msg))
...(1)> end)
#PID<0.114.0>
iex(2)> IO.write(pid, "hello")
{:io_request, #PID<0.110.0>, #Reference<0.4120470462.549453825.196101>,
 {:put_chars, :unicode, "hello"}}
** (ErlangError) Erlang error: :terminated
    (stdlib 3.17) io.erl:94: :io.put_chars(#PID<0.114.0>, "hello")
```
### `iodata` and `chardata`
- Most IO module functions accept `iodata` or `chardata` for performance reasons.

```elixir
name = "Dillon"
IO.puts("Hello " <> name <> "!")
```
- The above will copy the string `name`, which can be expensive for very large strings.
- Becasue of this IO methods can take a list of strings, aka `iodata` or `chardata`

```elixir
name = "Dillon"
IO.puts(["Hello ", name, "!"])
```
- `iodata` and `chardata` may also contain integers. This is the primary different between the two -- for `iodata` integers represent bytes; for `chardata` integers represent unicode codepoints. 
- If a file is opened without encoding, it's assumed to be in `raw mode`, and IO methods will expect `iodata` as an argument (integers will represent bytes).

## alias, require and import
- There are three directives to facilitate software reuse, `alias`, `require`, `import`, plus one macro `use`

```elixir
# Alias the module so it can be called as Bar instead of Foo.Bar
alias Foo.Bar, as: Bar 

# Require the module in order to use its macros
require Foo

# Import functions from Foo so they can be called without `Foo.`
import Foo

# Invokes the custom code defined in Foo as an extension point.
use Foo
```

### `alias`
- `alias` directive allows referring to `Math.list` as just `List` within the module definition.

```elixir
defmodule Stats do
  alias Math.List, as: List
  # In the remaining module definition List expands to Math.List.
end
```
- All modules are defined in the main `Elixir` namespace, such as `Elixir.String`. 
- `alias` is lexically scoped, you can set an alias inside of a specific function in the below the `List` alias will only working in `plus/2` and not in `minus/2`.

```elixir
defmodule Math do
  def plus(a,b) do
    alias Math.List, as List
  end
  def minus(a,b) do
    #..
  end
end
```
### `require`
- Elixir has macros for meta-programming, or writing code that generates code. Macros get expanded at compile time. 
- In order to use macros you need to opt-in by requiring the module they are defined in.

```elixir
iex(6)> Integer.is_odd(3)
** (UndefinedFunctionError) function Integer.is_odd/1 is undefined or private. However there is a macro with the same name and arity. Be sure to require Integer if you intend to invoke this macro
    (elixir 1.12.2) Integer.is_odd(3)
iex(6)> require Integer 
Integer
iex(7)> Integer.is_odd(3)
true
```
- `require` is also lexically scoped. 

### `import` 
- `import` is used to access public functions from other modules without using the full-qualified name.

```elixir
iex(9)> import List, only: [duplicate: 2]
List
iex(10)> duplicate(:ok, 3)
[:ok, :ok, :ok]
```
- `:only` parameter will prevent importing all functions of a module inside the current scope.
- `import` is also lexically scoped.
- dev should generally prefer `alias` over `import` since the syntax of aliase make the origin of the function clearer.

### `use`
- `use` is often used as an extension point, applying `use` to a module `FooBar`, you are allowing the module to inject any code into the current module, such as importing itself or other modules, defining new functions, setting a module state, etc.

```elixir
defmodule AssertionTest do
  use ExUnit.Case, async: true

  test "always pass" do
    assert true
  end
end
```
- `use` requires the given module and then calls the `__using__/1` callback on it, which allows a module to inject code. 
- The general syntax for this looks like:
```elixir
defmodule Example do
  use Feature, option: :value
end
```
- which compiles to the following
```elixir
defmodule Example do
  require Feature
  Feature.__using__(option: :value)
end
```
- `use` allows any code to run, do we can't know the side-effects of a module without reading tis documentation. do not use `use` where an `import` or `alias` would work fine.

### Understanding ALiases
- An alias is a capitalized identifier (similar to `String` or `Keyword`), and is converted to an atom during compilation. For example:

```elixir
iex(2)> is_atom(String)
true
iex(3)> to_string(String)
"Elixir.String"
iex(4)> :"Elixir.String" == String
true
```
- By using `alias/2` directive, we change the atom the alias expands to. Aliases expand to atoms because in Beam, modules are represented by atoms.

```elixir
iex(6)> List.flatten([1, [2], 3])
[1, 2, 3]
iex(7)> :"Elixir.List".flatten([1, [2], 3])
[1, 2, 3]
```
### Module nesting

- consider:

```elixir
defmodule Foo do
  defmodule Bar do
  end
end
```
- we define two modules `Foo` and `Foo.Bar`. `Foo.Bar` can be accessed as `Bar` within the `Foo` lexical scope. If accessed outside of that it needs to be refrenced by `Foo.Bar`.  
- you can multi alias/import/require/use with the following syntax:

```elixir
alias MyApp.{Foo, Bar, Baz}
```
- NB: Ryan says don't do this, it's bad `:(` ^. 

## Module Attributes
- Modules attributes serve 3 purposes
  1. They serve to annotate the module, with info to be used by the user or the VM.
  1. They work as constants.
  1. They work as a temporary module storage to be used during compilation

### As annoations
- This is a concept borrowed from erlang. For example:

```elixir
defmodule MyServer do
  @moduledoc "My server code."
end
```
- In this example, we are defining the module documentations by using the module attribute syntax. Elixir has a handful of reserved attributes, some commonly used ones:
  -  `@moduledoc` -- provides documentation for the current module.
  - `@doc` -- provides documentation for the function or macro that follows the attribute.
  - `@spec` -- provides the typespec for function that follows the attribute.
  - `@behaviour` -- used for specifying an OTP or user-defined behaviour.

- `@moduledoc` and `@doc` are by fat the most used attributes. Elixir treats documentation as first-class and provides many function to access docs. 

```elixir
defmodule Math do
  @moduledoc """
  Provides math-related functions

  ## Examples
    iex > Math.sum(1,2)
    3
  """
  
  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end
```

- Elixir prefers the use of Markdown with heredocs. Heredocs are multi-line strings, they start and end with triple double-quotes. You can then access the documentation of any compiled module directly of IEx
- There is also a tool called ExDoc, which used to generate HTML pages from the documentations.

### As "constants"
- Elixir devs will often use module attributes as constants to make a value more visible/reusable"
```elixir
defmodule MyServer do
  @initial_state %{host: "127.0.0,1", pord: 3456}
  IO.inspect @initial_state
end
```
- Trying to access an attrubute that was not defined will also print a warning:

```elixir
iex(1)> defmodule MyServer do
...(1)>   @unknown
...(1)> end
warning: undefined module attribute @unknown, please remove access to @unknown or explicitly set it before access
└─ iex:2: MyServer (module)
```

- Attributes can also be read inside functions;

```elixir
defmodule MyServer do
  @my_data 14
  def first_data, do: @my_data
  @my_data 13
  def second_data, do: @my_data
end
```