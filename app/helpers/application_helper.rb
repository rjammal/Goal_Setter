module ApplicationHelper
  
  def authorize_form
    "<input 
      type='hidden'
      name='authenticity_token'
      value='#{form_authenticity_token}'>".html_safe
  end
  
  def flash_helper
    flash[:errors].join("<br>").html_safe if flash[:errors]
  end
end
