defmodule BeepBoopWeb.ConversionLive.Index do
  use BeepBoopWeb, :live_view

  alias BeepBoop.Conversions
  alias BeepBoop.Conversions.Conversion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :conversions, Conversions.list_conversions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Conversion")
    |> assign(:conversion, Conversions.get_conversion!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Conversion")
    |> assign(:conversion, %Conversion{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Conversions")
    |> assign(:conversion, nil)
  end

  @impl true
  def handle_info({BeepBoopWeb.ConversionLive.FormComponent, {:saved, conversion}}, socket) do
    {:noreply, stream_insert(socket, :conversions, conversion)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    conversion = Conversions.get_conversion!(id)
    {:ok, _} = Conversions.delete_conversion(conversion)

    {:noreply, stream_delete(socket, :conversions, conversion)}
  end
end
