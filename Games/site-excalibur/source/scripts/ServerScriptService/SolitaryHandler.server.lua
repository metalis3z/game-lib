--[[Ulysse94]]--
local mainSolitaryCell = workspace.SolitaryCell --Players that have been put in solitary will be automatically in this SolitaryCell.

--DO NOT EDIT
local serv = game:GetService("DataStoreService")
local store = serv:GetDataStore("SolitaryCells")
game.ReplicatedStorage.Solitary.SolitaryStart.OnServerEvent:Connect(function(plr)
	if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
		plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 0
		plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = 0
		pcall(function()
			if not store:GetAsync(plr.UserId) then
				store:SetAsync(plr.UserId, true)
			end
		end)
	end
end)
game.ReplicatedStorage.Solitary.SolitaryEnd.OnServerEvent:Connect(function(plr)
	if plr.Character then
		pcall(function()
			if store:GetAsync(plr.UserId) then
				store:RemoveAsync(plr.UserId)
			end
		end)
		plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
	end
end)
game.Players.PlayerAdded:Connect(function(plr)
	wait(10)
	plr.CharacterAdded:Connect(function(char)
		local trigger = false
		pcall(function()
			if store:GetAsync(plr.UserId) then
				trigger = true
			end
		end)
		if trigger == true then
			plr.Team = game.Teams:FindFirstChild(require(mainSolitaryCell:FindFirstChild("ModuleScript"))["AllowedTeams"][1])
			char:FindFirstChild("HumanoidRootPart").CFrame = mainSolitaryCell.CFrame
			char:FindFirstChildOfClass("Humanoid").WalkSpeed = 0
			char:FindFirstChildOfClass("Humanoid").JumpPower = 0
		end
	end)
end)