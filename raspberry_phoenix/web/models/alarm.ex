defmodule RaspberryPhoenix.Alarm do
  use RaspberryPhoenix.Web, :model
  use Ecto.Model
  alias Ecto.DateTime
  
  schema "alarms" do
    field :time, :integer
    field :date, Ecto.Date
    field :description, :string
    field :recurrence, :string
    
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast( params, [:time, :date, :description, :recurrence])
  end
end
