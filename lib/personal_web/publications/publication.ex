defmodule PersonalWeb.Publications.Publication do
  use Ecto.Schema
  import Ecto.Changeset

  schema "publications" do
    field :title, :string
    field :abstract, :string
    field :authors, :string
    field :journal, :string
    field :year, :integer
    field :doi, :string
    field :url, :string
    field :published_date, :date
    field :category, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(publication, attrs) do
    publication
    |> cast(attrs, [:title, :abstract, :authors, :journal, :year, :doi, :url, :published_date, :category])
    |> validate_required([:title, :authors, :year, :category])
    |> validate_length(:title, min: 1, max: 500)
    |> validate_length(:abstract, max: 5000)
    |> validate_inclusion(:category, ["journal", "conference", "book_chapter", "preprint", "thesis"])
    |> validate_number(:year, greater_than: 1900, less_than_or_equal_to: Date.utc_today().year + 10)
  end
end
