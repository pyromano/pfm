class ReportsController < ApplicationController
  def index; end

  def report_by_category
    @start_date, @end_date = params['date_range'].split(' to ')
    @operations_report = Operation.where(odate: @start_date..@end_date)
                                  .where_money_flow(params['money_flow'])
                                  .sum_by_category
  end

  def report_by_dates
    @start_date, @end_date = params['date_range'].split(' to ')
    query = Operation.where(odate: @start_date..@end_date)
                     .where_money_flow(params['money_flow'])

    query = query.where(category_id: params['category_id']) if params['category_id'].present?

    @operations_report = query.sum_by_date
    @categories = Category.where(money_flow: params['money_flow'])
  end
end
