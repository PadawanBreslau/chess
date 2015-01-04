require 'yaml'

begin
  config = YAML.load_file("#{Rails.root}/config/settings.yml")
  PGN_EVAL_SERVER = config['deployment']['pgn_eval_server']
rescue StandardError => e
  puts e.message
  raise
end
