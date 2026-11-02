local module = {}

local Network = require(game.ReplicatedStorage.Modules.Network)
local ItemsModule = require(game.ReplicatedStorage.Modules.Items)

module.Start = function()
	Network:SetConnection('UpdateItemParent', 'REMOTE_EVENT', function(Player : Player, Item : Tool)
		if not Item:IsA("Tool") then return end
		
		local Character = Player.Character
		if not Character then return end
		
		local HRP = Character.PrimaryPart
		if not HRP then return end
		
		if not ItemsModule:DoesItemExist(Item.Name) then return end
		
		local ItemRoot : BasePart = Item:FindFirstChild("ItemRoot")
		if (not ItemRoot) or (not ItemRoot:IsA("BasePart")) then return end
		
		if Item.Parent == Player.Character then
			Item.Parent = Player.Backpack
		elseif Item.Parent == Player.Backpack then
			for _, tool in pairs(Player.Character:GetChildren()) do
				if tool:IsA("Tool") then
					tool.Parent = Player.Backpack
				end
			end
			Item.Parent = Player.Character
		end
	end)
	Network:SetConnection('DropItem', 'REMOTE_EVENT', function(Player: Player, Item : Tool)
		if Item.Parent == Player.Backpack or Player.Character and Item.Parent == Player.Character then
			Item.Parent = workspace.Map.Ingame
		end
	end)
end

return module