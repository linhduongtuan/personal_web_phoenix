defmodule PersonalWebWeb.PageController do
  use PersonalWebWeb, :controller

  alias PersonalWeb.{Publications, Blog}

  def home(conn, _params) do
    recent_publications = Publications.list_publications() |> Enum.take(3)
    recent_posts = Blog.list_published_posts() |> Enum.take(3)
    
    render(conn, :home, 
      recent_publications: recent_publications,
      recent_posts: recent_posts
    )
  end

  def about(conn, _params) do
    render(conn, :about)
  end

  def research(conn, _params) do
    render(conn, :research)
  end

  def contact(conn, _params) do
    render(conn, :contact)
  end
end
