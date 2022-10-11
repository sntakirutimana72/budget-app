class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :categorizations
  has_many :entities, through: :categorizations

  validates :name, presence: true, length: { minimum: 3 }
end
