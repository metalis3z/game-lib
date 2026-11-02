task.spawn(function()
	local Resources = game:GetService("ServerStorage"):WaitForChild("Resources")
	local Lobby = Resources:FindFirstChild("Lobby")
	if Lobby and not workspace:FindFirstChild("Lobby") then
		Lobby:Clone().Parent = workspace
	end
end)

if game:GetService("RunService"):IsStudio() then
	game:BindToClose(function()
		local Lobby = workspace:FindFirstChild("Lobby")
		if Lobby then
			Lobby:Destroy()
		end
	end)
end

