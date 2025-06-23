defmodule PersonalWeb.Repo.Migrations.CreatePublications do
  use Ecto.Migration

  def change do
    create table(:publications) do
      add :title, :string
      add :abstract, :text
      add :authors, :text
      add :journal, :string
      add :year, :integer
      add :doi, :string
      add :url, :string
      add :published_date, :date
      add :category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
