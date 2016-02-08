class Client

  VERSION = 'preview1'

  def initialize(key, secret)
    @api = AthenaConnection.new(VERSION, key, secret)
  end

  def set_practice_id(practice_id)
    @api.practiceid = practice_id
  end

  def get_available_practices
    @api.practiceid = 1
    response = @api.GET('/practiceinfo')
    @api.practiceid = nil
    response
  end

  def get_custom_fields
    assert_practice_id
    @api.GET('/customfields')
  end

  def get_departments
    assert_practice_id
    @api.GET('/departments')
  end

  def get_providers
    assert_practice_id
    @api.GET('/providers')
  end

  def get_provider(provider_id)
    assert_practice_id
    @api.GET("/providers/#{provider_id}")
  end

  def get_patient_appointment_reasons(department_id, provider_id)
    assert_practice_id
    params = {'departmentid' => department_id, 'providerid' => provider_id}
    @api.GET('/patientappointmentreasons', params)
  end

  def get_appointment_types(hide_template_type_only=true)
    assert_practice_id
    params = {'hidetemplatetypeonly' => hide_template_type_only}
    @api.GET('/appointmenttypes', params)
  end

  #  Either an appointmenttypeid or a reasonid must be specified or no results will be returned.
  def get_open_appointment_slots(provider_id, department_id, start_date, end_date, appointment_type_id, limit=1000)
    assert_practice_id
    date_format = '%m/%d/%Y'

    params = {
        'providerid' => provider_id,
        'departmentid' => department_id,
        'startdate' => start_date.strftime(date_format),
        'enddate' => end_date.strftime(date_format),
        'appointmenttypeid' => appointment_type_id,
        'limit' => limit,
    }

    @api.GET('/appointments/open', params)
  end

  def get_patient(patient_id)
    assert_practice_id
    @api.GET("/patients/#{patient_id}")
  end

  def get_patients(department_id)
    assert_practice_id
    params = {
        'departmentid' => department_id,
    }

    @api.GET('/patients', params)
  end

  def create_patient(department_id, first_name, last_name, birthdate, address, city)
    assert_practice_id
    params = {
        'lastname' => last_name,
        'firstname' => first_name,
        'address1' => address,
        'city' => city,
        'countrycode3166' => 'US',
        'departmentid' => department_id,
        'dob' => birthdate,
        'language6392code' => 'declined',
        'maritalstatus' => 'S',
        'race' => 'declined',
        'sex' => 'M',
        'ssn' => '*****1234',
        'zip' => '02139',
    }

    @api.POST('/patients', params)
  end

  # snomed_code https://www.nlm.nih.gov/research/umls/Snomed/snomed_browsers.html
  def create_patient_problem(patient_id, department_id, snomed_code, note)
    assert_practice_id
    params = {
        'patientid' => patient_id,
        'departmentid' => department_id,
        'snomedcode' => snomed_code,
        'note' => note,
    }

    @api.POST("/chart/#{patient_id}/problems", params)
  end

  def get_patient_problems(patient_id, department_id)
    assert_practice_id
    params = {
        'patientid' => patient_id,
        'departmentid' => department_id,
    }

    @api.GET("/chart/#{patient_id}/problems", params)
  end

  def book_appointment(appointment_id, patient_id, department_id, appointment_type_id)
    params = {
        'patientid' => patient_id,
        'departmentid' => department_id,
        'appointmenttypeid' => appointment_type_id,
    }

    @api.PUT("/appointments/#{appointment_id}", params)
  end

  def get_top_insurance_packages
    assert_practice_id
    @api.GET("/misc/topinsurancepackages")
  end

  def get_appointments(patient_id)
    assert_practice_id
    @api.GET("/patients/#{patient_id}/appointments")
  end

  def get_appointments_booked(patient_id, department_id, start_date, end_date)
    assert_practice_id
    date_format = '%m/%d/%Y'

    params = {
        'patientid' => patient_id,
        'departmentid' => department_id,
        'startdate' => start_date.strftime(date_format),
        'enddate' => end_date.strftime(date_format),
    }
    @api.GET('/appointments/booked', params)
  end

  def foo

  ####################################################################################################
  # POST without parameters
  ####################################################################################################
    checked_in = api.POST("/appointments/#{appt['appointmentid']}/checkin")
    puts 'Response to check-in:'
    pp checked_in


  ####################################################################################################
  # DELETE with parameters
  ####################################################################################################
    removed_chart_alert = api.DELETE("/patients/#{new_patient_id}/chartalert", {'departmentid' => 1})
    puts 'Removed chart alert:'
    pp removed_chart_alert


  ####################################################################################################
  # DELETE without parameters
  ####################################################################################################
    removed_appointment = api.DELETE("/appointments/#{appt['appointmentid']}")
    puts 'Removed appointment:'
    pp removed_appointment

  ####################################################################################################
  # There are no PUTs without parameters
  ####################################################################################################


  ####################################################################################################
  # Error conditions
  ####################################################################################################
    bad_path = api.GET('/nothing/at/this/path')
    puts 'GET /nothing/at/this/path:'
    pp bad_path

    missing_parameters = api.GET('/appointments/open')
    puts 'Response to missing parameters:'
    pp missing_parameters


  ####################################################################################################
  # Testing refresh tokens
  ####################################################################################################

  # NOTE: This test takes an hour to run, so it's disabled by default. Change false to true to run it.
    if false
      oldtoken = api.token
      puts "Old token: #{oldtoken}"

      before_refresh = api.GET('/departments')


      # Wait 3600 seconds = 1 hour for token to expire.  If you don't need (or want) the progress
      # tracking, use the following line instead of the for-else block:
      sleep(3600)

      after_refresh = api.GET('/departments')

      puts "New token: #{api.token}"
    end
  end

  private

    def assert_practice_id
      raise 'no practice id configured' unless @api.practiceid
    end

end