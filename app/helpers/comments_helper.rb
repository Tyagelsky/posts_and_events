module CommentsHelper
  def hide_form_for(resource)
    "hide_form #{resource.id}" if resource.class.eql?(Comment)
  end
end
