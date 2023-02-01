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

  def total
    @operations_report.values.sum.round
  end

  def prev_month
    prev_month = Date.parse(@start_date) - 1.month
    "#{prev_month.beginning_of_month} to #{prev_month.end_of_month}"
  end

  def next_month
    next_month = Date.parse(@end_date) + 1.month
    "#{next_month.beginning_of_month} to #{next_month.end_of_month}"
  end

  def current_dates_label
    "#{Date.parse(@start_date).strftime('%Y %b %d')} - #{Date.parse(@end_date).strftime('%Y %b %d')}"
  end

  def report_by_category_path(date_range, params)
    reports_report_by_category_path(date_range:, money_flow: params['money_flow'],
                                    category_id: params['category_id'])
  end

  def report_by_dates_path(date_range, params)
    reports_report_by_dates_path(date_range:, money_flow: params['money_flow'],
                                 category_id: params['category_id'])
  end
end
