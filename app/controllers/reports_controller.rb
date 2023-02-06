class ReportsController < ApplicationController
  before_action :with_required_params,
                :validate_dates_format,
                :set_money_flow,
                except: [:index]

  def index; end

  def report_by_category
    @operations_report = Operation.send("#{@money_flow}_report_by_category", @date_range)
  end

  def report_by_dates
    @operations_report = Operation.send("#{@money_flow}_report_by_dates", @date_range)
  end

  def report_by_dates_per_category
    @operations_report = Operation.where(category_id: params['category_id']).send("#{@money_flow}_report_by_dates",
                                                                                  @date_range)
    render :report_by_dates
  end

  private

  def set_money_flow
    @money_flow = Category.money_flows.key(params[:money_flow].to_i)
  end

  def with_required_params
    return if params['date_range'].present? && Category.money_flows.values.include?(params['money_flow'].to_i)

    flash[:alert] = 'Please select valid date range and operation type below:'
    render :index, status: :unprocessable_entity and return
  end

  def validate_dates_format
    @date_range = DateRangeService.new(params[:date_range])
  rescue Date::Error
    flash[:alert] = 'Invalid date format'
    render :index, status: :unprocessable_entity and return
  end
end
