defmodule CLITest do
  use ExUnit.Case

  import Metro.CLI

  test ":help returned by option" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "3 values returned when sent 3 values" do
    assert parse_args(["station1", "station2","metro"]) == {"station1", "station2", "metro"}
  end

  test "3 values returned when sent 2 values" do
    assert parse_args(["station1", "station2"]) == {"station1", "station2", default_metro()}
  end
  

end