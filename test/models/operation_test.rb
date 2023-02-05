require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  def setup
    @operation = operations(:valid)
  end
  test 'valid operation' do
    assert @operation.valid?
  end
  test 'invalid without amount' do
    @operation.amount = nil
    refute @operation.valid?
    assert_not_nil @operation.errors[:amount], 'no validation error for amount present'
  end
  test 'invalid without odate' do
    @operation.odate = nil
    refute @operation.valid?
    assert_not_nil @operation.errors[:odate], 'no validation error for odate present'
  end
  test 'invalid without description' do
    @operation.description = nil
    refute @operation.valid?
    assert_not_nil @operation.errors[:description], 'no validation error for description present'
  end
  test '#category' do
    assert_not_nil @operation.category
  end
  test '#income_report_by_category' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    date_range = DateRangeService.new('2023-01-01 to 2023-02-01')
    report = Operation.income_report_by_category(date_range)
    expected = { 'income' => BigDecimal(1000) }

    assert_equal(expected, report)
    assert_equal(1, report.size)
  end
  test '#spending_report_by_category' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    date_range = DateRangeService.new('2023-01-09 to 2023-01-20')
    report = Operation.spending_report_by_category(date_range)

    expected = { 'spending_category_1' => BigDecimal(100), 'spending_category_2' => BigDecimal(500) }

    assert_equal(expected, report)
    assert_equal(2, report.size)
  end
  test '#income_report_by_date' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    # 1 operation per month, amount 1000
    date_range = DateRangeService.new('2023-01-01 to 2023-02-01')
    report = Operation.income_report_by_date(date_range)
    expected = { '2023-02-01' => BigDecimal(1000) }

    assert_equal(expected, report)
    assert_equal(1, report.size)
  end
  test '#spending_report_by_date' do
    # 2023-1-1 to 2023-4-11 date range with filled fixtures data
    # 1 operation per day, amount 50
    date_range = DateRangeService.new('2023-01-10 to 2023-01-14')
    report = Operation.spending_report_by_date(date_range)
    expected = {
      '2023-01-10' => BigDecimal(50),
      '2023-01-11' => BigDecimal(50),
      '2023-01-12' => BigDecimal(50),
      '2023-01-13' => BigDecimal(50),
      '2023-01-14' => BigDecimal(50)
    }

    assert_equal(expected, report)
    assert_equal(5, report.size)
  end
end
