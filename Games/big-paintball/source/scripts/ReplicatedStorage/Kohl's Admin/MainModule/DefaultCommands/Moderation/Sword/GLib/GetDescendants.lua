--[[
	Returns a list of an object's descendants
	
	INPUT: Object object
	OUTPUT: Table descendants
--]]

return function(object)
	local list = {}
	
	local search;search = function(parent)
		for index, child in next, parent:GetChildren() do
			table.insert(list, child)
			search(child)
		end
	end
	
	search(object)
	
	return list
end