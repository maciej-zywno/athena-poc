class ClientTest
  def run
    # razorbear sandbox account data
    key = 'vnr5gy93grxh9ay5xhrzy6xm'
    secret = 'uYUX8UZAMcPBbtN'
    #practiceId = 195900

    client = Client.new(key, secret)

    # GET PRACTICE ID
    available_practices = client.get_available_practices
    practice_id = available_practices['practiceinfo'][0]['practiceid']
    client.set_practice_id(practice_id)

    # GET INSURANCE PACKAGES
    client.get_top_insurance_packages.to_json

    # CREATE / GET PATIENT
    department_id = 1 # MAIN ST (HUB)
    first_name, last_name = 'Maciej', 'Zywno'
    birthdate = '6/18/1987'
    address, city = 'Testowa 12R2', 'Lodz'

    # patient = client.create_patient(department_id, first_name, last_name, birthdate, address, city)
    # patient_id = patient[0]['patientid'] # 21192
    patients = client.get_patient(21192)

    # GET PROVIDERS

    # custom_fields = client.get_custom_fields
    # departments = client.get_departments
    providers = client.get_providers
    #
    # departments['departments'].each do |department|
    #   puts "DEPARTMENT: #{department['departmentid']} #{department['name']}"
    # end
    # providers['providers'].each do |provider|
    #   puts "PROVIDER: #{provider['providerid']} #{provider['firstname']} #{provider['lastname']} #{provider['ansinamecode']}"
    # end

    # GET REASONS

    reasons_hash = {}
    providers['providers'].each do |provider|
      reasons = client.get_patient_appointment_reasons(department_id, provider['providerid'])
      if reasons['totalcount'].to_i > 0
        puts "Provider: #{provider.inspect}"
        puts 'Reasons:'
        reasons['patientappointmentreasons'].each do |reason|
          puts reason.inspect
        end
        puts
      else
        puts "Provider: #{provider['providerid']} #{provider['firstname']} #{provider['lastname']} HAS NO REASONS"
      end
    end

    # FIND OPEN SLOTS

    start_date = DateTime.now
    end_date = DateTime.now + 2
    appointment_types = client.get_appointment_types
    appointment_types['appointmenttypes'].each do |appointment_type|
      puts "appointmenttypeid: #{appointment_type['appointmenttypeid']} #{appointment_type['name']}"
    end
    appointment_type_id = 82
    provider_id = 71
    department_id = 1
    open_appointment_slots = client.get_open_appointment_slots(provider_id, department_id,
                                                               start_date, end_date,
                                                               appointment_type_id)

    appointment_id = open_appointment_slots['appointments'][0]['appointmentid']
    # puts open_appointment_slots['appointments'][0].inspect

    # CREATE PATIENT PROBLEM

    patient_id = patients[0]['patientid']
    appointment_type_id = 82
    note = 'drugi problem bla bla'

    snomed_code = 57406009 # carpal tunnel syndrome
    snomed_code = 230630005 # Struther ligament entrapment (disorder)
    # problem = client.create_patient_problem(patient_id, department_id, snomed_code, note)

    problems = client.get_patient_problems(patient_id, department_id)

    # BOOK APPOINTMENT

    # client.book_appointment(appointment_id, patient_id, department_id, appointment_type_id)


    # VERIFY APPOINTMENTS

    client.get_appointments(patient_id)

    response = client.get_appointments_booked(patient_id, department_id, DateTime.now, DateTime.now + 100)
    response['appointments'].each do |appointment|
      puts appointment.inspect
    end
    return nil

    #  Either an appointmenttypeid or a reasonid must be specified or no results will be returned.
    # departments['departments'].each do |department|
    #   appointment_types['appointmenttypes'].each do |appointment_type|
    #     puts "DEPARTMENT: #{department['departmentid']} #{department['name']}"
    #     puts "appointmenttypeid: #{appointment_type['appointmenttypeid']}"
    #     open_appointment_slots = client.get_open_appointment_slots(provider_id, department['departmentid'],
    #                                                                start_date, end_date,
    #                                                                appointment_type['appointmenttypeid'])
    #     puts open_appointment_slots.inspect
    #   end
    # end
  end
end