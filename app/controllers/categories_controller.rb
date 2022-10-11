class CategoriesController < ApplicationController
  def index
    @categories = Category
      .select('categories.*, SUM(T.amount) as amount')
      .joins('LEFT JOIN categorizations as C ON C.category_id = categories.id')
      .joins('LEFT JOIN entities as T ON T.id = C.entity_id')
      .where(author: current_user)
      .group(:id)
  end

  def new
    @category = Category.new
  end
end
