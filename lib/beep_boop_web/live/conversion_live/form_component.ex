defmodule BeepBoopWeb.ConversionLive.FormComponent do
  use BeepBoopWeb, :live_component

  alias BeepBoop.Conversions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage conversion records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="conversion-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:input]} type="text" label="Input" />
        <.input field={@form[:binary]} type="text" label="Binary" />
        <.input field={@form[:markdown]} type="text" label="Markdown" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Conversion</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{conversion: conversion} = assigns, socket) do
    changeset = Conversions.change_conversion(conversion)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"conversion" => conversion_params}, socket) do
    changeset =
      socket.assigns.conversion
      |> Conversions.change_conversion(conversion_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"conversion" => conversion_params}, socket) do
    save_conversion(socket, socket.assigns.action, conversion_params)
  end

  defp save_conversion(socket, :edit, conversion_params) do
    case Conversions.update_conversion(socket.assigns.conversion, conversion_params) do
      {:ok, conversion} ->
        notify_parent({:saved, conversion})

        {:noreply,
         socket
         |> put_flash(:info, "Conversion updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_conversion(socket, :new, conversion_params) do
    case Conversions.create_conversion(conversion_params) do
      {:ok, conversion} ->
        notify_parent({:saved, conversion})

        {:noreply,
         socket
         |> put_flash(:info, "Conversion created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
