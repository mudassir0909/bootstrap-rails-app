module ApplicationHelper
  def title
    base_title = "Page"
    if @title.nil?
      "Rails Application flavored with Bootstrap :) "
    else
      "#{@title} #{base_title}"
    end
  end
end
