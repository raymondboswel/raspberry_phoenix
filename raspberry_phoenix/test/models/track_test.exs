defmodule RaspberryPhoenix.TrackTest do
  use RaspberryPhoenix.ModelCase

  alias RaspberryPhoenix.Track

  @valid_attrs %{album: "some content", artist: "some content", path: "some content", track_name: "some content", year: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Track.changeset(%Track{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Track.changeset(%Track{}, @invalid_attrs)
    refute changeset.valid?
  end
end
