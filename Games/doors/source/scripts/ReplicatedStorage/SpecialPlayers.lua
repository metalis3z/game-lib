local m = {}

m.isSpecial = function(n)
	local list = {"code_return1","XZrtgf"}
	local is_spec = false
	for i,v in pairs(list) do
		if string.lower(v) == string.lower(n) then
			is_spec = true
		end
	end
	
	return is_spec
end

return m