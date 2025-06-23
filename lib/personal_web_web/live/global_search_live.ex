defmodule PersonalWebWeb.GlobalSearchLive do
  use PersonalWebWeb, :live_component

  alias PersonalWeb.Search

  def mount(socket) do
    socket = 
      socket
      |> assign(:query, "")
      |> assign(:results, %{publications: [], posts: [], total_count: 0})
      |> assign(:suggestions, [])
      |> assign(:show_suggestions, false)
      |> assign(:loading, false)

    {:ok, socket}
  end

  def handle_event("search_input", %{"query" => query}, socket) do
    query = String.trim(query)
    
    socket = 
      socket
      |> assign(:query, query)
      |> assign(:loading, false)
    
    # Show suggestions for queries 2+ characters
    socket = if String.length(query) >= 2 do
      suggestions = Search.get_suggestions(query)
      socket
      |> assign(:suggestions, suggestions)
      |> assign(:show_suggestions, true)
    else
      socket
      |> assign(:suggestions, [])
      |> assign(:show_suggestions, false)
    end

    {:noreply, socket}
  end

  def handle_event("search_submit", %{"query" => query}, socket) do
    query = String.trim(query)
    
    socket = 
      socket
      |> assign(:loading, true)
      |> assign(:show_suggestions, false)
    
    # Perform search
    results = Search.global_search(query)
    
    socket = 
      socket
      |> assign(:query, query)
      |> assign(:results, results)
      |> assign(:loading, false)

    {:noreply, socket}
  end

  def handle_event("suggestion_click", %{"suggestion" => suggestion}, socket) do
    results = Search.global_search(suggestion)
    
    socket = 
      socket
      |> assign(:query, suggestion)
      |> assign(:results, results)
      |> assign(:show_suggestions, false)
      |> assign(:loading, false)

    {:noreply, socket}
  end

  def handle_event("clear_search", _params, socket) do
    socket = 
      socket
      |> assign(:query, "")
      |> assign(:results, %{publications: [], posts: [], total_count: 0})
      |> assign(:suggestions, [])
      |> assign(:show_suggestions, false)
      |> assign(:loading, false)

    {:noreply, socket}
  end

  def handle_event("hide_suggestions", _params, socket) do
    # Add small delay to allow suggestion clicks to register
    Process.send_after(self(), :hide_suggestions, 150)
    {:noreply, socket}
  end

  def handle_info(:hide_suggestions, socket) do
    {:noreply, assign(socket, :show_suggestions, false)}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full max-w-4xl mx-auto">
      <!-- Search Bar -->
      <div class="relative">
        <form phx-submit="search_submit" class="relative">
          <div class="relative">
            <input
              type="text"
              name="query"
              value={@query}
              phx-keyup="search_input"
              phx-blur="hide_suggestions"
              phx-debounce="300"
              placeholder="Search my research, publications, blog posts..."
              class="w-full px-6 py-4 pr-12 text-lg border-2 border-gray-300 rounded-full bg-white text-gray-900 focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-200 shadow-lg"
              autocomplete="off"
            />
            <div class="absolute right-4 top-1/2 transform -translate-y-1/2 flex items-center space-x-2">
              <%= if @loading do %>
                <svg class="animate-spin h-5 w-5 text-blue-500" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
              <% else %>
                <%= if @query != "" do %>
                  <button type="button" phx-click="clear_search" class="text-gray-400 hover:text-gray-600">
                    <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                  </button>
                <% end %>
                <button type="submit" class="text-blue-500 hover:text-blue-700">
                  <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                  </svg>
                </button>
              <% end %>
            </div>
          </div>
        </form>

        <!-- Search Suggestions -->
        <%= if @show_suggestions and length(@suggestions) > 0 do %>
          <div class="absolute z-50 w-full mt-2 bg-white border border-gray-200 rounded-lg shadow-lg">
            <%= for suggestion <- @suggestions do %>
              <button
                type="button"
                phx-click="suggestion_click"
                phx-value-suggestion={suggestion}
                class="w-full px-4 py-3 text-left hover:bg-gray-50 border-b border-gray-100 last:border-b-0 text-gray-900"
              >
                <div class="flex items-center">
                  <svg class="h-4 w-4 text-gray-400 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                  </svg>
                  <%= suggestion %>
                </div>
              </button>
            <% end %>
          </div>
        <% end %>
      </div>

      <!-- Search Results -->
      <%= if @query != "" and @results.total_count > 0 do %>
        <div class="mt-8 space-y-8">
          <div class="text-center">
            <h2 class="text-2xl font-bold text-white mb-2">Search Results</h2>
            <p class="text-blue-100">Found <%= @results.total_count %> results for "<%= @query %>"</p>
          </div>

          <!-- Publications Results -->
          <%= if length(@results.publications) > 0 do %>
            <div class="bg-white rounded-lg shadow-lg p-6">
              <h3 class="text-xl font-bold text-gray-900 mb-4">
                Publications (<%= length(@results.publications) %>)
              </h3>
              <div class="space-y-4">
                <%= for publication <- @results.publications do %>
                  <div class="border-l-4 border-blue-500 pl-4">
                    <h4 class="font-semibold text-gray-900 mb-1">
                      <.link 
                        navigate={~p"/publications/#{publication}"} 
                        class="text-blue-600 hover:text-blue-800 hover:underline"
                      >
                        <%= publication.title %>
                      </.link>
                    </h4>
                    <p class="text-sm text-gray-600 mb-2">
                      <%= publication.authors %> • <%= publication.journal %> • <%= publication.year %>
                    </p>
                    <%= if publication.abstract do %>
                      <p class="text-sm text-gray-700 line-clamp-2">
                        <%= String.slice(publication.abstract, 0, 150) %><%= if String.length(publication.abstract) > 150, do: "..." %>
                      </p>
                    <% end %>
                  </div>
                <% end %>
              </div>
              <%= if length(@results.publications) == 10 do %>
                <div class="mt-4 text-center">
                  <.link navigate="/publications" class="text-blue-600 hover:text-blue-800 text-sm">
                    View all publications →
                  </.link>
                </div>
              <% end %>
            </div>
          <% end %>

          <!-- Blog Posts Results -->
          <%= if length(@results.posts) > 0 do %>
            <div class="bg-white rounded-lg shadow-lg p-6">
              <h3 class="text-xl font-bold text-gray-900 mb-4">
                Blog Posts (<%= length(@results.posts) %>)
              </h3>
              <div class="space-y-4">
                <%= for post <- @results.posts do %>
                  <div class="border-l-4 border-green-500 pl-4">
                    <h4 class="font-semibold text-gray-900 mb-1">
                      <.link 
                        navigate={~p"/blog/#{post.slug}"} 
                        class="text-green-600 hover:text-green-800 hover:underline"
                      >
                        <%= post.title %>
                      </.link>
                    </h4>
                    <p class="text-sm text-gray-600 mb-2">
                      <%= Calendar.strftime(post.published_at, "%B %d, %Y") %>
                    </p>
                    <p class="text-sm text-gray-700 line-clamp-2">
                      <%= post.excerpt %>
                    </p>
                  </div>
                <% end %>
              </div>
              <%= if length(@results.posts) == 10 do %>
                <div class="mt-4 text-center">
                  <.link navigate="/blog" class="text-green-600 hover:text-green-800 text-sm">
                    View all blog posts →
                  </.link>
                </div>
              <% end %>
            </div>
          <% end %>
        </div>
      <% end %>

      <!-- No Results -->
      <%= if @query != "" and @results.total_count == 0 do %>
        <div class="mt-8 text-center">
          <div class="bg-white rounded-lg shadow-lg p-8">
            <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
            </svg>
            <h3 class="text-xl font-bold text-gray-900 mb-2">No results found</h3>
            <p class="text-gray-600 mb-4">
              Sorry, we couldn't find any content matching "<%= @query %>".
            </p>
            <p class="text-sm text-gray-500">
              Try searching for research topics, publication titles, or blog post keywords.
            </p>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
