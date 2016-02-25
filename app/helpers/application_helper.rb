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
end
