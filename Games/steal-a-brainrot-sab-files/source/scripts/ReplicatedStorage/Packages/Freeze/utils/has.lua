

local isImmutable = require(script.Parent.isImmutable)
local isDataStructure = require(script.Parent.isDataStructure)

return function(p1, p2)
	if isImmutable(p1) then
		return (p1:has(p2))
	end

	return isDataStructure(p1) and p1[p2] ~= nil
end
