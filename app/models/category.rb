class Category < ApplicationRecord
  @@money_flows = { 'spending' => 1, 'income' => 2 }
  cattr_reader :money_flows

  has_many :operations, dependent: :delete_all
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :money_flow, inclusion: { in: money_flows.values }

  def money_flow_name
    money_flows.key money_flow
  end

  def self.income_code
    money_flows['income']
  end

  def self.spending_code
    money_flows['spending']
  end
end
