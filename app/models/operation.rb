class Operation < ApplicationRecord
  belongs_to :category
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true

  scope :where_money_flow, ->(flow_code) { joins(:category).where(categories: { money_flow: flow_code }) }
  scope :sum_by_category, -> { joins(:category).group('categories.name').sum(:amount) }
  scope :sum_by_date, -> { group('DATE(odate)').sum(:amount) }

  Category.money_flows.keys.each do |money_flow|
    %w[category date].each do |report_type|
      define_singleton_method("#{money_flow.downcase}_report_by_#{report_type}") do |**opts|
        where(odate: opts[:start_date]..opts[:end_date]).where_money_flow(Category.send("#{money_flow}_code")).send("sum_by_#{report_type}")
      end
    end
  end
end
