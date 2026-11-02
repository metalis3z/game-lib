local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

local debounce = false
function onMouseClick(player)
	if debounce then return end
	debounce = true
	local gum = model.Gumball:clone()
	gum.Anchored = false
	gum.CanCollide = true
	gum.CFrame = model.Hole.CFrame
	gum.Velocity = model.Hole.CFrame.lookVector*-math.random(6,10)
	gum.BrickColor = BrickColor.new(Color3.new(math.random(1,255)/255,math.random(1,255)/255,math.random(1,255)/255))
	gum.Parent = model
	wait(0.1)
	debounce = false
	wait(2)
	gum:Destroy()
end
model.ClickDetector.MouseClick:connect(onMouseClick)
