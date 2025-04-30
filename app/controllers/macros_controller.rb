class MacrosController < ApplicationController
  
  def display_form
    render({ :template => "macro_template/new_form"})
  end

  def process_inputs
    @the_description = params.fetch("description_area")
    @the_image = params.fetch("image")
    @the_image_converted = DataURI.convert(@the_image)
    
    c = OpenAI::Chat.new
    c.system("You are an expert nutritionist. Estimate the macronutrients (carbohydrates, protein, and fat) in grams, as well as total calories in kCal.")
    c.user(@the_description, image: @the_image)
    c.schema = '{
  "name": "my_schema",
  "schema": {
    "type": "object",
    "properties": {
      "carbohydrates": {
        "type": "number",
        "description": "The amount of carbohydrates in grams."
      },
      "protein": {
        "type": "number",
        "description": "The amount of protein in grams."
      },
      "fats": {
        "type": "number",
        "description": "The amount of fats in grams."
      },
      "total_calories": {
        "type": "number",
        "description": "The total calorie content in kilocalories."
      },
      "free_text": {
        "type": "string",
        "description": "A summarization or description of the food and its macronutrients."
      }
    },
    "required": [
      "carbohydrates",
      "protein",
      "fats",
      "total_calories",
      "free_text"
    ],
    "additionalProperties": false
      },
      "strict": true
    }'
    
    @answer = c.assistant!
    @carbohydrates = @answer.fetch("carbohydrates")
    @protein = @answer.fetch("protein")
    @fats = @answer.fetch("fats")
    @total_calories = @answer.fetch("total_calories")
    @free_text = @answer.fetch("free_text")

    render({ :template => "macro_template/results"})

  end

end
