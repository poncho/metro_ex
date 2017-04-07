defmodule Metro.Data do
  
  @headers [:name, :lines, :times, :order]

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
      times: String.split(station_map.times, ","),
      order: String.split(station_map.order, ",")
    })
  end

  def get_station(metro_data, station_name) do
    metro_data
    |> Enum.filter(fn st -> st.name == station_name end)
    |> List.first
  end

  def get_line(metro_data, line_code) do
    metro_data
    |> Enum.filter(fn st -> line_code in st.lines end)
    |> Enum.map(&set_work_line(&1, line_code))
    |> Enum.sort(&(
      get_station_order(&1.order, &1.index) <=
      get_station_order(&2.order, &2.index)
    ))
  end

  def trim_line(line_data, station1, station2) do
    order_1 = get_station_order(station1.order, station1.index)
    order_2 = get_station_order(station2.order, station2.index)
    count = abs(order_1 - order_2)

    Enum.slice(line_data, min(order_1, order_2) + 1, count)
  end

  def get_station_order(order_list, index) do
    order_list
    |> Enum.at(index)
    |> String.to_integer
  end

  def get_work_index(station, line_code), do: Enum.find_index(station.lines, &(&1 == line_code))

  def set_work_line(station, line_code) do
    Map.put(station, :index, get_work_index(station, line_code))
  end
end