namespace :fide do
  desc "Download and parse of current ratings"
  task :download_ratings => :environment do
    FideRating.download_and_parse_rating()
    puts 'Done'
  end

  desc "Download players list and add to db"
  task :download_players => :environment do
    FideRating.download_and_add_players()
    puts 'Done'
  end
end
