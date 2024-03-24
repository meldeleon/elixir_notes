defmodule Solve do
    def solve(input) do
        #take the input and split by new lines
        String.split(input, "\n", trim: true)
        |> IO.inspect(label: "split values")
        #map over the input,and using RegEx match on anything that is a number or a eng string of a number
        |> Enum.map(fn str -> 
            Regex.scan(~r/[0-9]|zero|one|two|three|four|five|six|seven|eight|nine/, str)
            |> Enum.every(fn x -> x end)       
        end)
    def parse_input(file) do
        {:ok, output} = File.read(file)
        output
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
        int_key[str]
    end
end

input = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

IO.puts(Solve.solve(input))
