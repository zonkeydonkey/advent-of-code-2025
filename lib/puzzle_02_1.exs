defmodule Puzzle02_1 do
  @input_file_path "priv/puzzle_02_input.txt"

  def solve() do
    file_content = File.read!(@input_file_path)
    solve(file_content)
  end

  defp solve(input) do
    for report <- String.split(input, ["\n"]),
        levels = String.split(report, [" "]),
        levels_parsed = Enum.map(levels, &parse_int!/1) do
      if report_valid?(levels_parsed) do
        1
      else
        0
      end
    end
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  defp parse_int!(str) do
    Integer.parse(str)
    |> elem(0)
  end

  defp report_valid?(report) do
    increasing? = Enum.at(report, 0) - Enum.at(report, 1) < 0

    0..(length(report) - 2)
    |> Enum.all?(fn i ->
      diff = Enum.at(report, i) - Enum.at(report, i + 1)

      abs(diff) > 0 and abs(diff) < 4 and
        ((diff < 0 and increasing?) or (diff > 0 and not increasing?))
    end)
  end
end

IO.inspect(Puzzle02_1.solve())
