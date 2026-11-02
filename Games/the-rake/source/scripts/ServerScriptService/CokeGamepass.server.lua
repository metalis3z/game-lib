--Services--
local MS = game:GetService("MarketplaceService")
local P = game:GetService("Players")
--Variables--
local Tool = script.Tool
local GamepassID = script.GamepassID
--Main--
P.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if MS:UserOwnsGamePassAsync(Player.UserId,GamepassID.Value) == true then
			local NewTool = Tool.Value:Clone()
			NewTool.Parent = Player.Backpack
		end
	end)
end)
