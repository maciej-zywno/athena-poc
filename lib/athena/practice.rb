class Practice
  BASE_URL = '/practiceinfo'

  include Virtus.model

  attribute :iscoordinatorsender,   String
  attribute :hasclinicals,          String
  attribute :name,                  String
  attribute :hascommunicator,       String
  attribute :iscoordinatorreceiver, String
  attribute :hascollector,          String
  attribute :publicnames,           Array
  attribute :practiceid,            Integer

  def self.all(connection:)
    connection.practiceid = 1
    response = connection.GET(BASE_URL)
    response['practiceinfo'].map { |attributes| Practice.new(attributes)}
  end

  def self.find(connection:, practiceid:)
    connection.practiceid = practiceid
    response = connection.GET(BASE_URL)
    Practice.new(response['practiceinfo'][0])
  end
end
