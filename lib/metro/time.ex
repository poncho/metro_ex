defmodule Metro.Time do
  
  def time_same_line(line_code, metro_data, station1, station2) do
    metro_data
    |> Metro.Data.get_line(line_code)
  end
end