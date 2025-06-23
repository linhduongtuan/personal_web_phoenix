defmodule PersonalWebWeb.BlogController do
  use PersonalWebWeb, :controller

  alias PersonalWeb.Blog

  def index(conn, _params) do
    posts = Blog.list_published_posts()
    render(conn, :index, posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    case Blog.get_post_by_slug(slug) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(PersonalWebWeb.ErrorHTML)
        |> render(:"404")
      
      post ->
        if post.published do
          render(conn, :show, post: post)
        else
          conn
          |> put_status(:not_found)
          |> put_view(PersonalWebWeb.ErrorHTML)
          |> render(:"404")
        end
    end
  end
end
