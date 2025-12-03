defmodule Puzzle02_1 do
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

        if Integer.is_odd(x_length) do
          acc
        else
          first_half = String.slice(x_string, 0..div(x_length, 2) - 1)

          if x_string == first_half <> first_half do
            acc + x
          else
            acc
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
end

IO.inspect(Puzzle02_1.solve())
