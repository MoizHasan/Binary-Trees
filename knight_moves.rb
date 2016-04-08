class Node #One way tree.
	attr_accessor :value, :parent

	def initialize(value, parent = nil)
		@value = value
		@parent = parent
	end

end


def moves(start) #get all possible locations for next move. location should be coordinate [0,0]
#legal moves must be in range 0-7.
	moves = []
	moves << [start[0] -1, start[1] -2]
	moves << [start[0] -1, start[1] +2]
	moves << [start[0] +1, start[1] -2]
	moves << [start[0] +1, start[1] +2]
	moves << [start[0] -2, start[1] -1]
	moves << [start[0] -2, start[1] +1]
	moves << [start[0] +2, start[1] -1]
	moves << [start[0] +2, start[1] +1]
	moves
end

def is_valid?(move) #return true if a move stays on the board.
	 return move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8
end


def knight_moves(start, goal)

	queue = [] #breadth first search.
	visited = [] #keep track of visited square values.
	root_node = Node.new(start)
	queue << root_node
	until queue.empty?
		current = queue.shift
		visited << current.value
		if current.value == goal #solution found.
			array = []
			until current == nil #go up the tree.
				array << current.value
				current = current.parent
			end
			return array.reverse!
		end

		moves(current.value).each do |m| #add valid moves to the queue and link them to the current node.
			queue << Node.new(m, current) if is_valid?(m) && m != start && !visited.include?(m)
		end
	end
end


puts "#{knight_moves([3,3], [4,3])}"
