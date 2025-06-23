defmodule PersonalWeb.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :excerpt, :string
    field :slug, :string
    field :published, :boolean, default: false
    field :published_at, :naive_datetime
    field :author, :string
    field :tags, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :excerpt, :slug, :published, :published_at, :author, :tags])
    |> validate_required([:title, :content, :author])
    |> validate_length(:title, min: 1, max: 200)
    |> validate_length(:excerpt, max: 500)
    |> unique_constraint(:slug)
    |> maybe_generate_slug()
    |> maybe_set_published_at()
  end

  defp maybe_generate_slug(changeset) do
    case get_field(changeset, :slug) do
      nil ->
        case get_field(changeset, :title) do
          nil -> changeset
          title -> put_change(changeset, :slug, PersonalWeb.Blog.generate_slug(title))
        end
      _ -> changeset
    end
  end

  defp maybe_set_published_at(changeset) do
    if get_change(changeset, :published) == true and get_field(changeset, :published_at) == nil do
      put_change(changeset, :published_at, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
    else
      changeset
    end
  end
end
