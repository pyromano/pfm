require 'test_helper'

class OperationReportTest < ActiveSupport::TestCase
  def setup
    @valid_report = Report.new(date_range: '2023-01-01 to 2023-01-25', money_flow: 1, report_type: 'day')
  end
  test 'invalid without date_range' do
    @valid_report.date_range = nil
    refute @valid_report.valid?
    assert_not_nil @valid_report.errors[:date_range]
  end
  test 'invalid date_range format' do
    @valid_report.date_range = '2023-01-01 to 2023-01-'
    refute @valid_report.valid?
    assert_not_nil @valid_report.errors[:date_range]
  end
  test 'valid with single date' do
    @valid_report.date_range = '2023-01-01'
    assert @valid_report.valid?
    assert_empty @valid_report.errors
  end
  test 'invalid money flow' do
    @valid_report.money_flow = 0o00
    refute @valid_report.valid?
    assert_not_nil @valid_report.errors[:money_flow]
  end
  test 'invalid report type' do
    @valid_report.report_type = 'yay'
    refute @valid_report.valid?
    assert_not_nil @valid_report.errors[:report_type]
  end
  test 'valid report' do
    assert @valid_report.valid?
    assert_empty @valid_report.errors
  end

  test '#report_by_category' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    date_range = Date.parse('2023-01-01')..Date.parse('2023-02-01')
    report = Report.report_by_category(date_range, MoneyFlow.income, nil)
    expected = { 'income' => BigDecimal(1000) }

    assert_equal(expected, report)
    assert_equal(1, report.size)
  end
  test '#report_by_day expenses' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    date_range = Date.parse('2023-01-09')..Date.parse('2023-01-20')
    report = Report.report_by_day(date_range, MoneyFlow.expenses, nil)

    expected = {}
    [*date_range].each { |e| expected[e] = 50 }

    assert_equal(expected, report)
    assert_equal(12, report.size)
  end
  test '#report_by_week income' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    # 1 operation per month, amount 1000
    date_range = Date.parse('2023-01-01')..Date.parse('2023-02-01')
    report = Report.report_by_week(date_range, MoneyFlow.income, nil)
    expected = { Date.parse('2023-01-29') => BigDecimal(1000) }

    assert_equal(expected, report)
    assert_equal(1, report.size)
  end
  test '#report_by_week expenses' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    # 1 operation per day, amount 50
    date_range = Date.parse('2023-01-01')..Date.parse('2023-02-01')
    report = Report.report_by_week(date_range, MoneyFlow.expenses, nil)
    expected = {
      Date.parse('2023-01-01') => BigDecimal(50 * 6),
      Date.parse('2023-01-08') => BigDecimal(50 * 7),
      Date.parse('2023-01-15') => BigDecimal(50 * 7),
      Date.parse('2023-01-22') => BigDecimal(50 * 7),
      Date.parse('2023-01-29') => BigDecimal(50 * 4)
    }

    assert_equal(expected, report)
    assert_equal(5, report.size)
  end
  test '#report_by_month spendind' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    # 1 operation per day, amount 50
    date_range = Date.parse('2023-01-01')..Date.parse('2023-02-20')
    report = Report.report_by_month(date_range, MoneyFlow.expenses, nil)
    expected = {
      Date.parse('2023-01-01') => BigDecimal(50 * 30),
      Date.parse('2023-02-01') => BigDecimal(50 * 20)
    }

    assert_equal(expected, report)
    assert_equal(2, report.size)
  end
end
