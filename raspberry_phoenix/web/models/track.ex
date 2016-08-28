defmodule RaspberryPhoenix.Track do
  use RaspberryPhoenix.Web, :model
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :track_name, :path, :artist, :album, :year]}
  schema "tracks" do
    field :track_name, :string
    field :path, :string
    field :artist, :string
    field :album, :string
    field :year, :string
    has_many :alarm, RaspberryPhoenix.Alarm

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:track_name, :path, :artist, :album, :year])

#    |> validate_required([:track_name, :path])
  end
end
