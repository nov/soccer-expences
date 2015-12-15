namespace :spent_budget do
  desc 'Re-calcurate everyone\'s spent budget'
  task re_calculate: :environment do
    Member.calculate_spent_budget
  end
end
