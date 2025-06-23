defmodule PersonalWeb.Search do
  @moduledoc """
  The Search context for global website search functionality.
  """

  alias PersonalWeb.Repo
  alias PersonalWeb.Publications.Publication
  alias PersonalWeb.Blog.Post
  import Ecto.Query, warn: false

  @doc """
  Performs a global search across all content types.
  Returns a map with results categorized by type.
  """
  def global_search(""), do: %{publications: [], posts: [], total_count: 0}
  
  def global_search(query) when is_binary(query) do
    search_term = String.downcase(String.trim(query))
    
    publications = search_publications(search_term)
    posts = search_posts(search_term)
    
    %{
      publications: publications,
      posts: posts,
      total_count: length(publications) + length(posts)
    }
  end

  @doc """
  Searches publications by title, abstract, authors, and journal.
  """
  def search_publications(search_term) when is_binary(search_term) do
    query_pattern = "%#{search_term}%"
    
    Publication
    |> where([p], 
      ilike(p.title, ^query_pattern) or
      ilike(p.abstract, ^query_pattern) or
      ilike(p.authors, ^query_pattern) or
      ilike(p.journal, ^query_pattern)
    )
    |> order_by([p], desc: p.year, desc: p.published_date)
    |> limit(10)
    |> Repo.all()
  end

  @doc """
  Searches blog posts by title, content, excerpt, and tags.
  """
  def search_posts(search_term) when is_binary(search_term) do
    query_pattern = "%#{search_term}%"
    
    Post
    |> where([p], p.published == true)
    |> where([p],
      ilike(p.title, ^query_pattern) or
      ilike(p.content, ^query_pattern) or
      ilike(p.excerpt, ^query_pattern) or
      ilike(p.tags, ^query_pattern)
    )
    |> order_by([p], desc: p.published_at)
    |> limit(10)
    |> Repo.all()
  end

  @doc """
  Gets search suggestions based on partial input.
  """
  def get_suggestions(query) when is_binary(query) and byte_size(query) >= 2 do
    search_term = String.downcase(String.trim(query))
    query_pattern = "%#{search_term}%"
    
    # Get publication titles that match
    publication_titles = 
      Publication
      |> select([p], p.title)
      |> where([p], ilike(p.title, ^query_pattern))
      |> limit(5)
      |> Repo.all()
    
    # Get post titles that match
    post_titles = 
      Post
      |> select([p], p.title)
      |> where([p], p.published == true and ilike(p.title, ^query_pattern))
      |> limit(5)
      |> Repo.all()
    
    # Get unique tag suggestions
    tag_suggestions = 
      Post
      |> select([p], p.tags)
      |> where([p], p.published == true and ilike(p.tags, ^query_pattern))
      |> limit(5)
      |> Repo.all()
      |> Enum.flat_map(&String.split(&1, ","))
      |> Enum.map(&String.trim/1)
      |> Enum.filter(&String.contains?(String.downcase(&1), search_term))
      |> Enum.uniq()
      |> Enum.take(3)
    
    (publication_titles ++ post_titles ++ tag_suggestions)
    |> Enum.uniq()
    |> Enum.take(8)
  end
  
  def get_suggestions(_), do: []
end
