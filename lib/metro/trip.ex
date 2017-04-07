defmodule Metro.Trip do
  require Logger

  def create(station1_name, station2_name, _metro_name) when station1_name == station2_name do
    "Seleccionaste la misma estación"
  end
  def create(station1_name, station2_name, metro_name) do
    #Loading metro and both stations data

    metro_data = Metro.Data.load_metro(metro_name)
    
    current = self()
    spawn( 
      fn -> send current, 
            find_trip(metro_data, 
              Metro.Data.get_station(metro_data, station1_name),
              Metro.Data.get_station(metro_data, station2_name))
      end
    )

    receive do
      {:error, 1} -> "Error: Estación '#{station1_name}' es inválida."
      {:error, 2} -> "Error: Estación '#{station2_name}' es inválida."
      _           -> "Tutto bene"
    end
  end

  def find_trip(_, nil, _), do: {:error, 1}  
  def find_trip(_, _, nil), do: {:error, 2}
  def find_trip(metro_data, station1, station2) do
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
    |> IO.inspect
  end

end