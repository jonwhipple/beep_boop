defmodule BeepBoopWeb.ConversionLiveTest do
  use BeepBoopWeb.ConnCase

  import Phoenix.LiveViewTest
  import BeepBoop.ConversionsFixtures

  @create_attrs %{binary: "some binary", input: "some input", markdown: "some markdown"}
  @update_attrs %{binary: "some updated binary", input: "some updated input", markdown: "some updated markdown"}
  @invalid_attrs %{binary: nil, input: nil, markdown: nil}

  defp create_conversion(_) do
    conversion = conversion_fixture()
    %{conversion: conversion}
  end

  describe "Index" do
    setup [:create_conversion]

    test "lists all conversions", %{conn: conn, conversion: conversion} do
      {:ok, _index_live, html} = live(conn, ~p"/conversions")

      assert html =~ "Listing Conversions"
      assert html =~ conversion.binary
    end

    test "saves new conversion", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/conversions")

      assert index_live |> element("a", "New Conversion") |> render_click() =~
               "New Conversion"

      assert_patch(index_live, ~p"/conversions/new")

      assert index_live
             |> form("#conversion-form", conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#conversion-form", conversion: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/conversions")

      html = render(index_live)
      assert html =~ "Conversion created successfully"
      assert html =~ "some binary"
    end

    test "updates conversion in listing", %{conn: conn, conversion: conversion} do
      {:ok, index_live, _html} = live(conn, ~p"/conversions")

      assert index_live |> element("#conversions-#{conversion.id} a", "Edit") |> render_click() =~
               "Edit Conversion"

      assert_patch(index_live, ~p"/conversions/#{conversion}/edit")

      assert index_live
             |> form("#conversion-form", conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#conversion-form", conversion: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/conversions")

      html = render(index_live)
      assert html =~ "Conversion updated successfully"
      assert html =~ "some updated binary"
    end

    test "deletes conversion in listing", %{conn: conn, conversion: conversion} do
      {:ok, index_live, _html} = live(conn, ~p"/conversions")

      assert index_live |> element("#conversions-#{conversion.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#conversions-#{conversion.id}")
    end
  end

  describe "Show" do
    setup [:create_conversion]

    test "displays conversion", %{conn: conn, conversion: conversion} do
      {:ok, _show_live, html} = live(conn, ~p"/conversions/#{conversion}")

      assert html =~ "Show Conversion"
      assert html =~ conversion.binary
    end

    test "updates conversion within modal", %{conn: conn, conversion: conversion} do
      {:ok, show_live, _html} = live(conn, ~p"/conversions/#{conversion}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Conversion"

      assert_patch(show_live, ~p"/conversions/#{conversion}/show/edit")

      assert show_live
             |> form("#conversion-form", conversion: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#conversion-form", conversion: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/conversions/#{conversion}")

      html = render(show_live)
      assert html =~ "Conversion updated successfully"
      assert html =~ "some updated binary"
    end
  end
end
