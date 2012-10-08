#!/usr/bin/ruby -w

def checkCsvFile
	file_name = ARGV[0] 
	if File.exists?(file_name)
		if File.extname(file_name) == '.csv'	
		else
			log("Please provide csv file.","ERROR")
			exit 2
		end		
	else
		log(file_name + " does not exist in " + $FILE + " directory.","ERROR")
		exit 2
	end
end

def loadCsvFile(file_path)
	file = File.read(file_path)
	log("File " + file_path + " loaded correctly", "DEBUG")
	return file
end

def log(message, log_level)
	print Time.now.strftime("%Y-%m-%d %H:%M ")
	puts log_level + ": " + message
end
