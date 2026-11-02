local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local player = house.Owner.Value

local candies = game.ServerStorage.Candy:GetChildren()


function click(clicker)
	if clicker == player then
		math.randomseed(tick())
		math.random()
		local newCandy = candies[math.random(1,5)]:clone()
		newCandy.Parent = clicker.Backpack
		
		local candyScript= game.ServerStorage.ToolScript:clone()
		candyScript.Disabled = false
		candyScript.Parent = newCandy.Handle
	end
end
model.ClickDetector.MouseClick:connect(click)