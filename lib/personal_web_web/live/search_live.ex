defmodule PersonalWebWeb.SearchLive do
  use PersonalWebWeb, :live_view

  alias PersonalWeb.Search

  def mount(_params, _session, socket) do
    socket = 
      socket
      |> assign(:query, "")
      |> assign(:results, %{publications: [], posts: [], total_count: 0})
      |> assign(:suggestions, [])
      |> assign(:show_suggestions, false)
      |> assign(:loading, false)
      |> assign(:has_searched, false)

    {:ok, socket}
  end

  def handle_params(%{"q" => query}, _uri, socket) when query != "" do
    results = Search.global_search(query)
    
    socket = 
      socket
      |> assign(:query, query)
      |> assign(:results, results)
      |> assign(:has_searched, true)
      |> assign(:loading, false)

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
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
    
    if query != "" do
      {:noreply, push_patch(socket, to: ~p"/search?#{[q: query]}")}
    else
      {:noreply, socket}
    end
  end

  def handle_event("suggestion_click", %{"suggestion" => suggestion}, socket) do
    {:noreply, push_patch(socket, to: ~p"/search?#{[q: suggestion]}")}
  end

  def handle_event("clear_search", _params, socket) do
    socket = 
      socket
      |> assign(:query, "")
      |> assign(:results, %{publications: [], posts: [], total_count: 0})
      |> assign(:suggestions, [])
      |> assign(:show_suggestions, false)
      |> assign(:loading, false)
      |> assign(:has_searched, false)

    {:noreply, push_patch(socket, to: ~p"/search")}
  end

  def handle_event("hide_suggestions", _params, socket) do
    Process.send_after(self(), :hide_suggestions, 150)
    {:noreply, socket}
  end

  def handle_info(:hide_suggestions, socket) do
    {:noreply, assign(socket, :show_suggestions, false)}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <div class="max-w-4xl mx-auto">
        <!-- Page Header -->
        <div class="text-center mb-12">
          <h1 class="text-4xl font-bold text-gray-900 mb-4">Search</h1>
          <p class="text-xl text-gray-600 max-w-2xl mx-auto">
            Search across all research, publications, and blog content
          </p>
        </div>

        <!-- Search Bar -->
        <div class="relative mb-8">
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
        <%= if @has_searched and @results.total_count > 0 do %>
          <div class="space-y-8">
            <div class="text-center">
              <h2 class="text-2xl font-bold text-gray-900 mb-2">Search Results</h2>
              <p class="text-gray-600">Found <%= @results.total_count %> results for "<%= @query %>"</p>
            </div>

            <!-- Publications Results -->
            <%= if length(@results.publications) > 0 do %>
              <div class="bg-white rounded-lg shadow-lg p-6">
                <h3 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                  <svg class="w-5 h-5 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                  </svg>
                  Publications (<%= length(@results.publications) %>)
                </h3>
                <div class="space-y-4">
                  <%= for publication <- @results.publications do %>
                    <div class="border-l-4 border-blue-500 pl-4 py-2">
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
                          <%= String.slice(publication.abstract, 0, 200) %><%= if String.length(publication.abstract) > 200, do: "..." %>
                        </p>
                      <% end %>
                    </div>
                  <% end %>
                </div>
                <%= if length(@results.publications) == 10 do %>
                  <div class="mt-4 text-center">
                    <.link navigate="/publications" class="text-blue-600 hover:text-blue-800 text-sm font-medium">
                      View all publications →
                    </.link>
                  </div>
                <% end %>
              </div>
            <% end %>

            <!-- Blog Posts Results -->
            <%= if length(@results.posts) > 0 do %>
              <div class="bg-white rounded-lg shadow-lg p-6">
                <h3 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                  <svg class="w-5 h-5 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path>
                  </svg>
                  Blog Posts (<%= length(@results.posts) %>)
                </h3>
                <div class="space-y-4">
                  <%= for post <- @results.posts do %>
                    <div class="border-l-4 border-green-500 pl-4 py-2">
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
                      <%= if post.tags do %>
                        <div class="flex flex-wrap gap-1 mt-2">
                          <%= for tag <- String.split(post.tags, ",") |> Enum.take(3) do %>
                            <span class="px-2 py-1 text-xs bg-green-100 text-green-700 rounded-full">
                              <%= String.trim(tag) %>
                            </span>
                          <% end %>
                        </div>
                      <% end %>
                    </div>
                  <% end %>
                </div>
                <%= if length(@results.posts) == 10 do %>
                  <div class="mt-4 text-center">
                    <.link navigate="/blog" class="text-green-600 hover:text-green-800 text-sm font-medium">
                      View all blog posts →
                    </.link>
                  </div>
                <% end %>
              </div>
            <% end %>
          </div>
        <% end %>

        <!-- No Results -->
        <%= if @has_searched and @results.total_count == 0 do %>
          <div class="text-center">
            <div class="bg-white rounded-lg shadow-lg p-8">
              <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
              <h3 class="text-xl font-bold text-gray-900 mb-2">No results found</h3>
              <p class="text-gray-600 mb-4">
                Sorry, we couldn't find any content matching "<%= @query %>".
              </p>
              <div class="text-sm text-gray-500 space-y-1">
                <p>Try searching for:</p>
                <ul class="list-disc list-inside text-left inline-block">
                  <li>Research topics (e.g., "machine learning", "medical imaging")</li>
                  <li>Publication titles or authors</li>
                  <li>Blog post keywords or tags</li>
                  <li>Technical terms or methodologies</li>
                </ul>
              </div>
            </div>
          </div>
        <% end %>

        <!-- Search Tips (when no search has been performed) -->
        <%= if not @has_searched and @query == "" do %>
          <div class="bg-gray-50 rounded-lg p-8 text-center">
            <h3 class="text-lg font-semibold text-gray-900 mb-4">Search Tips</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 text-sm text-gray-600">
              <div>
                <h4 class="font-medium text-gray-900 mb-2">What you can search for:</h4>
                <ul class="space-y-1 text-left">
                  <li>• Research publications and papers</li>
                  <li>• Blog posts and articles</li>
                  <li>• Author names and collaborators</li>
                  <li>• Technical keywords and terms</li>
                </ul>
              </div>
              <div>
                <h4 class="font-medium text-gray-900 mb-2">Search examples:</h4>
                <ul class="space-y-1 text-left">
                  <li>• "deep learning"</li>
                  <li>• "COVID-19 detection"</li>
                  <li>• "drug interaction prediction"</li>
                  <li>• "machine learning healthcare"</li>
                </ul>
              </div>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
