

local isValueObject = require(script.Parent.isValueObject)

return function(p1, p2)
	if p1 == p2 or p1 ~= p1 and p2 ~= p2 then
		return true
	end

	if not p1 or not p2 then
		return false
	end

	if typeof(p1) == "function" and typeof(p2) == "function" then
		p1 = p1()
		p2 = p2()

		if p1 == p2 or p1 ~= p1 and p2 ~= p2 then
			return true
		end

		if not p1 or not p2 then
			return false
		end
	end

	return not not (isValueObject(p1) and (isValueObject(p2) and p1.equals(p2)))
end
