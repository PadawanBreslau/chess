class ChessLogger < Logger
	def format_message(severity, timestamp, progname, msg)
		"[#{timestamp.to_formatted_s(:db)}]  [#{severity}]  #{msg}\n"
	end
end

standard_logfile = File.open("#{Rails.root}/log/standard_info.log", 'a')
error_logfile = File.open("#{Rails.root}/log/standard_error.log", 'a')
standard_logfile.sync = true
error_logfile.sync = true

ST_LOG = ChessLogger.new(standard_logfile)
ER_LOG = ChessLogger.new(error_logfile)