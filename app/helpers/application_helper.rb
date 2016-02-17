module ApplicationHelper
  def offset(str)
    CGI::parse(str)['offset'].join('')
  end
end
