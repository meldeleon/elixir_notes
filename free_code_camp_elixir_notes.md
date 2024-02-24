# Free code camp elixir notes
 
[link to video](https://www.youtube.com/watch?v=IiIgm_yaoOA&ab_channel=freeCodeCamp.org)


## Intro
- Elixir gets compiled and runs on Erlang's VM, Beam.
- Elixir is function and supports immutability by default.
    - Since all of the data types are immutable there is no chance for any of the threads, objects or function to accidentally change values so the state is preserved and the system is more scalable.
- Fault tolerance, if processes go down, they can be revived with their own state.

## Functional Programming
- Entire program is composed of different functions
    ```
    x --> f(x) --> y
    transformation
    ```
- No classes or objects.
- All data types are immutable, like using constants throughout the program. The state remains the same. If the state remains the same, that means data can be copied and distributed. We can create extensive scalable systems.
- We don't have for loops -- because data is immutable.
- Elixir has a much better way of doing loops: recursion.
- Simply put -- recursion is doing the same task over and over again.
- 