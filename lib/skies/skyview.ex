defmodule Skies.Skyview do
  use GenServer

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(init_arg) do
    case System.get_env("SKY_PATH") do
      nil -> {:error, "SKY_PATH env var must be defined."}
      a -> {:ok, fetch_images(a)}
    end
  end

  def handle_call(:images, _from, state) do
    {:reply, state, state}
  end

  defp fetch_images(path) do
    Path.wildcard(path <> "/*.jpg")
    |> build_image_list([])
    |> Enum.map(fn img -> Task.async(fn -> process_image(img) end) end)
    |> Enum.map(&Task.await/1)
    |> Enum.filter(fn a -> a != nil end)
  end

  defp process_image(%{path: path} = img) do
    case Imago.get_fingerprint(path) do
      :error -> nil
      {:ok, print} -> %{ img | print: print }
    end
  end

  defp build_image_list([], acc), do: acc
  defp build_image_list([x | xs], acc) do
    img = %{ path: x, print: nil, url: "/skies/" <> Path.basename(x) }
    build_image_list(xs, [img | acc])
  end
end