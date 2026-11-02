local module = {}

local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
local VIPContent = require(game.ReplicatedStorage.Modules.Schematics.VIPKillersSchematic)

local function GetAssetType(Asset)
	return Asset.Parent.Parent.Parent == game.ReplicatedStorage.Assets.Skins and "Skins" or Asset.Parent == game.ReplicatedStorage.Assets.Killers and "Killers" or Asset.Parent == game.ReplicatedStorage.Assets.Survivors and "Survivors" or Asset.Parent == game.ReplicatedStorage.Assets.Emotes and "Emotes" or nil
end

module.Start = function()

	Network:SetConnection("PurchaseContent", "REMOTE_FUNCTION", function(Player : Player, Asset : Instance)
		
		if not Asset then return end
		if not game.ReplicatedStorage.Assets:IsAncestorOf(Asset) then return end
		local plrData : Folder = Player:FindFirstChild("PlayerData")
		if not plrData then return end
		if not plrData:FindFirstChild("Purchased") then return end
		if not plrData:FindFirstChild("Stats") then return end
		
		local AssetType = GetAssetType(Asset)
		if not AssetType then return end
		if not plrData.Purchased:FindFirstChild(AssetType) then
			warn("[PURCHASECONTENT] for whatever reason, your playerdata doesnt have a folder for purchased "..AssetType)
			return
		end
		print("[PURCHASECONTENT] Attempting to purchase from category "..AssetType)
		
		local config = Asset:IsA("ModuleScript") and AssetType == "Emotes" and Asset or Asset:FindFirstChild("Config")
		if (not config) or (not config:IsA("ModuleScript")) then return end
		config = require(config)
		if config.Exclusive then
			Network:FireClientConnection(Player, "SendNotif", "REMOTE_EVENT", "mmmm nah i dont think so", Color3.new(1, 0.5, 0.5), 5962000)
			return
		end
		local price : number = config.Price
		if (not price) or (type(price)~="number") then return end
		local balanceValue : NumberValue = plrData.Stats:FindFirstChild("Money", true)
		local balance : number = balanceValue.Value
		if plrData.Purchased[AssetType]:FindFirstChild(Asset.Name) then
			return "alreadyBought"
		end
		if price > balance then
			return "poor"
		end
		
		balanceValue.Value -= price
		Instance.new("IntValue", plrData.Purchased[AssetType]).Name = Asset.Name
		return "success"
		
	end)

	Network:SetConnection("EquipState", "REMOTE_EVENT", function(Player : Player, Asset : Instance, ExtraVal)
		if not Asset then return end
		local plrData : Folder = Player:FindFirstChild("PlayerData")
		if not plrData then return end
		if Asset == "Emotes" then
			if not plrData.Equipped:FindFirstChild("Emotes") then return end
			local slots = string.split(plrData.Equipped.Emotes.Value, "|")
			slots[ExtraVal] = "nil"
			plrData.Equipped.Emotes.Value = table.concat(slots, "|")
			return
		end
		if not game.ReplicatedStorage.Assets:IsAncestorOf(Asset) then return end
		if not plrData:FindFirstChild("Equipped") then return end
		if not plrData:FindFirstChild("Purchased") then return end

		local AssetType = GetAssetType(Asset)
		if not AssetType then return end
		local AssetValue = plrData.Equipped:FindFirstChild(AssetType) or plrData.Equipped:FindFirstChild(string.sub(AssetType, 1, string.len(AssetType)-1))
		if not AssetValue then
			warn("[EQUIPCONTENT] for whatever reason, your playerdata doesnt have a folder or value for equipped "..AssetType)
			return
		end
		print("[EQUIPCONTENT] Attempting to equip from category "..AssetType)

		if (not plrData.Purchased[AssetType]:FindFirstChild(Asset.Name)) then
			local notOwned = true
			if Player:GetAttribute("VIP") and workspace:GetAttribute("ServerType") == "VIP" then
				for _, vip in pairs(VIPContent) do
					if vip.Type == AssetType and vip.Name == Asset.Name then
						notOwned = false
					end
				end
			end
			if notOwned then
				Network:FireClientConnection(Player, "SendNotif", "REMOTE_EVENT", `you dont own "{Asset.Name}"`, Color3.new(1, 0.5, 0.5))
				return
			end
		end
		
		if AssetType == "Skins" then
			ExtraVal = ExtraVal and true or false
			local actorName = Asset.Parent and Asset.Parent.Name
			if not actorName then return end
			local Value = AssetValue:FindFirstChild(actorName)
			if not Value then return end
			Value.Value = ExtraVal and "" or Asset.Name
		elseif AssetType == "Emotes" then
			ExtraVal = ExtraVal
			if ExtraVal < 1 or ExtraVal > 8 then return end
			local slots = string.split(AssetValue.Value, "|")
			slots[ExtraVal] = Asset.Name
			AssetValue.Value = table.concat(slots, "|")
		else
			AssetValue.Value = Asset.Name
		end
		
	end)

end

return module