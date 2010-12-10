module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "railstutorial.com Example-Code"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end