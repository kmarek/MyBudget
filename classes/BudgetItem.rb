#!/usr/bin/ruby -w

class BudgetItem
	def initialize
		@children = []
		@sum = 0
	end
	
	def sum
		return @sum		
	end
	
	def add_child(date, description, value)
		# Replace "," with "." and convert string into float
		return false if value == nil
		#puts date.to_s + description.to_s + value.to_s
		value = value.gsub(" ", "")
		value = value.gsub(",", ".").to_f.abs()
		@children << [date, description, value]	
		@sum = @sum + value
	end
end

class Mortgage < BudgetItem

end

class Bills < BudgetItem

end

class Atm < BudgetItem

end

class Car < BudgetItem

end

class Savings < BudgetItem

end

class Internal < BudgetItem

end

class MobilePhone < BudgetItem

end

class Income < BudgetItem

end

class Other < BudgetItem

end
