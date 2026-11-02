local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local owner = house.Owner.Value

local board = model.Board
local surface = board:WaitForChild("SG")
local image = surface:WaitForChild("ImageLabel")
local name = surface:WaitForChild("name")
local config = model.Config


TeleportService = game:GetService('TeleportService')
TeleportService.CustomizedTeleportUI = true



workspace.Main.AssetIdChanged.OnServerEvent:connect(function(player,object,newId)
	if object == model and player == owner  then
		
		config.Value = newId
		
		surface.ImageLabel.Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=160&height=100&assetId=" .. config.Value
		
		local success,placeInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(config.Value) end)
		if success then
			name.Text = placeInfo.Name
		end
		
	end
end)




if config.Value <= 0 and owner and owner.Parent and owner:DistanceFromCharacter(board.Position) < 150 then --dont show if player has just entered the game
	workspace.Main.OpenAssetPicker:FireClient(owner,model,"Place")
end





function click(player)
	if player == owner then
		if Dialog:GetChoice(player,"Options","Do you want to teleport to this place or configure this portal?","Teleport","Configure") then
			game:GetService('TeleportService'):Teleport(config.Value, player)
		else
			workspace.Main.OpenAssetPicker:FireClient(owner,model,"Place")
		end
		
	else
		if Dialog:GetChoice(player,"Teleport?","Would you like to teleport to this game?","Teleport","Stay Here") then 
			game:GetService('TeleportService'):Teleport(config.Value, player)
		end
	end
end

model.Board.ClickDetector.MouseClick:connect(click)






