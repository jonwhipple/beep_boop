defmodule BeepBoop.ConversionsTest do
  use BeepBoop.DataCase

  alias BeepBoop.Conversions

  describe "conversions" do
    alias BeepBoop.Conversions.Conversion

    import BeepBoop.ConversionsFixtures

    @invalid_attrs %{binary: nil, input: nil, markdown: nil}

    test "list_conversions/0 returns all conversions" do
      conversion = conversion_fixture()
      assert Conversions.list_conversions() == [conversion]
    end

    test "get_conversion!/1 returns the conversion with given id" do
      conversion = conversion_fixture()
      assert Conversions.get_conversion!(conversion.id) == conversion
    end

    test "create_conversion/1 with valid data creates a conversion" do
      valid_attrs = %{binary: "some binary", input: "some input", markdown: "some markdown"}

      assert {:ok, %Conversion{} = conversion} = Conversions.create_conversion(valid_attrs)
      assert conversion.binary == "some binary"
      assert conversion.input == "some input"
      assert conversion.markdown == "some markdown"
    end

    test "create_conversion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Conversions.create_conversion(@invalid_attrs)
    end

    test "update_conversion/2 with valid data updates the conversion" do
      conversion = conversion_fixture()
      update_attrs = %{binary: "some updated binary", input: "some updated input", markdown: "some updated markdown"}

      assert {:ok, %Conversion{} = conversion} = Conversions.update_conversion(conversion, update_attrs)
      assert conversion.binary == "some updated binary"
      assert conversion.input == "some updated input"
      assert conversion.markdown == "some updated markdown"
    end

    test "update_conversion/2 with invalid data returns error changeset" do
      conversion = conversion_fixture()
      assert {:error, %Ecto.Changeset{}} = Conversions.update_conversion(conversion, @invalid_attrs)
      assert conversion == Conversions.get_conversion!(conversion.id)
    end

    test "delete_conversion/1 deletes the conversion" do
      conversion = conversion_fixture()
      assert {:ok, %Conversion{}} = Conversions.delete_conversion(conversion)
      assert_raise Ecto.NoResultsError, fn -> Conversions.get_conversion!(conversion.id) end
    end

    test "change_conversion/1 returns a conversion changeset" do
      conversion = conversion_fixture()
      assert %Ecto.Changeset{} = Conversions.change_conversion(conversion)
    end
  end
end
