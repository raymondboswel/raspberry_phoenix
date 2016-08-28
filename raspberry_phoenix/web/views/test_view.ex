defmodule RaspberryPhoenix.TestView do
  use RaspberryPhoenix.Web, :view

  def render("index.json", %{tests: tests}) do
    %{data: render_many(tests, RaspberryPhoenix.TestView, "test.json")}
  end

  def render("show.json", %{test: test}) do
    %{data: render_one(test, RaspberryPhoenix.TestView, "test.json")}
  end

  def render("test.json", %{test: test}) do
    %{id: test.id,
      test: test.test}
  end
end
