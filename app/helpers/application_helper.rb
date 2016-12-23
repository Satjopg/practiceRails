module ApplicationHelper
  def full_title(page_title = "")
    base_title = "First App"
    if page_title.enpty? then
      base_title
    else
      page_title + "|" + base_title
    end
  end
end
