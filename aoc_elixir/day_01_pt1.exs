defmodule Solve do
    def solve(input) do
        String.split(input, "\n", trim: true)
        |> Enum.map(fn str -> String.replace(str, ~r/[a-zA-Z]/, "") end)
        |> Enum.reduce(0, fn number_str, acc -> acc + String.to_integer(String.first(number_str) <> String.last(number_str)) end)
    end
    def parse_input(file) do
        {:ok, output} = File.read(file)
        output
        #|> IO.inspect()
    end
end

IO.puts(Solve.solve(Solve.parse_input("day_01_input.txt")))
