defmodule Exponent do
  def multiply_by_itself(_base, n, result) when n == 0 do
    IO.puts(result)
  end
  def multiply_by_itself(base, n, result) when n > 0 do
    sum = result * base
    multiply_by_itself(base, n-1, sum)
  end

end

Exponent.multiply_by_itself(2, 6, 1)
