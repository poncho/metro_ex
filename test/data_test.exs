defmodule DataTest do
  use ExUnit.Case
  import Metro.Data

  @dummy_metro_file "test/metro_test"

  test "Format metro file" do
    assert load_metro(@dummy_metro_file) == [%{name: "Estacion1", lines: ["1", "2"], times: ["40"], order: ["1"]},
                                        %{name: "Estacion2", lines: ["3"], times: ["100"], order: ["2"]},
                                        %{name: "Estacion3", lines: ["4", "5", "6"], times: ["0"], order: ["3"]}]
  end

  test "Get and format station data" do
    assert load_metro(@dummy_metro_file) 
            |> get_station("Estacion1") == %{name: "Estacion1", lines: ["1", "2"], times: ["40"], order: ["1"]}
  end
end