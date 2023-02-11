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
end
