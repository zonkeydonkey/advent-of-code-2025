defmodule Puzzle03_2 do
  require Integer

  @input_file_path "priv/puzzle_03_input.txt"
  @joltage_digits_number 12

  def solve() do
    file_content = File.read!(@input_file_path)
    solve(file_content)
  end

  defp solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      find_joltage(line)
      |> elem(1)
    end)
    |> Enum.sum()
  end

  defp find_joltage(line) do
    @joltage_digits_number..1//-1
    |> Enum.reduce({-1, 0}, fn current_digit_decimal_place, {last_digit_index, sum} ->
      line_length = String.length(line)
      {current_digit_index, current_digit_value} = find_max(line, (last_digit_index + 1)..(line_length - current_digit_decimal_place))

      {current_digit_index, sum + current_digit_value * :math.pow(10, current_digit_decimal_place - 1)}
    end)
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

IO.inspect(Puzzle03_2.solve())
