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

  def line_chart_data(answers, data_type)
    answers_ordered = answers.order(:created_at)
    labels = answers_ordered.pluck(:created_at).map{|date| date.strftime('%m/%d/%Y')}
    data_points = extract_data_points(answers_ordered, data_type)

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

  def alchemy_keywords(alchemy)
    if alchemy && alchemy.keywords
      alchemy.keywords.map{|e| e['text']}
    else
      nil
    end

  end

  def alchemy_sentiment(alchemy)
    if alchemy && alchemy.sentiment
      "#{alchemy.sentiment['score']}, #{alchemy.sentiment['type']}"
    else
      nil
    end
  end

  private

    def extract_data_points(answers, data_type)
      if data_type == :answer
        answers.pluck(:answer)
      elsif data_type == :sentiment
        answers.select{|answer| !answer.try(:alchemy).nil? }.map{|answer| answer.alchemy.sentiment['score']}
      else
        raise "unsupported data type: #{data_type}"
      end
    end
end
