defmodule BeepBoopWeb.ConversionLive.Show do
  use BeepBoopWeb, :live_view

  alias BeepBoop.Conversions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:conversion, Conversions.get_conversion!(id))}
  end

  defp page_title(:show), do: "Show Conversion"
  defp page_title(:edit), do: "Edit Conversion"
end
