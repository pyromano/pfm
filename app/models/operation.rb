class Operation < ApplicationRecord
  belongs_to :category
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true

  scope :where_money_flow, ->(flow_code) { joins(:category).where(categories: { money_flow: flow_code }) }
  scope :sum_by_category, -> { joins(:category).group('categories.name').sum(:amount) }
  scope :sum_by_date, -> { group('DATE(odate)').sum(:amount) }
end
