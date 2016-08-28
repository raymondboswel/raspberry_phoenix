defmodule RaspberryPhoenix.Alarm do
  use RaspberryPhoenix.Web, :model
  use Ecto.Model
  alias Ecto.DateTime
  @derive {Poison.Encoder, only: [:id, :time, :date, :description, :recurrence]}
  schema "alarms" do
    field :time, :integer
    field :date, Ecto.Date
    field :description, :string
    field :recurrence, :string
    belongs_to :tracks, RaspberryPhoenix.Track, foreign_key: :track_id 
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast( params, [:time, :date, :description, :recurrence])
  end
end
