defmodule Games.ShortgamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Games.Shortgames` context.
  """

  @doc """
  Generate a rps.
  """
  def rps_fixture(attrs \\ %{}) do
    {:ok, rps} =
      attrs
      |> Enum.into(%{
        computer_score: 42,
        message: "some message",
        rand_number: 42,
        user_score: 42
      })
      |> Games.Shortgames.create_rps()

    rps
  end
end
