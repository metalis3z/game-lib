local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

local config = model.Config
local image = model.Image
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))



local player = house.Owner.Value



workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == owner  then
			
		config.Value = newId
			
		image.Image.Texture = "http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=" .. config.Value
			
	end
end)
		

print(owner:DistanceFromCharacter(image.Position),owner)

if config.Value == 0 and owner and owner.Parent and owner:DistanceFromCharacter(image.Position) < 150 then --dont show if player has just entered the game
	
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Decal")
end

