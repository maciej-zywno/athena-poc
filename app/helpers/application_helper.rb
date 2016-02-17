module ApplicationHelper
  def offset(str)
    URI.decode_www_form(URI(str).query).assoc('offset').last
  end
end
