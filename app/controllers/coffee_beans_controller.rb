class CoffeeBeansController < ApplicationController
  def index
    @coffee_beans = CoffeeBean.all

    render("coffee_beans_templates/index.html.erb")
  end

  def show
    # Params are like this: Parameters: {"id"=>"21"}
    @coffee_beans = CoffeeBean.find(params[:id])

    render("coffee_beans_templates/show.html.erb")
  end

  def new_form
    render("coffee_beans_templates/new_form.html.erb")
  end

  def create_row
    # Params are like this: Parameters: {"some_blend_name"=>"test", "some_origin"=>"test", "some_variety"=>"test", "some_notes"=>"test"}
    @coffee_bean = CoffeeBean.new

    @coffee_bean.blend_name = params[:some_blend_name]
    @coffee_bean.origin = params[:some_origin]
    @coffee_bean.variety = params[:some_variety]
    @coffee_bean.notes = params[:some_notes]

    @coffee_bean.save

    redirect_to("/coffee_beans")
  end

  def edit_form
    #Params are like this: Parameters: {"id"=>"22"}
    editing_id = params["id"]
    s = CoffeeBean.find(editing_id)
    @blend_name = s.blend_name
    @origin = s.origin
    @variety = s.variety
    @notes = s.notes
    @id = editing_id
    render("coffee_beans_templates/edit_form.html.erb")
  end

  def update_row
    # Params are like this: Parameters: {"blend_name"=>"testing", "origin"=>"testing", "variety"=>"testing", "notes"=>"testing"}
    @coffee_bean = CoffeeBean.find(params[:id])
    @coffee_bean.blend_name = params[:blend_name]
    @coffee_bean.origin = params[:origin]
    @coffee_bean.variety = params[:variety]
    @coffee_bean.notes = params[:notes]
    @coffee_bean.save
    redirect_to("/coffee_beans/#{@coffee_bean.id}")
  end

  def destroy_row
    # Params are like this: Parameters: {"id"=>"22"}
    to_destroy_id = params["id"]
    c = CoffeeBean.find(to_destroy_id)
    c.destroy
    redirect_to("/coffee_beans")
  end
end
