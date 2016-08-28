defmodule RaspberryPhoenix.TracksController do
  use RaspberryPhoenix.Web, :controller
  alias RaspberryPhoenix.Repo
  alias RaspberryPhoenix.Alarm
  alias RaspberryPhoenix.Track
  require Logger
  require IO

  def index(conn, _params) do

    tracks = RaspberryPhoenix.Repo.all from p in RaspberryPhoenix.Track, preload: [:alarm]
    #tracks = Track |> Repo.all
    IO.inspect tracks
    #json conn, tracks
    render(conn, "index.json", tracks: tracks)
    
  end

  def create(conn, track_params) do 

    File.cp(track_params["audio_file"].path, "/home/dev/tracks/" <> track_params["track_name"])

    track = %RaspberryPhoenix.Track{
      track_name: track_params["track_name"], 
      path: "/pi/tracks/", 
      artist: track_params["artist"], 
      album: track_params["album"],
      year: track_params["year"]      
    }

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

  def update(conn, track_params) do
    track = %RaspberryPhoenix.Track{
      track_name: track_params["track_name"], 
      path: "/pi/tracks/", 
      artist: track_params["artist"], 
      album: track_params["album"],
      year: track_params["year"]      
    }
    trck = Repo.get!(Track, track_params["id"])
    changeset = Track.changeset(trck, track_params)
    IO.puts changeset.valid?

    case Repo.update(changeset) do
      {:ok, track} -> json conn, %{"success": "success"}
      {:error, changeset} -> json conn, %{"error": :error}
    end
    
  end
end

