defmodule Exponent do
  def multiply_by_itself(_base, n, acc) when n == 0 do
    IO.puts(result)
  end
  def multiply_by_itself(base, n, acc) do
    multiply_by_itself(base, n-1, sum * base)
  end
end

Exponent.multiply_by_itself(2, 6, 1)
