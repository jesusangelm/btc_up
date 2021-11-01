defmodule BtcUp.Repo.Migrations.AddPricesTable do
  use Ecto.Migration

  def change do
    create table("prices") do
      add :day, :date, null: false
      add :value, :float, null: false, default: 0.0

      timestamps()
    end

    create index("prices", [:day], unique: true)
  end
end
