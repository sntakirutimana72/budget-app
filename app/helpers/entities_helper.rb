module EntitiesHelper
  def my_categories_except(category_id)
    Category.where('author_id = ? AND id <> ?', current_user.id, category_id)
  end

  def humanize_date(entity)
    entity.created_at.strftime('%m-%d-%Y')
  end
end
