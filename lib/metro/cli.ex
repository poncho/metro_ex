defmodule Metro.CLI do
  def main(argv) do
		argv
		|> parse_args
		|> process
	end

	def parse_args(argv) do
		parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
		
		case parse do
			{ [help: true], _, _} -> :help
			{ _, [station_1, station_2], _} -> { station_1, station_2 }
			_ -> :help
		end
	end

  def process(:help) do
		IO.puts """
		usage: metro <station1><station2>
		"""
		System.halt(0)
	end

  def process({station_1, station_2}) do
    
  end
end