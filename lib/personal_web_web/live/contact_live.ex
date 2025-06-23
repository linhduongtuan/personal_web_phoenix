defmodule PersonalWebWeb.ContactLive do
  use PersonalWebWeb, :live_view

  def mount(_params, _session, socket) do
    changeset = contact_changeset(%{})
    
    socket = 
      socket
      |> assign(:form, to_form(changeset, as: :contact))
      |> assign(:submitted, false)

    {:ok, socket}
  end

  def handle_event("validate", %{"contact" => contact_params}, socket) do
    changeset = 
      contact_changeset(contact_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(changeset, as: :contact))}
  end

  def handle_event("submit", %{"contact" => contact_params}, socket) do
    changeset = contact_changeset(contact_params)

    case Ecto.Changeset.apply_action(changeset, :insert) do
      {:ok, _data} ->
        # Here you would typically send an email or save to database
        # For now, we'll just simulate success
        Process.send_after(self(), :reset_form, 3000)
        
        {:noreply, 
         socket
         |> assign(:submitted, true)
         |> put_flash(:info, "Thank you for your message! I'll get back to you soon.")}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset, as: :contact))}
    end
  end

  def handle_info(:reset_form, socket) do
    {:noreply, 
     socket
     |> assign(:submitted, false)
     |> assign(:form, to_form(contact_changeset(%{}), as: :contact))
     |> clear_flash()}
  end

  defp contact_changeset(params) do
    types = %{
      name: :string,
      email: :string,
      subject: :string,
      message: :string
    }

    {%{}, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:name, :email, :subject, :message])
    |> Ecto.Changeset.validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "Please enter a valid email address")
    |> Ecto.Changeset.validate_length(:name, min: 2, max: 100)
    |> Ecto.Changeset.validate_length(:subject, min: 5, max: 200)
    |> Ecto.Changeset.validate_length(:message, min: 10, max: 2000)
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <div class="max-w-4xl mx-auto">
        <!-- Page Header -->
        <div class="text-center mb-12">
          <h1 class="text-4xl font-bold text-gray-900 mb-4">Contact</h1>
          <p class="text-xl text-gray-600 max-w-2xl mx-auto">
            Get in touch for research collaborations, academic discussions, or speaking opportunities.
          </p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <!-- Contact Information -->
          <div>
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Contact Information</h2>
            
            <div class="space-y-6">
              <!-- Email -->
              <div class="flex items-start space-x-4">
                <div class="bg-blue-100 p-3 rounded-lg">
                  <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold text-gray-900 mb-1">Email</h3>
                  <a href="mailto:linhduongtuan@gmail.com" class="text-blue-600 hover:text-blue-800">
                    linhduongtuan@gmail.com
                  </a>
                  <p class="text-sm text-gray-600 mt-1">
                    Primary contact for research inquiries and collaborations
                  </p>
                </div>
              </div>

              <!-- Office -->
              <div class="flex items-start space-x-4">
                <div class="bg-green-100 p-3 rounded-lg">
                  <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold text-gray-900 mb-1">Office</h3>
                  <p class="text-gray-700">
                    [Building Name], Room [Number]<br>
                    [Department Name]<br>
                    [University Name]<br>
                    [Address], [City, State ZIP]
                  </p>
                </div>
              </div>

              <!-- Phone -->
              <div class="flex items-start space-x-4">
                <div class="bg-purple-100 p-3 rounded-lg">
                  <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                  </svg>
                </div>
                <div>
                  <h3 class="font-semibold text-gray-900 mb-1">Phone</h3>
                  <p class="text-gray-700">+1 (XXX) XXX-XXXX</p>
                  <p class="text-sm text-gray-600 mt-1">
                    Office hours: Monday-Friday, 9:00 AM - 5:00 PM
                  </p>
                </div>
              </div>
            </div>

            <!-- Social Links -->
            <div class="mt-8">
              <h3 class="font-semibold text-gray-900 mb-4">Connect Online</h3>
              <div class="flex space-x-4">
                <a href="https://www.linkedin.com/in/linh-duong-746b0b9b/" target="_blank" class="bg-blue-600 text-white p-3 rounded-lg hover:bg-blue-700 transition-colors" title="LinkedIn">
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.338 16.338H13.67V12.16c0-.995-.017-2.277-1.387-2.277-1.39 0-1.601 1.086-1.601 2.207v4.248H8.014v-8.59h2.559v1.174h.037c.356-.675 1.227-1.387 2.526-1.387 2.703 0 3.203 1.778 3.203 4.092v4.711zM5.005 6.575a1.548 1.548 0 11-.003-3.096 1.548 1.548 0 01.003 3.096zm-1.337 9.763H6.34v-8.59H3.667v8.59zM17.668 1H2.328C1.595 1 1 1.581 1 2.298v15.403C1 18.418 1.595 19 2.328 19h15.34c.734 0 1.332-.582 1.332-1.299V2.298C19 1.581 18.402 1 17.668 1z" clip-rule="evenodd"/>
                  </svg>
                </a>
                <a href="https://github.com/linhduongtuan" target="_blank" class="bg-gray-800 text-white p-3 rounded-lg hover:bg-gray-900 transition-colors" title="GitHub">
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd"/>
                  </svg>
                </a>
                <a href="https://scholar.google.com/citations?user=aZKRy1oAAAAJ&hl=en&authuser=2" target="_blank" class="bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 transition-colors" title="Google Scholar">
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M5.242 13.769L0 9.5 12 0l12 9.5-5.242 4.269C17.548 11.249 14.978 9.5 12 9.5c-2.977 0-5.548 1.748-6.758 4.269zM12 10a7 7 0 1 0 0 14 7 7 0 0 0 0-14z"/>
                  </svg>
                </a>
                <a href="https://www.researchgate.net/profile/Linh-Duong-Tuan?ev=hdr_xprf" target="_blank" class="bg-green-600 text-white p-3 rounded-lg hover:bg-green-700 transition-colors" title="ResearchGate">
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M19.586 0c-.818 0-1.508.19-2.073.565-.563.377-.872.89-.872 1.516 0 .627.309 1.141.872 1.516.565.376 1.255.565 2.073.565.817 0 1.508-.189 2.073-.565.563-.375.871-.889.871-1.516 0-.627-.308-1.139-.871-1.516C21.094.189 20.403 0 19.586 0zM6.994 6.104c-1.086 0-2.014.243-2.783.729-.769.486-1.306 1.175-1.612 2.068-.306.893-.459 1.944-.459 3.153 0 1.209.153 2.26.459 3.153.306.893.843 1.582 1.612 2.068.769.486 1.697.729 2.783.729 1.086 0 2.014-.243 2.783-.729.769-.486 1.306-1.175 1.612-2.068.306-.893.459-1.944.459-3.153 0-1.209-.153-2.26-.459-3.153-.306-.893-.843-1.582-1.612-2.068-.769-.486-1.697-.729-2.783-.729zm0 1.459c.802 0 1.434.283 1.896.85.462.567.693 1.367.693 2.401v2.372c0 1.034-.231 1.834-.693 2.401-.462.567-1.094.85-1.896.85-.802 0-1.434-.283-1.896-.85-.462-.567-.693-1.367-.693-2.401V10.814c0-1.034.231-1.834.693-2.401.462-.567 1.094-.85 1.896-.85zm11.592 0c.802 0 1.434.283 1.896.85.462.567.693 1.367.693 2.401v2.372c0 1.034-.231 1.834-.693 2.401-.462.567-1.094.85-1.896.85-.802 0-1.434-.283-1.896-.85-.462-.567-.693-1.367-.693-2.401V10.814c0-1.034.231-1.834.693-2.401.462-.567 1.094-.85 1.896-.85z"/>
                  </svg>
                </a>
                <a href="https://orcid.org/my-orcid?orcid=0000-0001-7411-1369" target="_blank" class="bg-green-500 text-white p-3 rounded-lg hover:bg-green-600 transition-colors" title="ORCID">
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 0C5.372 0 0 5.372 0 12s5.372 12 12 12 12-5.372 12-12S18.628 0 12 0zM7.369 4.378c.525 0 .947.431.947.947 0 .525-.422.947-.947.947-.525 0-.946-.422-.946-.947 0-.516.421-.947.946-.947zm-.722 3.038h1.444v10.041H6.647V7.416zm3.562 0h3.9c3.712 0 5.344 2.653 5.344 5.025 0 2.578-2.016 5.016-5.325 5.016h-3.919V7.416zm1.444 1.303v7.444h2.297c2.359 0 3.925-1.303 3.925-3.722 0-2.016-1.284-3.722-3.925-3.722h-2.297z"/>
                  </svg>
                </a>
              </div>
            </div>
          </div>

          <!-- Contact Form -->
          <div>
            <div class="bg-white rounded-lg shadow-lg p-8">
              <h2 class="text-2xl font-bold text-gray-900 mb-6">Send a Message</h2>
              
              <%= if @submitted do %>
                <div class="text-center py-8">
                  <div class="bg-green-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                  </div>
                  <h3 class="text-lg font-semibold text-gray-900 mb-2">Message Sent!</h3>
                  <p class="text-gray-600">Thank you for reaching out. I'll respond to your message as soon as possible.</p>
                </div>
              <% else %>
                <.form for={@form} phx-change="validate" phx-submit="submit" class="space-y-6">
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <.input
                        field={@form[:name]}
                        type="text"
                        label="Name *"
                        placeholder="Your full name"
                      />
                    </div>
                    
                    <div>
                      <.input
                        field={@form[:email]}
                        type="email"
                        label="Email *"
                        placeholder="your.email@example.com"
                      />
                    </div>
                  </div>
                  
                  <div>
                    <.input
                      field={@form[:subject]}
                      type="text"
                      label="Subject *"
                      placeholder="Research collaboration, speaking opportunity, etc."
                    />
                  </div>
                  
                  <div>
                    <.input
                      field={@form[:message]}
                      type="textarea"
                      label="Message *"
                      rows="6"
                      placeholder="Please describe your inquiry, research interests, or how I can help you..."
                    />
                  </div>
                  
                  <div>
                    <.button
                      type="submit"
                      class="w-full bg-blue-600 text-white py-3 px-6 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors"
                    >
                      Send Message
                    </.button>
                  </div>
                  
                  <p class="text-sm text-gray-600">
                    * Required fields. I typically respond within 24-48 hours during business days.
                  </p>
                </.form>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
