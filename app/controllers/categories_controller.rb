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

  def create
    @category = Category.new(create_params)
    if @category.save
      redirect_to(root_path, notice: 'Category created successfully!')
    else
      render(
        :new,
        status: :unprocessable_entity,
        alert: @category.errors.objects.first.full_message
      )
    end
  end

  private

  def create_params
    params
      .require(:category)
      .permit(:name, :icon)
      .merge(author: current_user)
  end
end
