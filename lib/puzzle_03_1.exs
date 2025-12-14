defmodule Puzzle03_1 do
  require Integer

  @input_file_path "priv/puzzle_03_input.txt"

  def solve() do
    file_content = File.read!(@input_file_path)
    solve(file_content)
  end

  defp solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line_length = String.length(line)
      {first_value_index, first_value} = find_max(line, 0..line_length - 2)
      {_second_value_index, second_value} = find_max(line, (first_value_index + 1)..(line_length - 1))

      first_value * 10 + second_value
    end)
    |> Enum.sum()
  end

  defp find_max(line, range) do
    range
    |> Enum.reduce({0, 0}, fn i, {max_value_index, max_value} ->
      i_value = String.at(line, i)
      |> parse_int!()

      if i_value > max_value do
        {i, i_value}
      else
        {max_value_index, max_value}
      end
    end)
  end

  defp parse_int!(str) do
    Integer.parse(str)
    |> elem(0)
  end
end

IO.inspect(Puzzle03_1.solve())
