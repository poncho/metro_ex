defmodule Metro.Time do
  
  def time_same_line(line_code, metro_data, station1, station2) do
    #Need to return times between stations for line code

    time = 
      metro_data
      |> Metro.Data.get_line(line_code)
      |> Metro.Data.trim_line(
          Metro.Data.set_work_line(station1, line_code), 
          Metro.Data.set_work_line(station2, line_code)
          )
      |> Enum.reduce(0, fn(st, total_time) -> get_station_time(st.times, st.index) + total_time end)
    
    {line_code, time}
  end

  def get_station_time(times_list, index) do
    times_list
    |> Enum.at(index)
    |> String.to_integer
  end
end