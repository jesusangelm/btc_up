defmodule BtcUp.Price do
  use Ecto.Schema

  schema "prices" do
    field :day, :date
    field :value, :float, default: 0.0
    timestamps()
  end
end
