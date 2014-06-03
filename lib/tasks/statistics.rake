namespace :statistics do
  desc "Count and save player statistics"
  task :players => :environment do
    Statistic.generate_players_statistics
    puts 'Done'
  end
end
