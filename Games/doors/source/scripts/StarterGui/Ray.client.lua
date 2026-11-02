local function ray(pos1, pos2)
	local result = workspace:Raycast(pos1, pos2)
	return result

end

game["Run Service"].Heartbeat:Connect(function()
	local main = workspace.CurrentCamera
	local distance = 50
	local pos1, pos2 = main.CFrame.Position, main.CFrame.LookVector * distance
	local ray_result = ray(pos1, pos2)
	local part_name = "BigSceryLookmenPart"

	if ray_result ~= nil  then
		if ray_result.Instance.Name == part_name then
			warn("you look on", part_name)
		end
	end

end)