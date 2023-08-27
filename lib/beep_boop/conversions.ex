defmodule BeepBoop.Conversions do
  @moduledoc """
  The Conversions context.
  """

  import Ecto.Query, warn: false
  alias BeepBoop.Repo

  alias BeepBoop.Conversions.Conversion

  @doc """
  Returns the list of conversions.

  ## Examples

      iex> list_conversions()
      [%Conversion{}, ...]

  """
  def list_conversions do
    Repo.all(Conversion)
  end

  @doc """
  Gets a single conversion.

  Raises `Ecto.NoResultsError` if the Conversion does not exist.

  ## Examples

      iex> get_conversion!(123)
      %Conversion{}

      iex> get_conversion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conversion!(id), do: Repo.get!(Conversion, id)

  @doc """
  Creates a conversion.

  ## Examples

      iex> create_conversion(%{field: value})
      {:ok, %Conversion{}}

      iex> create_conversion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conversion(attrs \\ %{}) do
    %Conversion{}
    |> Conversion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversion.

  ## Examples

      iex> update_conversion(conversion, %{field: new_value})
      {:ok, %Conversion{}}

      iex> update_conversion(conversion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conversion(%Conversion{} = conversion, attrs) do
    conversion
    |> Conversion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a conversion.

  ## Examples

      iex> delete_conversion(conversion)
      {:ok, %Conversion{}}

      iex> delete_conversion(conversion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conversion(%Conversion{} = conversion) do
    Repo.delete(conversion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversion changes.

  ## Examples

      iex> change_conversion(conversion)
      %Ecto.Changeset{data: %Conversion{}}

  """
  def change_conversion(%Conversion{} = conversion, attrs \\ %{}) do
    Conversion.changeset(conversion, attrs)
  end
end
