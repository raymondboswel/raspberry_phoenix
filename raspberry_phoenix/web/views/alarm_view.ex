defmodule RaspberryPhoenix.AlarmView do
  use RaspberryPhoenix.Web, :view
  require Logger
  require IO

  def render("index.json", %{alarms: alarms}) do
    Logger.debug "**************In index.json***************"
    IO.inspect alarms
    %{data: render_many(alarms, RaspberryPhoenix.AlarmView, "alarm.json")}
  end

  def render("show.json", %{alarm: alarm}) do
    Logger.debug "In show"
    %{data: render_one(alarm, RaspberryPhoenix.AlarmView, "alarm.json")}
  end

  def render("alarm.json", %{alarm: alarm}) do
    Logger.debug "**************In alarm.json***************"
    IO.inspect alarm
    %{
        id: alarm.id,
        date: alarm.date,
        time: alarm.time,
        description: alarm.description,
        recurrence: alarm.recurrence,
        track: render_one(alarm.tracks, __MODULE__, "track.json", as: :track)
     }
  end

  def render("track.json", %{track: track}) do
    %{
      id: track.id,
      track_name: track.track_name,
      artist: track.artist,
      album: track.album,
      year: track.year
     }
  end
end
