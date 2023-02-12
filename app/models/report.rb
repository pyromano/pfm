class Report < ApplicationRecord
  self.table_name = 'operations'
  belongs_to :category, optional: true

  TYPES = %w[category day week month year].freeze

  # query section
  scope :by_money_flow, ->(money_flow_id) { joins(:category).where(categories: { money_flow: money_flow_id }) }
  scope :by_category, ->(cat) { where(category_id: cat) if cat.present? }

  scope :group_by_category, ->(_) { joins(:category).group('categories.name') }

  TYPES.each do |report_type|
    define_singleton_method("report_by_#{report_type}") do |date_range, money_flow, category|
      where(odate: date_range)
        .by_money_flow(money_flow)
        .by_category(category)
        .send("group_by_#{report_type}", :odate).sum(:amount)
    end
  end
  # query section end

  def initialize(*params)
    super
    return unless valid?

    @start_date, @end_date = date_range.split(' to ').map { |e| Date.parse(e) }
    @end_date = @start_date + 1.day unless @end_date.present?
  end

  # validate section
  attr_accessor :date_range, :money_flow, :report_type

  validate :validate_date_range_format
  validate :validate_money_flow
  validate :validate_report_type

  def validate_date_range_format
    unless date_range.present?
      errors.add(:date_range, 'cannot be empty')
      return
    end

    date_range.split(' to ').map { |e| Date.parse(e) }
  rescue Date::Error
    errors.add(:date_range, 'invalid date format')
  end

  def validate_money_flow
    return if MoneyFlow.include?(money_flow)

    errors.add(:money_flow, 'does not exist')
  end

  def validate_report_type
    return if TYPES.include? report_type

    errors.add(:report_type, 'does not exist')
  end

  # date range stuff inside report
  def daterange
    @start_date..@end_date
  end

  def date_range_humanize
    "#{@start_date.strftime('%Y %b %d')} - #{@end_date.strftime('%Y %b %d')}"
  end
end
