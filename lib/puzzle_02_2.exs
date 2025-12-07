defmodule Puzzle02_2 do
  require Integer

  @input_file_path "priv/puzzle_02_input.txt"

  def solve() do
    file_content = File.read!(@input_file_path)
    solve(file_content)
  end

  defp solve(input) do
    input
    |> String.split(",")
    |> Enum.reduce(0, fn range, counter ->
      [left, right] = String.split(range, "-")
      left_int = parse_int!(left)
      right_int = parse_int!(right)

      invalid_ids_sum = left_int..right_int
      |> Enum.reduce(0, fn x, acc ->

        x_string = Integer.to_string(x)
        x_length = String.length(x_string)

        if x_length == 1 do
          acc
        else
          x_mid_index = div(x_length, 2) - 1

          0..x_mid_index
          |> Enum.any?(fn i ->
            prefix = String.slice(x_string, 0..i)
            if invalid?(x_string, prefix) do
              true
            else
              false
            end
          end)
          |> case do
            true -> acc + x
            false -> acc
          end
        end
      end)

      counter + invalid_ids_sum

    end)
  end

  defp parse_int!(str) do
    Integer.parse(str)
    |> elem(0)
  end

  @spec invalid?(String.t(), String.t()) :: Boolean.t()

  defp invalid?(id, id) do
    true
  end

  defp invalid?(id, prefix) do
    if String.starts_with?(id, prefix) do
    new_start_index = String.length(prefix)
      String.slice(id, new_start_index..-1//1)
      |> invalid?(prefix)
    else
      false
    end
  end
end

IO.inspect(Puzzle02_2.solve())
