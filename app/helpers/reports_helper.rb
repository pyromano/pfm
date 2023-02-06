module ReportsHelper
  def chart_data
    @chart_data = {
      labels: @operations_report.keys,
      datasets: [{
        data: @operations_report.values
      }]
    }.to_json
  end

  def doughnut_chart_opts
    {}.to_json
  end

  def bar_chart_opts
    {
      plugins: {

        legend: { display: false }
      }
    }.to_json
  end

  def categories_list_by_money_flow
    Category.select(:id, :name).where(money_flow: params['money_flow'])
  end

  def total
    @operations_report.values.sum.round
  end

  def prev_month
    "#{@date_range.prev_month.beginning_of_month} to #{@date_range.prev_month.end_of_month}"
  end

  def next_month
    "#{@date_range.next_month.beginning_of_month} to #{@date_range.next_month.end_of_month}"
  end

  def all_categories_report_by_dates_path
    reports_report_by_dates_path(date_range: @date_range, money_flow: params['money_flow'])
  end

  def category_report_by_dates_path(category_id)
    reports_report_by_dates_per_category_path(category_id:, date_range: @date_range, money_flow: params['money_flow'])
  end

  def report_by_category_path(direction)
    reports_report_by_category_path(date_range: send(direction), money_flow: params['money_flow'],
                                    category_id: params['category_id'])
  end

  def report_by_dates_path(direction)
    reports_report_by_dates_path(date_range: send(direction), money_flow: params['money_flow'],
                                 category_id: params['category_id'])
  end
end
