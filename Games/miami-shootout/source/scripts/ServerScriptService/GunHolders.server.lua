local MarketPlaceService = game:GetService("MarketplaceService")

local GamepassId = 107212490 -- 
local Tool = script.GunPermit -- 

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		if MarketPlaceService:UserOwnsGamePassAsync(Player.UserId, GamepassId) then
			local ToolClone = Tool:Clone()
			ToolClone.Parent = Player.Backpack
		end
	end)
end)