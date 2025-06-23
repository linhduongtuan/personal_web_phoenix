defmodule PersonalWeb.Publications do
  @moduledoc """
  The Publications context.
  """

  import Ecto.Query, warn: false
  alias PersonalWeb.Repo

  alias PersonalWeb.Publications.Publication

  @doc """
  Returns the list of publications.

  ## Examples

      iex> list_publications()
      [%Publication{}, ...]

  """
  def list_publications do
    Repo.all(from p in Publication, order_by: [desc: p.year, desc: p.published_date])
  end

  @doc """
  Returns the list of publications by category.

  ## Examples

      iex> list_publications_by_category("journal")
      [%Publication{}, ...]

  """
  def list_publications_by_category(category) do
    Repo.all(from p in Publication, where: p.category == ^category, order_by: [desc: p.year, desc: p.published_date])
  end

  @doc """
  Gets a single publication.

  Raises `Ecto.NoResultsError` if the Publication does not exist.

  ## Examples

      iex> get_publication!(123)
      %Publication{}

      iex> get_publication!(456)
      ** (Ecto.NoResultsError)

  """
  def get_publication!(id), do: Repo.get!(Publication, id)

  @doc """
  Creates a publication.

  ## Examples

      iex> create_publication(%{field: value})
      {:ok, %Publication{}}

      iex> create_publication(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_publication(attrs \\ %{}) do
    %Publication{}
    |> Publication.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a publication.

  ## Examples

      iex> update_publication(publication, %{field: new_value})
      {:ok, %Publication{}}

      iex> update_publication(publication, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_publication(%Publication{} = publication, attrs) do
    publication
    |> Publication.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a publication.

  ## Examples

      iex> delete_publication(publication)
      {:ok, %Publication{}}

      iex> delete_publication(publication)
      {:error, %Ecto.Changeset{}}

  """
  def delete_publication(%Publication{} = publication) do
    Repo.delete(publication)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking publication changes.

  ## Examples

      iex> change_publication(publication)
      %Ecto.Changeset{data: %Publication{}}

  """
  def change_publication(%Publication{} = publication, attrs \\ %{}) do
    Publication.changeset(publication, attrs)
  end
end
