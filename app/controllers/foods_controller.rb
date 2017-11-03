require 'open-uri'

class FoodsController < ApplicationController
  def index
    @foods = Food.all

    render("foods_templates/index.html.erb")
  end

  def show
    # Params are like this: Parameters: {"id"=>"6"}
    @food = Food.find(params[:id])
    @street_address = @food.store_address
    
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}" # This is the URL we captured from the Google API; we want to vary street_address. 
    parsed_data = JSON.parse(open(url).read) # This takes the URL, opens it and reads it, and then parses the JSON within.
    
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"] # This returns the latitude value from the JSON.
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"] # This returns the longitude value from the JSON.
    
    render("foods_templates/show.html.erb")
  end

  def new_form
    render("foods_templates/new_form.html.erb")
  end

  def create_row
    # Params are like this: Parameters: {"some_ingredient"=>"test", "some_spice"=>"test", "some_measurement"=>"test", "some_store_address"=>"test"}
    @food = Food.new

    @food.ingredient = params[:some_ingredient]
    @food.spice = params[:some_spice]
    @food.measurement = params[:some_measurement]
    @food.store_address = params[:some_store_address]
    @food.save
    redirect_to("/foods")
  end
  
  def edit_form
    @food = Food.find(params[:id])

    render("foods_templates/edit_form.html.erb")
  end

  def update_row
    @food = Food.find(params[:id])

    @food.ingredient = params[:ingredient]
    @food.spice = params[:spice]
    @food.measurement = params[:measurement]
    @food.store_address = params[:store_address]

    @food.save

    redirect_to("/foods/#{@food.id}")
    
  end

  def destroy_row
    # Params are like this: Parameters: {"id"=>"21"}
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to("/foods")
  end
  
end
