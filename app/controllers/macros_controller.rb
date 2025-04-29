class MacrosController < ApplicationController
  
  def display_form
    render({ :template => "macro_template/new_form"})
  end

  def process_inputs
    request_headers_hash = {
      "Authorization" => "Bearer # {ENV.fetch("OPENAI_API_KEY")}", "content-type" =>
    }
  end

end
