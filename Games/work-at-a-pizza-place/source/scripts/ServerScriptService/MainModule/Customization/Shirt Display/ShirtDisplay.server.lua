local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value


local config = model.Config
local shirt = model.Shirt

local MarketplaceService = game:GetService("MarketplaceService")



local function LoadShirt(id)
	local success,assetModel = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
	if success then
		shirt:Destroy()
		local newShirt = assetModel:GetChildren()[1]
		newShirt.Parent = model
		shirt:Destroy()
		shirt = newShirt
	end
end


SHIRT_ASSET_ID = 11
workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == owner then
		model.Config.Value = newId
		local success,assetInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(newId,0) end)
		if success and assetInfo.AssetTypeId == SHIRT_ASSET_ID then
			LoadShirt(newId)
		end
	end
end)



function Clicked(clicker)
	
	if clicker.Character:FindFirstChild("Uniform") then
		Dialog:ShowMessage(clicker,"Uniform","You must take off your uniform before you can wear this.")
		return
	end
	
	
	if clicker == owner then
		if not Dialog:GetChoice(clicker,"Options","Do you want to wear this shirt or configure the shirt display?","Wear","Configure") then
			workspace.Main.OpenAssetPicker:FireClient(clicker,model,"Shirt")
			return
		end
	end
	
	if clicker.Character and clicker.Character:FindFirstChild("Shirt") then
		clicker.Character.Shirt:Destroy()
	end
	
	clicker:LoadCharacterAppearance(shirt:clone())
	
end



model.ClickDetector.MouseClick:connect(Clicked)


if config.Value > 0 then
	
	LoadShirt(config.Value)
	
elseif config.Value <= 0 and owner and owner.Parent and owner:DistanceFromCharacter(model.Head.Position) < 150 then --dont show if player has just entered the game
	
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Shirt")

end
	


		
	
