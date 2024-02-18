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
  - ```elixr
    name = "Sean"
    "Hello " <> name``

## Collections
### Lists
  - May include non-unique values
  > Elixir implements list collections as linked lists. This means that accessing the list length is an operation that runs in O(n). It is always faster to prepend rather than append
  ```elxir
  list = [3.14, :pie, "Apple"]
  # Prepending (fast)
  [ns in O(n). It is always faster to prepend rather than append
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
  ``` map = %{foo: "bar", hello: "world"
  %{map | foo: "baz"} ```
  - This syntax only works for keys that exist in the map, to create a new key instead use `Map.put/3`
  `Map.put(map, :foo, "baz"`
