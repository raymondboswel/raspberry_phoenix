defmodule RaspberryPhoenix.TracksView do
  use RaspberryPhoenix.Web, :view
  require Logger
  require IO

  def render("index.json", %{tracks: tracks}) do
  	Logger.debug "**************In view***************"
  	IO.inspect tracks
    %{data: render_many(tracks, RaspberryPhoenix.TracksView, "track.json")}
  end

  def render("show.json", %{track: track}) do
    %{data: render_one(track, RaspberryPhoenix.TracksView, "track.json")}
  end

  def render("track.json", %{tracks: track}) do
  	Logger.debug "**************In track.json***************"
  	IO.inspect track
    %{
      id: track.id,
      track_name: track.track_name,
      artist: track.artist,
      album: track.album,
      year: track.year,      
     }
  end


end
