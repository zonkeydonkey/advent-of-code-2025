defmodule Puzzle02_2 do
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
    if use_problem_dampener_at_beginning?(report) do # TODO - check if maybe better to remove second
      report_valid?(Enum.slice(report, 1..-1//1), increasing?(report, 1, 2), true)
    else
      report_valid?(report, increasing?(report, 0, 1), false)
    end
    |> elem(0)
    |> IO.inspect()
  end

  defp report_valid?(report, increasing?, initial_problem_dampener_used?) do
    0..(length(report) - 2)
    |> Enum.reduce_while({initial_problem_dampener_used?, true}, fn i,
                                                                    {problem_dampener_used?,
                                                                     _result} = acc ->
      cond do
        adjacent_levels_valid?(Enum.at(report, i), Enum.at(report, i + 1), increasing?) ->
          {:cont, acc}

        problem_dampener_used? ->
          {:halt, {problem_dampener_used?, false}}

        i + 2 == length(report) ->
          {:halt, {true, true}}

        adjacent_levels_valid?(Enum.at(report, i), Enum.at(report, i + 2), increasing?) ->
          {:cont, {true, true}}

        true ->
          {:halt, {true, false}}
      end
    end)
  end

  defp use_problem_dampener_at_beginning?(report) do
    diff_between_0_1 = Enum.at(report, 0) - Enum.at(report, 1)
    diff_between_1_2 = Enum.at(report, 1) - Enum.at(report, 2)

    (diff_between_0_1 > 0 and diff_between_1_2 < 0) or
      (diff_between_0_1 < 0 and diff_between_1_2 > 0)
  end

  defp increasing?(report, left_index, right_index) do
    Enum.at(report, left_index) - Enum.at(report, right_index) < 0
  end

  defp adjacent_levels_valid?(left, right, increasing?) do
    diff = left - right

    abs(diff) > 0 and abs(diff) < 4 and
      ((diff < 0 and increasing?) or (diff > 0 and not increasing?))
  end
end

IO.inspect(Puzzle02_2.solve())
