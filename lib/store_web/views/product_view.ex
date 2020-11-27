defmodule Elementary.StoreWeb.ProductView do
  use Elementary.StoreWeb, :view

  @variant_keys ~w(color size)a

  def variants(variants, key) do
    variants
    |> Enum.map(&Map.get(&1, key))
    |> Enum.uniq()
  end

  def variant_for(variants, variant, changes \\ []) do
    change_keys = Keyword.keys(changes)
    same_keys = Enum.reject(@variant_keys, &Enum.member?(change_keys, &1))

    variants
    |> Enum.filter(fn v ->
      Enum.all?(same_keys, &(variant[&1] === v[&1]))
    end)
    |> Enum.filter(fn v ->
      Enum.all?(changes, fn {ck, cv} -> v[ck] === cv end)
    end)
    |> List.first()
  end

  def size_text(:extra_small), do: dgettext("product", "XS")
  def size_text(:small), do: dgettext("product", "S")
  def size_text(:medium), do: dgettext("product", "M")
  def size_text(:large), do: dgettext("product", "L")
  def size_text(:extra_large), do: dgettext("product", "XL")
  def size_text(:two_extra_large), do: dgettext("product", "2XL")
  def size_text(:three_extra_large), do: dgettext("product", "3XL")
  def size_text(:four_extra_large), do: dgettext("product", "4XL")
  def size_text(text), do: text

  def color_text(:charcoal), do: dgettext("product", "Charcoal-Black Triblend")
  def color_text(:aqua), do: dgettext("product", "Aqua Triblend")
  def color_text(:oatmeal), do: dgettext("product", "Oatmeal Triblend")
  def color_text(:white), do: dgettext("product", "White Fleck Triblend")
  def color_text(:purple), do: dgettext("product", "Purple Triblend")
  def color_text(text), do: text
end
