module ApplicationHelper

  # Return the logo for the page
  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
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