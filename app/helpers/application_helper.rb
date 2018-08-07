module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else page_title + " | " + base_title
    end
  end

  def show_errors object, field_name
    if object.errors.any?
      unless object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end
end
