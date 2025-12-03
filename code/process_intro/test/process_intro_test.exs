defmodule ProcessIntroTest do
  use ExUnit.Case
  doctest ProcessIntro

  test "greets the world" do
    assert ProcessIntro.hello() == :world
  end
end
