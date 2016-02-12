class Patient
  include ActiveModel::Model
  include Virtus.model

  attribute :email,                          String
  attribute :occupationcode,                 String
  attribute :departmentid,                   Integer
  attribute :guarantorstate,                 String
  attribute :driverslicense,                 Boolean
  attribute :ethnicitycode,                  String
  attribute :industrycode,                   String
  attribute :contacthomephone,               String
  attribute :guarantorssn,                   String
  attribute :guarantordob,                   String
  attribute :zip,                            String
  attribute :guarantoraddresssameaspatient,  Boolean
  attribute :employerphone,                  String
  attribute :contactmobilephone,             String
  attribute :nextkinphone,                   String
  attribute :portaltermsonfile,              String
  attribute :status,                         String
  attribute :lastname,                       String
  attribute :guarantorfirstname,             String
  attribute :city,                           String
  attribute :ssn,                            String
  attribute :guarantoremail,                 String
  attribute :guarantorcity,                  String
  attribute :guarantorzip,                   String
  attribute :privacyinformationverified,     Boolean
  attribute :primarydepartmentid,            Integer
  attribute :balances,                       Array
  attribute :race,                           Array
  attribute :language6392code,               String
  attribute :primaryproviderid,              Integer
  attribute :patientphoto,                   Boolean
  attribute :caresummarydeliverypreference,  Boolean
  attribute :guarantorlastname,              Boolean
  attribute :firstname,                      String
  attribute :guarantorcountrycode,           String
  attribute :state,                          String
  attribute :patientid,                      Integer
  attribute :dob,                            String
  attribute :guarantorrelationshiptopatient, Integer
  attribute :address1,                       String
  attribute :guarantorphone,                 String
  attribute :countrycode,                    String
  attribute :guarantoraddress1,              String
  attribute :consenttotext,                  Boolean
  attribute :countrycode3166,                String
  attribute :guarantorcountrycode3166,       String

  validates :firstname, :lastname, :email, :dob, :departmentid, presence: true

   def create(connection:, params:)
    if valid?
      connection.practiceid = params[:practiceid]
      connection.POST('/patients', params)
      true
    else
      false
    end
  end

  def self.destroy(connection:, practiceid:, patientid:)
    connection.practiceid = practiceid
    response = connection.PUT("/patients/#{patientid}", { status: 'deleted' })
  end
end
