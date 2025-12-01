defmodule Puzzle01_1 do
  @input_file_path "priv/puzzle_01_input.txt"

  def solve() do
    file_content = File.read!(@input_file_path)
    solve(file_content)
  end

  defp solve(input) do
    input
    |> String.split("\n")
    |> Enum.reduce({0, 50}, fn row, {counter, position} ->
      <<direction::binary-size(1), rest::binary>> = row
      distance = parse_int!(rest)
      effective_distance = rem(distance, 100)
      case direction do
        "L" ->
          base = position - effective_distance
          next_position = cond do
            base < 0 ->
              100 + base
            true ->
              base
          end

          if next_position == 0 do
            {counter + 1, next_position}
          else
            {counter, next_position}
          end

        "R" ->
          base = position + effective_distance
          next_position = cond do
            base > 99 ->
              base - 100
            true ->
              base
          end

          if next_position == 0 do
            {counter + 1, next_position}
          else
            {counter, next_position}
          end
      end
    end)
  end

  defp parse_int!(str) do
    Integer.parse(str)
    |> elem(0)
  end
end

IO.inspect(Puzzle01_1.solve())
