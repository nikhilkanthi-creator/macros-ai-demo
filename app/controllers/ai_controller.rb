class ai < ApplicationController
  
  def display_form
    render({ :template => "ai_template/new_form"})
  end

end
