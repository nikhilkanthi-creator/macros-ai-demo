class MacrosController < ApplicationController
  
  def display_form
    render({ :template => "macro_template/new_form"})
  end

  def process_inputs
    @the_description = params.fetch("description_area")
    @the_image = params.fetch("image")

    request_headers_hash = {
      "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY")}", "content-type" => "application/json"
    }

    request_body_hash = {
       "model" => "gpt-3.6-turbo", "messages" => [{
         "role" => "system"
         "content" => "You are a dietician looking at an image and telling me how much calories it has."
       },
       {
        "role" => "user", "content" => ""
       }
      ]
     }

    render({ :template => "macro_template/results"})

    
  end

end
