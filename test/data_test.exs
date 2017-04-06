defmodule DataTest do
  use ExUnit.Case
  import Metro.Data

  @dummy_metro_file "test/metro_test"

  test "Format metro file" do
    assert load_metro(@dummy_metro_file) == [["Estacion1", "1,2", "40"],
                                        ["Estacion2", "3", "100"],
                                        ["Estacion3", "4,5,6", "0"]]
  end

  test "Get and format station data" do
    assert load_metro(@dummy_metro_file) 
            |> get_station("Estacion1") == %{name: "Estacion1", lines: ["1", "2"], time: "40"}
  end
end