defmodule Metro.Data do
  
  @headers [:name, :lines, :times]

  def load_metro(name) do
    {:ok, pid} = File.open(Path.join(System.cwd, "#{name}.txt"), [:utf8])

    IO.read(pid, :all)
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, "|")))
    |> Enum.map(&(format_station(&1)))
  end

  def format_station(station) do
    station_map =
      station
      |> Enum.zip(@headers)
      |> Enum.map(fn {x, y} -> {y, x} end)
      |> Enum.into(%{})
    
    Map.merge(station_map, %{
      lines: String.split(station_map.lines, ","),
      time: String.split(station_map.time, ",")
    })
  end

  def get_line(metro_data, line_code) do
    metro_data
    |> Enum.filter(fn st -> line_code in st.lines end)
  end

  def get_station(metro_data, station_name) do
    metro_data
    |> Enum.filter(fn st -> st.name == station_name end)
  end
end