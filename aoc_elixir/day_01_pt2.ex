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
    def spelled_to_int(str) do
        int_key = %{
            "zero" => 0,
            "one" => 1,
            "two" => 2,
            "three" => 3,
            "four" => 4,
            "five" => 5,
            "six" => 6,
            "seven" => 7,
            "eight" => 8,
            "nine" => 9
        }
        int_key.str
    end
end