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

  def report_all_categories_path
    reports_report_path(date_range: @report.date_range, money_flow: params['money_flow'],
                        report_type: params['report_type'])
  end

  def report_by_category_path(category_id)
    reports_report_path(category_id:, date_range: @report.date_range, money_flow: params['money_flow'],
                        report_type: params['report_type'])
  end
end
