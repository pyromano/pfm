class ReportsController < ApplicationController
  def index; end

  def report_by_category
    with_required_params do
      with_valid_dates_format do |date_range|
        @date_range = date_range
        money_flow = Category.money_flows.key(params[:money_flow].to_i)
        @operations_report = Operation.send("#{money_flow}_report_by_category", **@date_range)
      end
    end
  end

  def report_by_dates
    with_required_params do
      with_valid_dates_format do |date_range|
        @date_range = date_range
        @categories = Category.where(money_flow: params['money_flow'])

        money_flow = Category.money_flows.key(params[:money_flow].to_i)
        @operations_report = Operation.send("#{money_flow}_report_by_date", **@date_range)

        return unless params['category_id'].present?

        @operations_report = Operation.where(category_id: params['category_id'])
                                      .send("#{money_flow}_report_by_date", **@date_range)
      end
    end
  end

  private

  def with_required_params
    unless params['date_range'].present? && Category.money_flows.values.include?(params['money_flow'].to_i)
      flash[:alert] = 'Please select valid date range and operation type below:'
      render :index, status: :unprocessable_entity and return
    end
    yield
  end

  def with_valid_dates_format
    begin
      start_date, end_date = params['date_range'].split(' to ').map { |e| Date.parse(e) }
    rescue Date::Error
      flash[:alert] = 'Invalid date format'
      render :index, status: :unprocessable_entity and return
    end
    end_date = start_date + 1.day unless end_date.present?
    yield({ start_date:, end_date: })
  end
end
