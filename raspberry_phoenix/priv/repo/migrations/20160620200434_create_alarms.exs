defmodule RaspberryPhoenix.Repo.Migrations.CreateAlarms do
  use Ecto.Migration

  def change do
    create table(:alarms) do
      add :time, :integer
      add :date, :date
      add :description, :string
      add :recurrence, :string, size: 40
    end
  end
end
