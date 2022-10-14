module ActiveRecordSpecHelpers
  def new_user(options = {})
    User.new({ **defaults(:user), **options })
  end

  def new_category(options = {})
    Category.new({ **defaults(:category), **options })
  end

  def new_entity(options = {})
    Entity.new({ **defaults(:entity), **options })
  end

  def create_trans(options = {})
    categs = options.delete(:categs)
    raise 'Categories are required' if categs.nil?

    entity = new_entity(options)
    entity.save!
    entity.categories.push(*categs)
    entity
  end

  def create_user(options = {})
    user = new_user(options)
    user.skip_confirmation!
    user.save!
    user
  end

  def create_category(options = {})
    categ = new_category(options)
    categ.save!
    categ
  end

  def defaults(scope)
    case scope
    when :user
      { name: 'dev', email: 'dev@test.email', password: 'dev@123' }
    when :category
      { name: 'Default Category', icon: '' }
    when :entity
      { name: 'default_entity_name', amount: 9.23 }
    else
      {}
    end
  end
end
