local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

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
		game.ServerStorage.Gear.Popcorn:clone().Parent = player.Backpack
	end	
end
model.ClickDetector.MouseClick:connect(onMouseClick)
