module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: { id: id, fields: fields.gsub("\n", "") })
  end

  def natural_time_ago(time)
    if time > 24.hours.ago
      "#{time_ago_in_words(time)}前"
    else
      time.strftime("%Y年%m月%d日")
    end
  end

  def page_title(title = '')
    base_title = 'PinPoint'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
