--[[
	Returns true if the object is protected by a forcefield
--]]

return function(obj)
	local protected = false
	local check = obj
	while true do
		local hasFF = false
		for index, child in next, check:GetChildren() do
			if child:IsA'ForceField' then
				hasFF = true
				break
			end
		end
		if hasFF then
			protected = true
			break
		else
			check = check.Parent
			if check == nil or check == game or check.Parent == game then
				break
			end
		end
	end
	
	return protected
end