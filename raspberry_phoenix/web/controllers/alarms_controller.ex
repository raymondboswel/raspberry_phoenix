defmodule RaspberryPhoenix.AlarmsController do
  use RaspberryPhoenix.Web, :controller
  alias RaspberryPhoenix.Repo
  alias RaspberryPhoenix.Alarm
  require Logger
  require IO

  def alarms(conn, _params) do
    alarms = Repo.all(Alarm)
    json conn, alarms
  end

  def alarm(conn, %{"time" => time, "day" =>day, "month"=>month, "year"=>year, "date" => date, "description" => description, "recurrence" => recurrence}) do     
    
     ectoDate =  Ecto.Date.from_erl({year, month, day})
     #ectoDate = Ecto.Date.from_erl({2015, 3, 2})
     Logger.debug ectoDate
     
     alarm = %RaspberryPhoenix.Alarm{time: time, date: ectoDate, description: description, recurrence: recurrence}
    Logger.debug alarm.description
    Repo.insert alarm
    Logger.debug "Inserted alarm"
    json conn, %{"success": "success"}
  end

  def delete(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)
    case Repo.delete alarm do
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

