#!/usr/bin/ruby -w

class CsvFile	
	def initialize(file_content)
		@file_content = file_content
		@mortgage = Mortgage.new
		@bills = Bills.new
		@car = Car.new
		@atm = Atm.new
		@savings = Savings.new
		@internal = Internal.new
		@income = Income.new
		@mobilephone = MobilePhone.new
		@other = Other.new
	end
	
	def evaluate
		log("CsvFile.evaluate", "INFO")
		@file_content.each { |line|
			array = line.to_s.split(';')
			if /^\d{4}-\d{2}-\d{2}$/ === array[0]
				case array[2]
				when "PRZELEW REGULARNE OSZCZ\312DZANIE"
					@savings.add_child(array[0], array[3], array[6])
					#print array[0] + ": "
					#print array[6]
					#puts @savings.sum
				when "WYP\243ATA W BANKOMACIE"
					@atm.add_child(array[0], array[3], array[6])
				when "PRZELEW W\243ASNY", "PRZELEW WEWN\312TRZNY PRZYCHODZ\245CY"
					@internal.add_child(array[0], array[3], array[6])
				when "PRZELEW ZEWN\312TRZNY WYCHODZ\245CY"
					if array[3].match(/(RATA KREDYTU).*/)
						@mortgage.add_child(array[0], array[3], array[6])
					else
						@bills.add_child(array[0], array[3], array[6])
						#log("bills: " + array[3] + array[6], "INFO")
					end
				when "PRODUKT DODATKOWY DO RACHUNKU"
					@car.add_child(array[0], array[3], array[6])
				when "PRZELEW ZEWN\312TRZNY PRZYCHODZ\245CY"
					@income.add_child(array[0], array[3], array[6])
					#log("income: " + array[3] + array[6], "INFO")
				when "ZAKUP PRZY U\257YCIU KARTY"
					if array[3].match(/(SHELL|BP\sNR)\s.*/)
						#log("car: " + array[3] + array[6], "INFO")
						@car.add_child(array[0], array[3], array[6])
					else
						@other.add_child(array[0], array[3], array[6])
						#log("other: " + array[3] + array[6], "INFO")
						#log("other-sum" + @other.sum.to_s, "INFO")
					end
				else
					next if array[6] == nil
					if array[3].match(/.*HEYAH.*/)
						@mobilephone.add_child(array[0], array[3], array[6])
					else
						@other.add_child(array[0], array[3], array[6])
						log("other: " + array[3] + array[6], "INFO")
					end
				end
			end
		}
	end
	
	def printSummary
		puts "--- SUMMARY ---"
		puts "Income: " + @income.sum.to_s
		print "Outcome: "
		puts @mortgage.sum + @bills.sum + @car.sum + @atm.sum + @other.sum
		puts "---------------"
		puts "Mortgage: " + @mortgage.sum.to_s
		puts "Bills: " + @bills.sum.to_s
		puts "Car: " + @car.sum.to_s
		puts "Mobile Phone: " + @mobilephone.sum.to_s
		puts "---------------"
		puts "atm: " + @atm.sum.to_s
		puts "other: " + @other.sum.to_s
		puts "---------------"
		puts "savings: " + @savings.sum.to_s
		puts "---------------"
		puts "internal: " + @internal.sum.to_s
		puts "---------------"
	end
	
	def printContent
		i = 1
		@file_content.each { |line|
			print i.to_s + ": "
			sline = line.to_s
			array = sline.split(';')
			p array
			i = i + 1
		}
	end
end
