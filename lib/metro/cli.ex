defmodule Metro.CLI do
	@default_metro "df"

	def default_metro, do: @default_metro

  def main(argv) do
		argv
		|> parse_args
		|> process
	end

	def parse_args(argv) do
		parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
		
		case parse do
			{[help: true], _, _} -> :help
			{_, [station_1, station_2], _} -> { station_1, station_2, @default_metro }
			{_, [station_1, station_2, metro_name], _} -> { station_1, station_2, metro_name }
			_ -> :help
		end
	end

  def process(:help) do
		IO.puts """
		usage: metro <station1><station2>
		"""
		System.halt(0)
	end

  def process({station1_name, station2_name, metro_name}) do
		Metro.Trip.create_trip(station1_name, station2_name, metro_name)
  end
end