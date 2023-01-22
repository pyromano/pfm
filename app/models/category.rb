class Category < ApplicationRecord
  @@money_flows = { 'Доходи' => 1, 'Витрати' => 2 }
  cattr_reader :money_flows

  has_many :operations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :money_flow, inclusion: { in: money_flows.values }

  def money_flow_name
    money_flows.key(money_flow)
  end

  def self.income_code
    money_flows['Доходи']
  end

  def self.oucome_code
    money_flows['Витрати']
  end
end
