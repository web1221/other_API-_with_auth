class Destination < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, :country, presence: true
end
