TruncateHtml.configure do |config|
	config.length  = 250
	config.omission      = '...(continued)'
	config.word_boundary = false
	config.break_token = '<!-- truncate -->'
end