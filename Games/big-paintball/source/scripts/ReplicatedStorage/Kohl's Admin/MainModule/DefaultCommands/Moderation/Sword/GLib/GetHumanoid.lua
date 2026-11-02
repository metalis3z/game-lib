--[[
	INPUT: Object character
	OUTPUT: Humanoid humanoid
--]]

return function(obj)
	if obj then
		for i, child in next, obj:GetChildren() do
			if child:IsA'Humanoid' then
				return child
			end
		end
	else
		return nil
	end
end