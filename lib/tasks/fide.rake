namespace :fide do
  desc "Download and parse of current ratings"
  task :download_ratings => :environment do
    FideRating.download_and_parse_rating()
    puts 'Done'
  end
end