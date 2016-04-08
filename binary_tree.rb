class Node 

attr_accessor :value, :parent, :left_child, :right_child

	def initialize(value, parent = nil, left_child = nil, right_child = nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end
end

class BinarySearchTree

	attr_accessor :root_node

	def initialize(root_node = nil)
		@root_node = root_node
	end

	def add_child(parent_node, child_node)
		if child_node.value <= parent_node.value	#Go left down the tree.

			if parent_node.left_child == nil	#Parent is a leaf node. 
				child_node.parent = parent_node
				parent_node.left_child = child_node
			else
				add_child(parent_node.left_child, child_node)	#algorithm is repeated one step lower.
			end

		elsif child_node.value > parent_node.value #Go right down the tree.
		
			if parent_node.right_child == nil	#Parent is leaf node.
				child_node.parent = parent_node
				parent_node.right_child = child_node
			else
				add_child(parent_node.right_child, child_node)	#algorithm is repeated one step lower.
			end
		end
	end

	def build_tree(array)
		@root_node = Node.new(array.shift)
		until array.empty?
			add_child(@root_node, Node.new(array.shift))
		end
		@root_node
	end

	def breadth_first_search(target) #use a queue structure to search for values.
		queue = []
		queue << root_node
		until queue.empty?
			current = queue.shift
			return current if current.value == target
			queue << current.left_child if current.left_child != nil
			queue << current.right_child if current.right_child != nil
		end
		return nil
	end

	def depth_first_search(target) #use a stack structure to search for values.
		stack = []
		stack.push(root_node)
		until stack.empty?
			current = stack.pop
			return current if current.value == target
				stack.push(current.left_child) if current.left_child != nil
				stack.push(current.right_child) if current.right_child != nil			
		end
		return nil
	end

	def dfs_rec(target, current=root_node) #recursively search for values. pass in node to check.
		return current if current.value == target
		left = dfs_rec(target, current.left_child) if current.left_child != nil
		return left if left
		right = dfs_rec(target, current.right_child) if current.right_child != nil
		return right if right
		return nil
	end
end

bst = BinarySearchTree.new
bst.build_tree([7,15,12,9])
puts bst.dfs_rec(15).value