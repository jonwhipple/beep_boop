defmodule BeepBoop.ConversionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BeepBoop.Conversions` context.
  """

  @doc """
  Generate a conversion.
  """
  def conversion_fixture(attrs \\ %{}) do
    {:ok, conversion} =
      attrs
      |> Enum.into(%{
        binary: "some binary",
        input: "some input",
        markdown: "some markdown"
      })
      |> BeepBoop.Conversions.create_conversion()

    conversion
  end
end
