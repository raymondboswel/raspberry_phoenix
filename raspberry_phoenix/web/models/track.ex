defmodule RaspberryPhoenix.Track do
  use RaspberryPhoenix.Web, :model
  import Ecto.Changeset

  schema "tracks" do
    field :track_name, :string
    field :path, :string
    field :artist, :string
    field :album, :string
    field :year, :string
    belongs_to :alarm, RaspberryPhoenix.Alarm

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
