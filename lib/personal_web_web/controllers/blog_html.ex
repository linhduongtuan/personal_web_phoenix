defmodule PersonalWebWeb.BlogHTML do
  @moduledoc """
  This module contains pages rendered by BlogController.

  See the `blog_html` directory for all templates.
  """
  use PersonalWebWeb, :html

  embed_templates "blog_html/*"
  
  def format_date(date) when is_struct(date, NaiveDateTime) do
    date
    |> NaiveDateTime.to_date()
    |> Calendar.strftime("%B %d, %Y")
  end
  
  def format_date(date) when is_struct(date, Date) do
    Calendar.strftime(date, "%B %d, %Y")
  end
  
  def format_date(_), do: ""

  def reading_time(content) do
    word_count = content
    |> String.split()
    |> length()
    
    # Average reading speed: 200 words per minute
    minutes = max(1, round(word_count / 200))
    "#{minutes} min read"
  end
end
