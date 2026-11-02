local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

local snake = model.Snake
local cframe = snake.CFrame
local inCage = true
local Snake = game.ServerScriptService:WaitForChild("SnakeMove",1)
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
		if snake:FindFirstChild("SnakeMove") then snake.SnakeMove:Destroy() end
	else
		local mover = Snake:clone()
		mover.Disabled = disabled
		mover.Parent = snake
	end
end

function putInCage()
	last_kicked = 1000
	snake.Anchored = true
	snake.CFrame = cframe
	move(true)
	snake.BodyGyro.maxTorque = Vector3.new(0,0,0)
	snake.BodyVelocity.maxForce = Vector3.new(0,0,0)
	
end

function takeOutOfCage()
	last_kicked = 2
	snake.Anchored = false
	snake.CFrame = cframe + Vector3.new(0,4,0)
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