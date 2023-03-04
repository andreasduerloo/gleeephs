defmodule Gleeph do
  def generate(incompleteness \\ 10) do
    to_check = Enum.to_list(0..23)
    map = Enum.zip(to_check, List.duplicate(false, 24)) |> Enum.into(%{})
    do_generate(map, to_check, incompleteness + 1)
  end

  defp do_generate(map, [], _i) do
    map
  end

  defp do_generate(map, to_check, i) do
    if i == 24 do
      map
    else
      position = Enum.random(to_check)
    if check(map, position) do
      do_generate(%{map | position => "#"}, to_check -- [position], i + 1)
    else
      do_generate(map, to_check -- [position], i + 1)
    end
    end
  end

  def convert(gleeph) when is_map(gleeph) do
    Map.to_list(gleeph) |> Enum.map(fn {k, v} -> if !v do {k, " "} else {k, v} end end) |> Enum.into(%{})
  end

  def draw(gleeph) when is_map(gleeph) do
    IO.puts("##{gleeph[0]}##{gleeph[1]}##{gleeph[2]}#")
    IO.puts("#{gleeph[3]} #{gleeph[4]} #{gleeph[5]} #{gleeph[6]}")
    IO.puts("##{gleeph[7]}##{gleeph[8]}##{gleeph[9]}#")
    IO.puts("#{gleeph[10]} #{gleeph[11]} #{gleeph[12]} #{gleeph[13]}")
    IO.puts("##{gleeph[14]}##{gleeph[15]}##{gleeph[16]}#")
    IO.puts("#{gleeph[17]} #{gleeph[18]} #{gleeph[19]} #{gleeph[20]}")
    IO.puts("##{gleeph[21]}##{gleeph[22]}##{gleeph[23]}#")
  end

  def draw_bold(gleeph) when is_map(gleeph) do
    IO.puts("###{gleeph[0]}#{gleeph[0]}###{gleeph[1]}#{gleeph[1]}###{gleeph[2]}#{gleeph[2]}##")
    IO.puts("###{gleeph[0]}#{gleeph[0]}###{gleeph[1]}#{gleeph[1]}###{gleeph[2]}#{gleeph[2]}##")
    IO.puts("#{gleeph[3]}#{gleeph[3]}  #{gleeph[4]}#{gleeph[4]}  #{gleeph[5]}#{gleeph[5]}  #{gleeph[6]}#{gleeph[6]}")
    IO.puts("#{gleeph[3]}#{gleeph[3]}  #{gleeph[4]}#{gleeph[4]}  #{gleeph[5]}#{gleeph[5]}  #{gleeph[6]}#{gleeph[6]}")
    IO.puts("###{gleeph[7]}#{gleeph[7]}###{gleeph[8]}#{gleeph[8]}###{gleeph[9]}#{gleeph[9]}##")
    IO.puts("###{gleeph[7]}#{gleeph[7]}###{gleeph[8]}#{gleeph[8]}###{gleeph[9]}#{gleeph[9]}##")
    IO.puts("#{gleeph[10]}#{gleeph[10]}  #{gleeph[11]}#{gleeph[11]}  #{gleeph[12]}#{gleeph[12]}  #{gleeph[13]}#{gleeph[13]}")
    IO.puts("#{gleeph[10]}#{gleeph[10]}  #{gleeph[11]}#{gleeph[11]}  #{gleeph[12]}#{gleeph[12]}  #{gleeph[13]}#{gleeph[13]}")
    IO.puts("###{gleeph[14]}#{gleeph[14]}###{gleeph[15]}#{gleeph[15]}###{gleeph[16]}#{gleeph[16]}##")
    IO.puts("###{gleeph[14]}#{gleeph[14]}###{gleeph[15]}#{gleeph[15]}###{gleeph[16]}#{gleeph[16]}##")
    IO.puts("#{gleeph[17]}#{gleeph[17]}  #{gleeph[18]}#{gleeph[18]}  #{gleeph[19]}#{gleeph[19]}  #{gleeph[20]}#{gleeph[20]}")
    IO.puts("#{gleeph[17]}#{gleeph[17]}  #{gleeph[18]}#{gleeph[18]}  #{gleeph[19]}#{gleeph[19]}  #{gleeph[20]}#{gleeph[20]}")
    IO.puts("###{gleeph[21]}#{gleeph[21]}###{gleeph[22]}#{gleeph[22]}###{gleeph[23]}#{gleeph[23]}##")
    IO.puts("###{gleeph[21]}#{gleeph[21]}###{gleeph[22]}#{gleeph[22]}###{gleeph[23]}#{gleeph[23]}##")
  end

  defp check(map, position) do # Return true if the edge at this position can be set to true
    # If either of the neighboring nodes already has two active edges, we cannot set this edge to true
    cond do
      position in [4, 5, 11, 12, 18, 19] ->
        first_neighbors = [map[position - 7], map[position - 4], map[position - 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 7], map[position + 4], map[position + 3]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position in [7, 8, 9, 14, 15, 16] ->
        first_neighbors = [map[position - 4], map[position - 1], map[position + 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 4], map[position + 1], map[position - 3]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position in [0, 1] ->
        first_neighbors = [map[position - 1], map[position + 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 1], map[position + 4]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position == 2 ->
        first_neighbors = [map[position - 1], map[position + 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 4]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position in [3, 10] ->
        first_neighbors = [map[position - 7], map[position - 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 4], map[position + 7]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position == 17 ->
        first_neighbors = [map[position - 7], map[position - 3]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 4]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position in [6, 13] ->
        first_neighbors = [map[position - 7], map[position - 4]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 3], map[position + 7]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position == 20 ->
        first_neighbors = [map[position - 7], map[position - 4]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position + 3]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position == 21 ->
        first_neighbors = [map[position - 3], map[position + 1]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position - 4]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
      position in [22, 23] ->
        first_neighbors = [map[position - 1], map[position - 4]] |> Enum.filter(&(&1)) |> Enum.count()
        second_neighbors = [map[position - 3], map[position + 1]] |> Enum.filter(&(&1)) |> Enum.count()
        count(first_neighbors, second_neighbors)
    end
  end

  defp count(a, b) do
    if a > 1 || b > 1 do
      false
    else
      true
    end
  end
end

Gleeph.generate() |> Gleeph.convert() |> Gleeph.draw_bold()
