local data = require(game.ServerScriptService.ProfileCache)

script.Parent.RemoteEvent.OnServerEvent:Connect(function(Player, On, Humanoid)
	if On then
		if Humanoid.Parent:FindFirstChild('Normal Vest') then
			Humanoid.Parent:FindFirstChild('Normal Vest'):Destroy()
		end
		game:FindService('ReplicatedStorage'):FindFirstChild('OutfitsOk'):FindFirstChild('Normal Vest'):Clone().Parent = Humanoid.Parent
		
		--[[
		if Humanoid.MaxHealth ~= 160 then
			Humanoid.MaxHealth = 160
			if Humanoid.Health >= 100 then
				Humanoid.Health = 160
			end
		end
		]]
		script.Parent.Handle.Transparency = 1
	else
		if Humanoid.Parent:FindFirstChild('Normal Vest') then
			Humanoid.Parent:FindFirstChild('Normal Vest'):Destroy()
		end
		--[[
		Humanoid.MaxHealth = 100 
		if Humanoid.Health >= 100 then
			Humanoid.Health = 100
		end
		]]
		script.Parent.Handle.Transparency = 0
	end
end)