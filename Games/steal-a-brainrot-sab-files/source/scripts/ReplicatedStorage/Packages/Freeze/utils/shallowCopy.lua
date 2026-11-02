

local isImmutable = require(script.Parent.isImmutable)

return function(p1)
	if isImmutable(p1) then
		return p1:clone()
	end

	return table.clone(p1)
end
