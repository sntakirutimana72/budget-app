class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :name, presence: true, length: { minimum: 3 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
