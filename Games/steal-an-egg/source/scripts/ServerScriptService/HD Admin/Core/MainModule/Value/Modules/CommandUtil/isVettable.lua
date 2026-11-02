--!strict
return function(command: any): boolean
	local tags = (command :: any).tags
	if typeof(tags) == "table" and table.find(tags :: {any}, "_Booster") then
		return false
	end
	return true
end
