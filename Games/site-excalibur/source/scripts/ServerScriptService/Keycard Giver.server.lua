game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		if plr.Name == "ape" or plr:GetRankInGroup(15349810) == 57 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-D")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 1 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-D")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 2 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-D")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 4 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-0")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 5 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-1")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 6 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-2")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 22 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-3")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 23 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-4")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) ==24 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-5")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 25 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-Omni")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		elseif plr:GetRankInGroup(15349810) == 255 then
			local ItemInServerStorage = game.ServerStorage:WaitForChild("CL-Omni")
			local Clone = ItemInServerStorage:Clone()
			Clone.Parent = plr.Backpack
		end
	end)
end)