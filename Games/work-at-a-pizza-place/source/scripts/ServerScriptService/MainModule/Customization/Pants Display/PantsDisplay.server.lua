local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

local config = model.Config
local pants = model.Pants

local MarketplaceService = game:GetService("MarketplaceService")



local function LoadPants(id)
	
	local success,assetModel = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
	if success then
		pants:Destroy()
		local newPants = assetModel:GetChildren()[1]
		newPants.Parent = model
		pants:Destroy()
		pants = newPants
	end
end

PANTS_ASSET_ID = 12
workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == owner then
		model.Config.Value = newId
		local success,assetInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(newId,0) end)
		if success and assetInfo.AssetTypeId == PANTS_ASSET_ID then
			LoadPants(newId)
		end
	end
end)


function Clicked(clicker)
	
	if clicker.Character:FindFirstChild("Uniform") then
		Dialog:ShowMessage(clicker,"Uniform","You must take off your uniform before you can wear this.")
		return
	end
	
	if clicker == owner then
		if not Dialog:GetChoice(clicker,"Options","Do you want to wear these pants or configure the pants display?","Wear","Configure") then
			workspace.Main.OpenAssetPicker:FireClient(clicker,model,"Pants")
			return
		end
	end
	
	if clicker.Character and clicker.Character:FindFirstChild("Pants") then
		clicker.Character.Pants:Destroy()
	end
	
	
	clicker:LoadCharacterAppearance(pants:clone())
	
end



model.ClickDetector.MouseClick:connect(Clicked)


if config.Value > 0 then
	
	LoadPants(config.Value)
	
elseif config.Value <= 0 and owner and owner.Parent and owner:DistanceFromCharacter(model.Head.Position) < 150 then --dont show if player has just entered the game
	
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Pants")

end
	


		
	
