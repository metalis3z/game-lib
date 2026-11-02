local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

local config = model.Config
local accessory = model.Accessory
local humanoid = model.Humanoid

local MAX_NUM_ACCESSORIES = 6

local MarketplaceService = game:GetService("MarketplaceService")

local validAssetTypeIds = {[8] = true,[41]=true,[42]=true,[43]=true,[44]=true,[45]=true,[46]=true,[47]=true}

local function LoadAccessory(id)

	local success,assetModel = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
		
	if success then
		accessory:Destroy()
		local newAccessory = assetModel:GetChildren()[1]
		--newAccessory.Parent = model
		accessory:Destroy()
		accessory = newAccessory
		
		humanoid:AddAccessory(newAccessory)
			
	end
end


workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	print(object == model , player == owner)
	if object == model and player == owner then
		model.Config.Value = newId
		local success,assetInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(newId,0) end)
		if success and validAssetTypeIds[assetInfo.AssetTypeId] then
			wait(1) --a little delay to slow things down
			LoadAccessory(newId)
		end
	end
end)



function Clicked(clicker)
	if clicker == owner then
		if not Dialog:GetChoice(clicker,"Options","Do you want to wear this accessory or configure the accessory display?","Wear","Configure") then
			workspace.Main.OpenAssetPicker:FireClient(clicker,model,"Accessory")
			return
		end
	end

	local count = 0
	for _,item in ipairs(clicker.Character:GetChildren()) do
		if item:IsA("Accessory") then
			count = count + 1
		end
	end
	
	if count >= MAX_NUM_ACCESSORIES then
		if Dialog:GetChoice(clicker,"Options","You are wearing too many accessories. Do you want to remove your accessories?","Remove","Keep") then
			for _,item in ipairs(clicker.Character:GetChildren()) do
				if item:IsA("Accessory") then
					item:Destroy()
				end
			end
		end
		return
	end


	local success,assetModel = pcall(function() return game:GetService("InsertService"):LoadAsset(config.Value) end)
	
	if success then
		clicker.Character.Humanoid:AddAccessory(assetModel:GetChildren()[1])
	end
	
end



model.ClickDetector.MouseClick:connect(Clicked)


if config.Value > 0 then
	
	LoadAccessory(config.Value)
	
elseif config.Value <= 0 and owner and owner.Parent and owner:DistanceFromCharacter(model.Head.Position) < 150 then --dont show if player has just entered the game
	
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Accessory")

end
	


		
	
