  defmodule Concat do
    def join(a, b, c, d, sep \\ ", my") do 
      a <> sep <> b <> sep <> c <> sep <> d
    end
  end

  IO.puts Concat.join("my neck", "back", "pussy", "crack")
  IO.puts Concat.join("neck", "back", "pussy", "crack", ",")
