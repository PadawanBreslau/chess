class ChessLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    "[#{timestamp.to_formatted_s(:db)}]  [#{severity}]  #{msg}\n"
  end
end

standard_logfile = File.open("#{Rails.root}/log/standard_info.log", 'a')
error_logfile = File.open("#{Rails.root}/log/standard_error.log", 'a')
result_logfile = File.open("#{Rails.root}/log/results.log", 'a')
byzantion_logfile = File.open("#{Rails.root}/log/byzantion_parser.log", 'a')
standard_logfile.sync = true
error_logfile.sync = true
result_logfile.sync = true

ST_LOG = ChessLogger.new(standard_logfile)
ER_LOG = ChessLogger.new(error_logfile)
RES_LOG = ChessLogger.new(result_logfile)
BYZ_LOG = ChessLogger.new(byzantion_logfile)
