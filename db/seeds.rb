user = User.new(name: 'dev', email: 'dev@test.email', password: 'dev@123')
user.skip_confirmation!
user.save!

# Category.create(name: 'Personal', author: user)
# Category.create(name: 'Dishes', author: user)
# Category.create(name: 'Room Decors', author: user)
# Category.create(name: 'Garden', author: user)
# Category.create(name: 'Charity', author: user)

# Entity.create(name: 'Umbrella', amount: 13.75, author: user)
# Entity.create(name: 'Socx', amount: 6.5, author: user)
# Entity.create(name: 'hat', amount: 1.75, author: user)
# Entity.create(name: 'pens', amount: 13.75, author: user)
# Entity.create(name: 'buckets', amount: 5.75, author: user)

# Categorization.create(category_id: 1, entity_id: 1)
# Categorization.create(category_id: 1, entity_id: 5)
# Categorization.create(category_id: 1, entity_id: 3)
# Categorization.create(category_id: 1, entity_id: 4)
# Categorization.create(category_id: 2, entity_id: 3)
# Categorization.create(category_id: 2, entity_id: 1)
# Categorization.create(category_id: 2, entity_id: 2)
