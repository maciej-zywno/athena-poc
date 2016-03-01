crumb :root do
  link 'Dashboard', '/'
end

crumb :practices do
  link 'Practices', practices_path
end

crumb :treatments do
  link 'Treatments', treatments_path
end

crumb :treatment do |treatment|
  link treatment, treatment_path(treatment)
  parent :treatments
end

crumb :questions do |treatment|
  link 'Questions', treatment_questions_path(treatment)
  parent :treatment, treatment
end

crumb :question do |treatment, question|
  link question, treatment_questions_path(treatment, question)
  parent :questions, treatment
end

crumb :new_question do |treatment|
  link 'New Question', treatment_questions_path(treatment)
  parent :questions, treatment
end

crumb :edit_question do |treatment|
  link 'Edit Question', treatment_questions_path(treatment)
  parent :questions, treatment
end

crumb :answers do |question|
  link 'Questions', treatment_questions_path(question.treatment)
  link question.id, treatment_question_path(question.treatment, question)
  link 'Answers', question_answers_path(question)
end

crumb :practice do |practice|
  link practice, practice_path(practice)
  parent :practices
end

crumb :departments do |practice, departments|
  link 'Departments', practice_departments_path(practice)
  parent :practice, practice
end

crumb :providers do |practice|
  link 'Providers', practice_providers_path(practice)
  parent :practice, practice
end

crumb :insurance_packages do |practice|
  link 'Insurance Packages', practice_insurance_packages_path(practice)
  parent :practice, practice
end

crumb :department do |practice, department|
  link department, practice_department_path(practice, department)
  parent :departments, practice, department
end

crumb :patients do |practice, department|
  link 'Patients', practice_department_patients_path(practice, department)
  parent :department, practice, department
end

crumb :patient do |practice, department, patient|
  link patient, practice_department_patient_path(practice, department, patient)
  parent :patients, practice, department
end

crumb :new_patient do |practice, department|
  link 'New patient', new_practice_department_patient_path(practice, department)
  parent :patients, practice, department
end

crumb :edit_patient do |practice, department|
  link 'Edit patient', new_practice_department_patient_path(practice, department)
  parent :patients, practice, department
end

crumb :update_my_account do
  link 'Update my account', edit_user_registration_path
end
