require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:valid)
  end
  test 'valid category' do
    assert @category.valid?
  end
  test 'invalid without name' do
    @category.name = nil
    refute @category.valid?
    assert_not_nil @category.errors[:name], 'no validation error for name present'
  end
  test 'invalid without description' do
    @category.description = nil
    refute @category.valid?
    assert_not_nil @category.errors[:description], 'no validation error for description present'
  end
  test 'invalid money_flow code' do
    @category.money_flow = 332
    refute @category.valid?
    assert_not_nil @category.errors[:money_flow], 'no validation error for money_flow'
  end
  test '#category' do
    assert_not_nil @category.operations
    assert_equal 1, @category.operations.size
  end
end
