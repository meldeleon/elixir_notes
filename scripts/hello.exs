# create a module
defmodule Hello do
  #create function
  def world(name) do
    IO.puts("Hello #{name}")
  end
end

Hello.world()
