defmodule RaspberryPhoenix.AlarmController do
  use RaspberryPhoenix.Web, :controller
  require Logger

  alias RaspberryPhoenix.Alarm

  def index(conn, _params) do
    alarms = RaspberryPhoenix.Repo.all from p in RaspberryPhoenix.Alarm,
              preload: [:tracks]
    render(conn, "index.json", alarms: alarms)
  end

  def create(conn, %{"alarm" => alarm_params}) do
    Logger.debug "Inside create"
    changeset = Alarm.changeset(%Alarm{}, alarm_params)

    case Repo.insert(changeset) do
      {:ok, alarm} ->
        intalarm = Repo.get!(Alarm, alarm.id)
        full = Repo.preload(alarm, :tracks)
        conn
        |> put_status(:created)
        |> put_resp_header("location", alarm_path(conn, :show, full))
        |> render("show.json", alarm: full)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RaspberryPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)
    render(conn, "show.json", alarm: alarm)
  end

  def update(conn, %{"id" => id, "alarm" => alarm_params}) do
    Logger.info "Inside update"
    alarm = Repo.get!(Alarm, id)
    changeset = Alarm.changeset(alarm, alarm_params)
    IO.inspect changeset
    case Repo.update(changeset) do
      {:ok, alarm} ->
        intalarm = Repo.get!(Alarm, alarm.id)
        full = Repo.preload(alarm, :tracks)
        render(conn, "show.json", alarm: full)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RaspberryPhoenix.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alarm = Repo.get!(Alarm, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(alarm)

    send_resp(conn, :no_content, "")
  end
end
