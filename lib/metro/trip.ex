defmodule Metro.Trip do

  def create_trip(station1_name, station2_name, metro_name) do
    #Loading metro and both stations data
    metro_data = Metro.Data.load_metro(metro_name)
    choose_mode(metro_data, 
                Metro.Data.get_station(metro_data, station1_name),
                Metro.Data.get_station(metro_data, station2_name))
  end

  def choose_mode(metro_data, station1, station2) do
    IO.inspect station1, label: "Inicio"
    IO.inspect station2, label: "Fin"

    case same_line?(station1, station2) do
      true -> trip_between_stations_same_line(metro_data, station1, station2)
      false -> :diff_line
    end
  end 

  def same_line?(station1, station2) do
    Enum.any?(station1.lines, fn line -> line in station2.lines end)
  end

  #Don't get line code before this because of stations possibly sharing more than one line
  def trip_between_stations_same_line(metro_data, station1, station2) do
      Enum.filter(station1.lines, fn line -> line in station2.lines end)
      |> Enum.map(&(Metro.Time.time_same_line(&1, metro_data, station1, station2)))
  end

end