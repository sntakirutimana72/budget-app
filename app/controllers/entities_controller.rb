class EntitiesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @entities = @category.entities
    @amount = @entities.sum(:amount)
  end
end
