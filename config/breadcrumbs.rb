crumb :root do
  link 'Dashboard', '/'
end

crumb :practices do
  link 'Practices', practices_path
end

crumb :games do
  link 'Games', games_path
end

crumb :game do |game|
  link game, game_path(game)
  parent :games
end

crumb :questions do |game|
  link 'Questions', game_questions_path(game)
  parent :game, game
end

crumb :question do |game, question|
  link question, game_questions_path(game, question)
  parent :questions, game
end

crumb :new_question do |game|
  link 'New Question', game_questions_path(game)
  parent :questions, game
end

crumb :edit_question do |game|
  link 'Edit Question', game_questions_path(game)
  parent :questions, game
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
