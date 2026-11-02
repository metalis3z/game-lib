local detector = script.Parent

function findFood(player)
	for _,i in ipairs(player.Backpack:GetChildren()) do
		if i:FindFirstChild("Food") ~= nil then
			return true
		end
	end
	return false
end

function onMouseClick(player)
	if not findFood(player) then
		local turk = game.ServerStorage.Gear.TurkeyLeg:clone()
		turk.Parent = player.Backpack
		if player.Character ~= nil and player.Character:FindFirstChild("Humanoid") ~= nil then
			player.Character.Humanoid:EquipTool(turk)
		end
		
	end	
end
detector.Detector.Event:connect(onMouseClick)
