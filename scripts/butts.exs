defmodule Power do
  def power(_base, 0, acc), do: acc
  def power(base, n, acc), do: power(base, n - 1, acc * base)
end
IO.puts(Power.power(2, 6, 1))
