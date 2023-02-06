require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get reports_index_url
    assert_response :success
  end

  test 'should get report_by_category' do
    get reports_report_by_category_url(date_range: '2023-01-29 to 2023-01-31', money_flow: 1)
    assert_response :success
  end

  test 'should get 422 code on report_by_category without date_range' do
    get reports_report_by_category_url(money_flow: 1)
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report_by_category without money_flow' do
    get reports_report_by_category_url(date_range: '2023-01-29 to 2023-01-31')
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report_by_category with invalid money_flow' do
    get reports_report_by_category_url(date_range: '2023-01-29 to 2023-01-31', money_flow: 0o0)
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report_by_category with invalid date format' do
    get reports_report_by_category_url(date_range: '2023-01', money_flow: 1)
    assert_response :unprocessable_entity
  end

  test 'should get report_by_dates' do
    get reports_report_by_dates_url(date_range: '2023-01-29 to 2023-01-31', money_flow: 1)
    assert_response :success
  end

  test 'should get 422 code on report_by_dates without date_range' do
    get reports_report_by_dates_url(money_flow: 1)
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report_by_dates without money_flow' do
    get reports_report_by_dates_url(date_range: '2023-01-29 to 2023-01-31')
    assert_response :unprocessable_entity
  end

  test 'should get 422 code on report_by_dates with invalid money_flow' do
    get reports_report_by_dates_url(date_range: '2023-01-29 to 2023-01-31', money_flow: 0o0)
    assert_response :unprocessable_entity
  end

  test 'shoud get report_by_dates with single date' do
    get reports_report_by_dates_url(date_range: '2023-01-29', money_flow: 1)
    assert_response :success
  end

  test 'should get 422 code on report_by_dates with invalid date format' do
    get reports_report_by_dates_url(date_range: '2023-01', money_flow: 1)
    assert_response :unprocessable_entity
  end

  test 'shoud get report_by_dates with category id' do
    get reports_report_by_category_url(category_id: 1, date_range: '2023-01-29 to 2023-01-31', money_flow: 1)
    assert_response :success
  end
end
