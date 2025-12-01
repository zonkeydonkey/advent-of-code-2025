defmodule Puzzle01_2 do
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
      full_circles_count = Integer.floor_div(distance, 100)
      effective_distance = rem(distance, 100)
      case direction do
        "L" ->
          base = position - effective_distance
          {next_position, zero_clicked?} = cond do
            base < 0 ->
              {100 + base, position != 0}
            base == 0 and effective_distance != 0 ->
              {base, true}
            true ->
              {base, false}
          end

          {counter + full_circles_count + if(zero_clicked?, do: 1, else: 0), next_position}

        "R" ->
          base = position + effective_distance
          {next_position, zero_clicked?} = cond do
            base > 99 ->
              {base - 100, position != 0}
            base == 0 and effective_distance != 0 ->
              {base, true}
            true ->
              {base, false}
          end

          {counter + full_circles_count + if(zero_clicked?, do: 1, else: 0), next_position}
      end
    end)
  end

  defp parse_int!(str) do
    Integer.parse(str)
    |> elem(0)
  end
end

IO.inspect(Puzzle01_2.solve())
