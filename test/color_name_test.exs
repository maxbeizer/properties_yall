defmodule ColorNameTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  # https://hexdocs.pm/stream_data/StreamData.html#content
  # Until StreamData ships in Elixir add this to your mix.exs deps:
  #   {:stream_data, "~> 0.1", only: :test}

  property "color_name/3" do
    check all red <- StreamData.integer(0..255),
              green <- StreamData.integer(0..255),
              blue <- StreamData.integer(0..255),
              max_runs: 100_000 do
      assert color_name(red, green, blue) != :impossible_color
    end
  end

  def color_name(0, 0, 0), do: :black
  def color_name(255, 255, 255), do: :white
  def color_name(gray, gray, gray), do: :gray
  def color_name(red, green, blue) when red > green and red > blue, do: :red
  def color_name(red, green, blue) when green > red and green > blue, do: :green
  def color_name(red, green, blue) when blue > red and blue > green, do: :blue
  def color_name(red, green, blue) when red == green and red > blue, do: :yellow
  def color_name(red, green, blue) when green == blue and green > red, do: :cyan
  def color_name(red, green, blue) when red == blue and red > green, do: :purple
  def color_name(_, _, _), do: :impossible_color
end

# Note: these might come in handy ;)
