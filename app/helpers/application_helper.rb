module ApplicationHelper
  def offset(str)
    CGI::parse(str)['offset'].join('') if str
  end

  def alert_class_for(flash_type)
    {
      :success => 'success',
      :error => 'error',
      :alert => 'warning',
      :notice => 'info'
    }[flash_type.to_sym]
  end

  def is_active?(controller)
    "active" if controller.include?(params[:controller])
  end

  def line_chart_data(answers)
    answers_ordered = answers.order(:created_at)
    labels = answers_ordered.pluck(:created_at).map{|date| date.strftime('%m/%d/%Y')}
    data_points = answers_ordered.pluck(:answer)

    {
        labels: labels,
        datasets: [
            {
                label: "My First dataset",
                fillColor: "rgba(220,220,220,0.2)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: data_points
            }
        ]
    }
  end
end
