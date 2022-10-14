class User < ApplicationRecord
  has_many :entities, foreign_key: 'author_id'
  has_many :categories, foreign_key: 'author_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true, length: { minimum: 3 }
  validates_presence_of :email
end
