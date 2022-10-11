class EntitiesController < ApplicationController
  include EntitiesHelper

  def index
    @category = Category.find(params[:category_id])
    @entities = @category.entities
    @amount = @entities.sum(:amount)
  end

  def new
    if my_categories_except(params[:category_id]).empty?
      redirect_to(
        new_category_path,
        notice: "Can't create transactions without categories"
      ) and return
    end

    @entity = Entity.new
    render(:new, locals: { category_id: params[:category_id] })
  end

  def create
    categ_ids = params.require(:entity).fetch(:category_ids, [])[1..]
    categ_ids << params[:category_id]

    @entity = Entity.new(create_params)
    return error_render(@entity.errors.objects.first.full_message) unless @entity.save

    @entity.categories.push(*Category.where(id: categ_ids))
    redirect_to(
      category_entities_path(params[:category_id]),
      notice: 'Transaction created successfully!'
    )
  end

  private

  def create_params
    params
      .require(:entity)
      .permit(:name, :amount)
      .merge(author: current_user)
  end

  def transaction_params
    params.permit(:category_id).merge(entity: @entity)
  end

  def error_render(error)
    flash.now[:alert] = error
    render(:new, status: :unprocessable_entity)
  end
end
