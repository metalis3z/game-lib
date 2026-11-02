-- Adds a metatable to a table and all its descending tables

local fullmeta;fullmeta = function(t, meta)
	setmetatable(t, meta)
	for index, other in next, t do
		if type(other) == 'table' then
			fullmeta(other, meta)
		end
	end
	
	return t
end

return fullmeta