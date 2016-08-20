defmodule RaspberryPhoenix.TracksController do
  use RaspberryPhoenix.Web, :controller
  alias RaspberryPhoenix.Repo
  alias RaspberryPhoenix.Alarm
  alias RaspberryPhoenix.Track
  require Logger
  require IO

  def index(conn, _params) do
    #tracks = Repo.all from p in Track,
     #         preload: [:alarm]
    tracks = Track |> Repo.all |> Repo.preload([:alarm])
    json conn, tracks
  end

  def create(conn, track_params) do 

    File.cp(track_params["audio_file"].path, "/home/dev/tracks/" <> track_params["track_name"])

    alarm = Repo.get!(Alarm, track_params["alarm_id"])

    track = Ecto.build_assoc(
      alarm,
      :tracks,
      track_name: track_params["track_name"], 
      path: "/pi/tracks/", 
      artist: track_params["artist"], 
      album: track_params["album"],
      year: track_params["year"]
      
    )
       
    IO.inspect track

    Repo.insert track
   # alarm = %RaspberryPhoenix.Alarm{time: time, date: ectoDate, description: description, recurrence: recurrence}
   # Logger.debug alarm.description
   # Repo.insert alarm
   # Logger.debug "Inserted alarm"
    json conn, %{"success": "success"}
  end

  def delete(conn, %{"id" => id}) do
    track = Repo.get!(Track, id)
    case Repo.delete track do
      {:ok, struct} -> json conn, %{"success": "success"}
      {:error, changeset} -> json conn, %{"error": :error}
    end
  end

  def update(conn, %{"alarm" => alarm_params, "id" => id}) do
    alrm = Repo.get!(Alarm, id)
    changeset = Alarm.changeset(alrm, alarm_params)
    IO.puts changeset.valid?

    case Repo.update(changeset) do
      {:ok, alarm} -> json conn, %{"success": "success"}
      {:error, changeset} -> json conn, %{"error": :error}
    end
    
  end
end

