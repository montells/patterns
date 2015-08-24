class Task
	
	attr_accessor :name, :parent

	def initialize( name )
		@name = name
		@parent = nil
	end
	
	def get_time_required
		raise "Calling abstract method: \"get_time_required\" in \"#{self.class}\" class"
	end

	def total_number_basic_tasks
		1
	end

end

class CompositeTask < Task
	
	def initialize( name )
		super ( name )
		@sub_tasks = []
	end
	
	def <<( task )
		@sub_tasks << task
		task.parent = self
	end

	def remove_sub_task( task )
		@sub_tasks.delete task
		task.parent = nil
	end

	def []( index )
		@sub_tasks[index]	
	end

	def []=( index, task) 
		@sub_tasks[index] = task
	end

	def get_time_required
		@sub_tasks.inject(0){ |time, task| time + task.get_time_required  }		
	end	

	def total_number_basic_tasks
		@sub_tasks.inject(0){ |total, task| total + task.total_number_basic_tasks }
	end

end

class AddDryIngredientsTask < Task
	
	def initialize
		super( 'add dry ingredients' )
	end

	def get_time_required
		1.0
	end

end

class AddLiquidIngredientsTask < Task
	
	def initialize
		super( 'add liquid ingredients' )
	end

	def get_time_required
		2.0
	end

end

class MixTask < Task
	
	def initialize
		super ( 'Mix that batter up!' )
	end
	
	def get_time_required
		3.0
	end

end

class FillPanTask < Task
	def initialize
		super 'Fill pan task'
	end
	
	def get_time_required
		3.0
	end
	
end

class MakeBatterTask < CompositeTask
	
	def initialize
		super( 'make batter task' )
		self.<<( AddDryIngredientsTask.new )
		self.<< AddLiquidIngredientsTask.new 
		self.<< MixTask.new 
	end

end

class MakeCake < CompositeTask

	def initialize
		super 'Make Cake'				
	end
	
end

task = FillPanTask.new
mbt = MakeCake.new
mbt << MakeBatterTask.new
mbt << task
mbt[2] = MixTask.new

puts mbt.get_time_required
puts mbt[1].name
puts mbt[2].name


while task
	puts "task #{task.name}"
	task = task.parent
end

puts mbt.total_number_basic_tasks