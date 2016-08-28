defmodule RaspberryPhoenix.AlarmControllerTest do
  use RaspberryPhoenix.ConnCase

  alias RaspberryPhoenix.Alarm
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, alarm_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = get conn, alarm_path(conn, :show, alarm)
    assert json_response(conn, 200)["data"] == %{"id" => alarm.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, alarm_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, alarm_path(conn, :create), alarm: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Alarm, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, alarm_path(conn, :create), alarm: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = put conn, alarm_path(conn, :update, alarm), alarm: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Alarm, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = put conn, alarm_path(conn, :update, alarm), alarm: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    alarm = Repo.insert! %Alarm{}
    conn = delete conn, alarm_path(conn, :delete, alarm)
    assert response(conn, 204)
    refute Repo.get(Alarm, alarm.id)
  end
end
