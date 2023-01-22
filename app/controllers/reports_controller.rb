class ReportsController < ApplicationController
  def index; end

  def report_by_category
    @report = Operation.where(odate: params['start_date']..params['end_date'])
                       .where_money_flow(params['money_flow_direction'])
                       .sum_by_category
  end

  def report_by_dates
    query = Operation.where(odate: params['start_date']..params['end_date'])
                     .where_money_flow(params['money_flow_direction'])

    query = query.where(category_id: params['category_id']) if params['category_id'].present?

    @report = query.sum_by_date
  end
end
