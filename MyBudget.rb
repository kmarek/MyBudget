#!/usr/bin/ruby -w

# 
# Ruby MyBudget
#
# 03 OCT 2012

require 'pp'
Dir[File.dirname(__FILE__) + '/classes/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/scripts/*.rb'].each {|file| require file }

$FILE = File.expand_path(File.dirname(__FILE__))

if ARGV.length == 1
	checkCsvFile
	file = CsvFile.new(loadCsvFile(ARGV[0]))
else
	exit 2
end

file.evaluate
file.printSummary

#file.printContent

# regexp
#amount = line.match(/^([\d]+)\sROUNDS$/)[1]
