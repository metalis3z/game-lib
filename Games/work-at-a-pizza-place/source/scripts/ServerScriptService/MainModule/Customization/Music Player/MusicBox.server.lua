local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value



workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == owner  then
		model.Config.Value = newId
	end
end)


function click(clicker)
	if clicker == owner then
		workspace.Main.OpenAssetPicker:FireClient(clicker,model,"Audio")
	end
end
model.ClickDetector.MouseClick:connect(click)


if model.Config.Value <= 0 and owner and owner.Parent and owner:DistanceFromCharacter(model.Part.Position) < 150 then --dont show if player has just entered the game
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Audio")
end
