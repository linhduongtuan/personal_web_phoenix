defmodule PersonalWebWeb.PublicationHTML do
  @moduledoc """
  This module contains pages rendered by PublicationController.

  See the `publication_html` directory for all templates.
  """
  use PersonalWebWeb, :html

  embed_templates "publication_html/*"
end
