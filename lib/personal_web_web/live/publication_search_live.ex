defmodule PersonalWebWeb.PublicationSearchLive do
  use PersonalWebWeb, :live_view

  alias PersonalWeb.Publications

  def mount(_params, _session, socket) do
    publications = Publications.list_publications()
    
    socket = 
      socket
      |> assign(:publications, publications)
      |> assign(:filtered_publications, publications)
      |> assign(:search_query, "")
      |> assign(:selected_year, "")
      |> assign(:selected_category, "")
      |> assign(:years, get_years())
      |> assign(:categories, get_categories())

    {:ok, socket}
  end

  def handle_event("search", %{"search" => search_params}, socket) do
    search_query = search_params["query"] || ""
    selected_year = search_params["year"] || ""
    selected_category = search_params["category"] || ""

    filtered_publications = filter_publications(
      socket.assigns.publications,
      search_query,
      selected_year,
      selected_category
    )

    socket = 
      socket
      |> assign(:filtered_publications, filtered_publications)
      |> assign(:search_query, search_query)
      |> assign(:selected_year, selected_year)
      |> assign(:selected_category, selected_category)

    {:noreply, socket}
  end

  defp filter_publications(publications, search_query, selected_year, selected_category) do
    publications
    |> filter_by_search(search_query)
    |> filter_by_year(selected_year)
    |> filter_by_category(selected_category)
  end

  defp filter_by_search(publications, ""), do: publications
  defp filter_by_search(publications, search_query) do
    query = String.downcase(search_query)
    
    Enum.filter(publications, fn pub ->
      String.contains?(String.downcase(pub.title), query) ||
      String.contains?(String.downcase(pub.authors), query) ||
      (pub.abstract && String.contains?(String.downcase(pub.abstract), query)) ||
      String.contains?(String.downcase(pub.journal), query)
    end)
  end

  defp filter_by_year(publications, ""), do: publications
  defp filter_by_year(publications, year) do
    {year_int, _} = Integer.parse(year)
    Enum.filter(publications, fn pub -> pub.year == year_int end)
  end

  defp filter_by_category(publications, ""), do: publications
  defp filter_by_category(publications, category) do
    Enum.filter(publications, fn pub -> pub.category == category end)
  end

  defp get_years do
    current_year = Date.utc_today().year
    Enum.to_list((current_year - 19)..current_year)
    |> Enum.reverse()
  end

  defp get_categories do
    ["journal", "conference", "book_chapter", "preprint", "thesis"]
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-6xl mx-auto px-4 py-8">
      <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-gray-900 mb-4">Publications</h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          A comprehensive list of my research publications, including journal articles, 
          conference papers, and other scholarly works.
        </p>
      </div>

      <!-- Search and Filter Section -->
      <div class="bg-gray-50 rounded-lg p-6 mb-8">
        <form phx-change="search" phx-submit="search">
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <label for="search_query" class="block text-sm font-medium text-gray-700 mb-2">
                Search Publications
              </label>
              <input
                type="text"
                name="search[query]"
                id="search_query"
                value={@search_query}
                placeholder="Search by title, author, or keyword..."
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            
            <div>
              <label for="year_filter" class="block text-sm font-medium text-gray-700 mb-2">
                Year
              </label>
              <select
                name="search[year]"
                id="year_filter"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">All Years</option>
                <%= for year <- @years do %>
                  <option value={year} selected={@selected_year == to_string(year)}>
                    <%= year %>
                  </option>
                <% end %>
              </select>
            </div>
            
            <div>
              <label for="category_filter" class="block text-sm font-medium text-gray-700 mb-2">
                Type
              </label>
              <select
                name="search[category]"
                id="category_filter"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                <option value="">All Types</option>
                <option value="journal" selected={@selected_category == "journal"}>Journal Articles</option>
                <option value="conference" selected={@selected_category == "conference"}>Conference Papers</option>
                <option value="book_chapter" selected={@selected_category == "book_chapter"}>Book Chapters</option>
                <option value="preprint" selected={@selected_category == "preprint"}>Preprints</option>
                <option value="thesis" selected={@selected_category == "thesis"}>Thesis</option>
              </select>
            </div>
          </div>
        </form>
        
        <div class="mt-4 text-sm text-gray-600">
          Showing <%= length(@filtered_publications) %> of <%= length(@publications) %> publications
        </div>
      </div>

      <!-- Publications List -->
      <div class="space-y-6">
        <%= for publication <- @filtered_publications do %>
          <article class="bg-white border border-gray-200 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow">
            <h3 class="text-xl font-semibold text-gray-900 mb-2">
              <.link navigate={~p"/publications/#{publication}"} class="text-blue-600 hover:text-blue-800 hover:underline">
                <%= publication.title %>
              </.link>
            </h3>
            
            <div class="flex flex-wrap gap-4 text-sm text-gray-600 mb-3">
              <div class="flex items-center gap-1">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
                <span><%= publication.authors %></span>
              </div>
              
              <div class="flex items-center gap-1">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                </svg>
                <span><%= publication.journal %></span>
              </div>
              
              <div class="flex items-center gap-1">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
                <span><%= publication.year %></span>
              </div>
              
              <span class="px-2 py-1 bg-gray-100 text-gray-700 rounded-full text-xs">
                <%= format_category(publication.category) %>
              </span>
            </div>

            <%= if publication.abstract do %>
              <p class="text-gray-600 text-sm mb-3 line-clamp-3">
                <%= publication.abstract %>
              </p>
            <% end %>

            <div class="flex flex-wrap gap-2">
              <%= if publication.doi do %>
                <a href={"https://doi.org/#{publication.doi}"} target="_blank" 
                   class="inline-flex items-center gap-1 px-3 py-1 text-xs bg-blue-100 text-blue-700 rounded-full hover:bg-blue-200 transition-colors">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                  </svg>
                  DOI
                </a>
              <% end %>
              
              <%= if publication.url do %>
                <a href={publication.url} target="_blank" 
                   class="inline-flex items-center gap-1 px-3 py-1 text-xs bg-green-100 text-green-700 rounded-full hover:bg-green-200 transition-colors">
                  <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                  </svg>
                  Paper
                </a>
              <% end %>
            </div>
          </article>
        <% end %>

        <%= if length(@filtered_publications) == 0 do %>
          <div class="text-center py-12">
            <svg class="w-12 h-12 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
            <h3 class="text-lg font-medium text-gray-900 mb-2">No publications found</h3>
            <p class="text-gray-600">Try adjusting your search criteria or filters.</p>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp format_category("journal"), do: "Journal Article"
  defp format_category("conference"), do: "Conference Paper"
  defp format_category("book_chapter"), do: "Book Chapter"
  defp format_category("preprint"), do: "Preprint"
  defp format_category("thesis"), do: "Thesis"
  defp format_category(category), do: String.capitalize(category)
end
