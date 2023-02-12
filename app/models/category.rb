class Category < ApplicationRecord
  has_many :operations, dependent: :delete_all
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :money_flow, inclusion: { in: MoneyFlow::TYPES.values }
end
