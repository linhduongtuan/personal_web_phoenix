defmodule PersonalWebWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is rendered as component
  in regular views and live views.
  """
  use PersonalWebWeb, :html

  embed_templates "layouts/*"

  def app(assigns) do
    ~H"""
    <header class="bg-white shadow-sm border-b border-gray-200">
      <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
          <div class="flex items-center">
            <a href="/" class="flex items-center space-x-2">
              <div class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center">
                <span class="text-white font-bold text-sm">LD</span>
              </div>
              <span class="text-xl font-bold text-black hidden sm:block">Dr. Linh Duong</span>
            </a>
          </div>
          
          <div class="hidden md:flex items-center space-x-6">
            <a href="/" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              Home
            </a>
            <a href="/about" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              About
            </a>
            <a href="/research" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              Research
            </a>
            <a href="/publications" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              Publications
            </a>
            <a href="/blog" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              Blog
            </a>
            <a href="/search" class="text-gray-800 hover:text-black px-3 py-2 rounded-md text-sm font-medium transition-colors">
              Search
            </a>
            <a href="/contact" class="bg-blue-600 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-blue-700 transition-colors">
              Contact
            </a>
          </div>

          <!-- Mobile menu button -->
          <div class="md:hidden flex items-center">
            <button type="button" 
                    class="text-gray-800 hover:text-black focus:outline-none focus:text-black" 
                    aria-label="toggle menu"
                    onclick="document.getElementById('mobile-menu').classList.toggle('hidden')">
              <svg class="h-6 w-6 fill-current" viewBox="0 0 24 24">
                <path d="M4 5h16a1 1 0 0 1 0 2H4a1 1 0 1 1 0-2zM4 13h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2zM4 21h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2z"/>
              </svg>
            </button>
          </div>
        </div>

        <!-- Mobile menu -->
        <div id="mobile-menu" class="hidden md:hidden">
          <div class="px-2 pt-2 pb-3 space-y-1 bg-white border-t border-gray-200">
            <a href="/" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              Home
            </a>
            <a href="/about" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              About
            </a>
            <a href="/research" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              Research
            </a>
            <a href="/publications" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              Publications
            </a>
            <a href="/blog" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              Blog
            </a>
            <a href="/search" class="block text-gray-800 hover:text-blue-600 px-3 py-2 rounded-md text-base font-medium">
              Search
            </a>
            <a href="/contact" class="block bg-blue-600 text-white px-3 py-2 rounded-md text-base font-medium hover:bg-blue-700">
              Contact
            </a>
          </div>
        </div>
      </nav>
    </header>

    <main class="bg-white min-h-screen">
      <.flash_group flash={@flash} />
      {render_slot(@inner_block)}
    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white">
      <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div class="col-span-1 md:col-span-2">
            <div class="flex items-center space-x-2 mb-4">
              <div class="w-8 h-8 bg-blue-600 rounded-full flex items-center justify-center">
                <span class="text-white font-bold text-sm">LD</span>
              </div>
              <span class="text-xl font-bold">Dr. Linh Duong</span>
            </div>
            <p class="text-gray-300 mb-4 max-w-md">
              Researcher and scientist dedicated to advancing knowledge in artificial intelligence and machine learning for healthcare. 
              Committed to open science and collaboration.
            </p>
            <div class="flex space-x-4">
              <a href="#" class="text-gray-400 hover:text-white">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"/>
                </svg>
              </a>
              <a href="#" class="text-gray-400 hover:text-white">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M6.29 18.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0020 3.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.073 4.073 0 01.8 7.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 010 16.407a11.616 11.616 0 006.29 1.84"/>
                </svg>
              </a>
            </div>
          </div>
          
          <div>
            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-4">Quick Links</h3>
            <ul class="space-y-2">
              <li><a href="/about" class="text-gray-300 hover:text-white">About</a></li>
              <li><a href="/research" class="text-gray-300 hover:text-white">Research</a></li>
              <li><a href="/publications" class="text-gray-300 hover:text-white">Publications</a></li>
              <li><a href="/blog" class="text-gray-300 hover:text-white">Blog</a></li>
            </ul>
          </div>
          
          <div>
            <h3 class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-4">Contact</h3>
            <ul class="space-y-2 text-gray-300">
              <li>linhduongtuan@gmail.com</li>
              <li>AI & ML Research</li>
              <li><a href="/contact" class="hover:text-white">Contact Form</a></li>
            </ul>
          </div>
        </div>
        
        <div class="mt-8 pt-8 border-t border-gray-800 text-center">
          <p class="text-gray-400">
            © {Date.utc_today().year} Dr. Linh Duong. Built with 
            <a href="https://phoenixframework.org/" class="text-blue-400 hover:text-blue-300">Phoenix</a>.
          </p>
        </div>
      </div>
    </footer>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Hang in there while we get back on track")}
        <.icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end
end
