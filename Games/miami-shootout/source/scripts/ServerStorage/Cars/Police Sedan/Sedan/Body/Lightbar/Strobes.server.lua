script.Parent.RemoteEvent.OnServerEvent:Connect( function(player, pattern)
	--[[
	if script.Parent.on.Value == 0 then
		script.Parent.on.Value = 1
	elseif script.Parent.on.Value == 1 then
		script.Parent.on.Value = 2
	elseif script.Parent.on.Value == 2 then
		script.Parent.on.Value = 3 
	elseif script.Parent.on.Value == 3 then
		script.Parent.on.Value = 0
	end
	--]]
end)