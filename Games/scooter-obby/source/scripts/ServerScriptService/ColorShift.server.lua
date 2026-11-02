local rs = game:GetService("ReplicatedStorage")

rs.RemoteEvents.colorShift.OnServerEvent:Connect(function(player)
	local ScooterModel = workspace.Ignore:FindFirstChild(player.Name .. "Scooter")
	
	local color = math.random(1,12)
	local crimson = Color3.fromRGB(67, 0, 0)
	local red = Color3.fromRGB(255, 0, 0)
	local orange = Color3.fromRGB(255, 128, 0)
	local yelloworange = Color3.fromRGB(255, 200, 0)
	local yellow = Color3.fromRGB(255, 255, 0)
	local yellowgreen = Color3.fromRGB(200, 255, 0)
	local green = Color3.fromRGB(0, 128, 0)
	local lime = Color3.fromRGB(0, 255, 0)
	local teal = Color3.fromRGB(0, 255, 200)
	local blue = Color3.fromRGB(0, 0, 255)
	local indigo = Color3.fromRGB(64, 0, 255)
	local purple = Color3.fromRGB(128, 0, 255)
	local colors = {crimson, red, orange, yelloworange, yellow, yellowgreen, green, lime, teal, blue, indigo, purple}

	for i, v in pairs(ScooterModel:GetChildren()) do
		if v:GetAttribute("Colorable") then
			if v:IsA("BasePart") then
				v.Color = colors[color]
			end
		end
	end
end)