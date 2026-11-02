

--DO NOT EDIT

local eventDetained = game.ReplicatedStorage.Detain.Detained
local eventDetain = game.ReplicatedStorage.Detain.Detain

eventDetain.OnServerEvent:Connect(function(Player, toggled, hum, plr)
	if toggled == true then
		local torso = hum.Parent:FindFirstChild("Torso") or hum.Parent:FindFirstChild("UpperTorso")
		torso.CanCollide = false
		local detainTorso = Player.Character:FindFirstChild("Torso") or Player.Character:FindFirstChild("UpperTorso")
		local able = true
		spawn((function() while able == true do torso.CFrame = detainTorso.CFrame + (detainTorso.CFrame.lookVector * 2.5) wait(.1) end end))
		if plr then
			eventDetained:FireClient(plr, true)
		end
		hum.Died:Connect(function()
			if plr then
				eventDetained:FireClient(plr, false)
			end
			able = false
			torso.CanCollide = true
			return
		end)
		eventDetain.OnServerEvent:Connect(function(Player2, toggled)
			if Player2 == Player and toggled == false then
				able = false
				if plr then
					eventDetained:FireClient(plr, false)
				end
				torso.CanCollide = true
				return
			end
		end)
		Player.Character.Humanoid.Died:Connect(function()
			if plr then
				eventDetained:FireClient(plr, false)
			end
			able = false
			torso.CanCollide = true
			return
		end)
	end
end)