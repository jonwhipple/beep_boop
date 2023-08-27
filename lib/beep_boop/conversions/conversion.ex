defmodule BeepBoop.Conversions.Conversion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversions" do
    field :binary, :string
    field :input, :string
    field :markdown, :string

    timestamps()
  end

  @doc false
  def changeset(conversion, attrs) do
    conversion
    |> cast(attrs, [:input, :binary, :markdown])
    |> validate_required([:input, :binary, :markdown])
  end
end
