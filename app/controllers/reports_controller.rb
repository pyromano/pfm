class ReportsController < ApplicationController
  before_action :set_money_flow,
                except: [:index]

  VIEWS = {
    day: :report_by_dates,
    week: :report_by_dates,
    month: :report_by_dates,
    year: :report_by_dates,
    category: :report_by_category
  }

  def index; end

  def report
    @report = Report.new(report_params)
    if @report.valid?
      @operations_report = Report.send("report_by_#{@report.report_type}",
                                       @report.daterange,
                                       @report.money_flow,
                                       @report.category_id)

      render VIEWS[params[:report_type].to_sym]
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.permit(:date_range, :money_flow, :report_type, :category_id)
  end

  def set_money_flow
    @money_flow = Category.money_flows.key(params[:money_flow].to_i)
  end
end
