defmodule PersonalWebWeb.PublicationController do
  use PersonalWebWeb, :controller

  alias PersonalWeb.Publications

  def index(conn, _params) do
    publications = Publications.list_publications()
    journal_papers = Publications.list_publications_by_category("journal")
    conference_papers = Publications.list_publications_by_category("conference")
    book_chapters = Publications.list_publications_by_category("book_chapter")
    preprints = Publications.list_publications_by_category("preprint")
    
    render(conn, :index, 
      publications: publications,
      journal_papers: journal_papers,
      conference_papers: conference_papers,
      book_chapters: book_chapters,
      preprints: preprints
    )
  end

  def show(conn, %{"id" => id}) do
    publication = Publications.get_publication!(id)
    render(conn, :show, publication: publication)
  end
end
