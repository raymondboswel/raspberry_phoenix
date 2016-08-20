defmodule RaspberryPhoenix.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :track_name, :string
      add :path, :string
      add :artist, :string
      add :album, :string
      add :year, :string
      add :alarm_id, references(:alarms, on_delete: :nothing)

      timestamps()
    end
    create index(:tracks, [:alarm_id])

  end
end
