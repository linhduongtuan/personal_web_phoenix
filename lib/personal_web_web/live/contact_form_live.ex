defmodule PersonalWebWeb.ContactFormLive do
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
              <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                Name *
              </label>
              <.input
                field={@form[:name]}
                type="text"
                placeholder="Your full name"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              />
            </div>
            
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                Email *
              </label>
              <.input
                field={@form[:email]}
                type="email"
                placeholder="your.email@example.com"
                class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              />
            </div>
          </div>
          
          <div>
            <label for="subject" class="block text-sm font-medium text-gray-700 mb-2">
              Subject *
            </label>
            <.input
              field={@form[:subject]}
              type="text"
              placeholder="Research collaboration, speaking opportunity, etc."
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
          
          <div>
            <label for="message" class="block text-sm font-medium text-gray-700 mb-2">
              Message *
            </label>
            <.input
              field={@form[:message]}
              type="textarea"
              rows="6"
              placeholder="Please describe your inquiry, research interests, or how I can help you..."
              class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-vertical"
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
    """
  end
end
