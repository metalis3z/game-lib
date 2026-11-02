

return function(p1)
	if p1 and (typeof(p1) == "table" and typeof(p1.equals) == "function") then
		return true
	end

	return false
end
