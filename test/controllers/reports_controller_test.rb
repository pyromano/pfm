require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:one)
  end
  test 'should get index' do
    get reports_index_url
    assert_response :success
  end

  test 'should get report' do
    get reports_report_url(date_range: '2023-01-29 to 2023-01-31', money_flow: 1, report_type: 'category')
    assert_response :success
  end

  test 'should get 422 code on report without date_range' do
    get reports_report_url(money_flow: 1, report_type: 'category')
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report without money_flow' do
    get reports_report_url(date_range: '2023-01-29 to 2023-01-31', report_type: 'category')
    assert_response :unprocessable_entity
  end

  test 'shoud get report with category id' do
    get reports_report_url(category_id: 1, date_range: '2023-01-29 to 2023-01-31', money_flow: 1,
                           report_type: 'day')
    assert_response :success
  end
end
