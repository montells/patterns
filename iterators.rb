class ArrayIterator

	def initialize( array )
		@array = array
		@index = 0
	end
	
	def has_next?
		@index < @array.length
	end

	def item
		@array[index]
	end

	def next_item
		value = @array[@index]
		@index += 1
		value
	end
end


def for_each_element( array )
	i = 0			
	while i < array.length
		yield( array[i] )
		i += 1
	end
end	

#----------MIXING ENUMERABLE

class Account

	attr_accessor :name, :balance

	def initialize( name, balance )
		@name, @balance = name, balance
	end
	
	def <=>( other )
		balance <=> other.balance
	end

end

class Portafolio
	
	include Enumerable

	def initialize
		@accounts = []
	end
	
	def each( &block )
		@accounts.each( &block )
	end

	def add_account( account )
		@accounts << account
	end
end

array = %w(red blue yellow black)
external_array = ArrayIterator.new array

while external_array.has_next?
	puts "item: #{external_array.next_item}"
end

puts "internal array"
for_each_element( array ) {|element| puts "element: #{element}"}


p = Portafolio.new
p.add_account(Account.new('michel', 1000))
p.add_account(Account.new('helen', 2000))
p.add_account(Account.new('rocio', 200))

sorted = p.sort

sorted.each{|element| puts element.name}