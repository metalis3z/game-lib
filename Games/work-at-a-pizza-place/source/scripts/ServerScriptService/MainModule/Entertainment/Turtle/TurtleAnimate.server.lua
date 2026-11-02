local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

local turtle = model.Turtle
local cframe = turtle.CFrame
local inCage = true
local Turtle = game.ServerScriptService:WaitForChild("TurtleMove",1)
function onMouseClick(player)
	if inCage then
		inCage = false
		takeOutOfCage()
	else
		inCage = true
		putInCage()
	end
end
model.ClickDetector.MouseClick:connect(onMouseClick)

function move(disabled)
	if disabled then
		if turtle:FindFirstChild("TurtleMove") then turtle.TurtleMove:Destroy() end
	else
		local mover = Turtle:clone()
		mover.Disabled = disabled
		mover.Parent = turtle
	end
	
end

function putInCage()
	last_kicked = 1000
	turtle.Anchored = true
	turtle.CFrame = cframe
	move(true)
	turtle.BodyGyro.maxTorque = Vector3.new(0,0,0)
	turtle.BodyVelocity.maxForce = Vector3.new(0,0,0)
	
end

function takeOutOfCage()
	last_kicked = 2
	turtle.Anchored = false
	turtle.CFrame = cframe + Vector3.new(0,3,0)
	move(false)
	
end


last_kicked = 1000
while true do
	wait(60)
	if last_kicked > 0 then
		last_kicked = last_kicked - 1
		if last_kicked == 0 then
			putInCage()
		end
	end
end