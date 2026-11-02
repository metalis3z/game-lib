local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

local pony = model.Handle
local seat = model.Seat
local cframe = pony.CFrame
local cframe2 =seat.CFrame
local inCage = true
local PonyMove = game.ServerScriptService:WaitForChild("PonyMove",1)

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
	if not disabled then
		model.Bar1.Transparency = 1
		model.Bar2.Transparency = 1	
		local mover = PonyMove:clone()
		mover.Disabled = disabled
		mover.Parent = pony
	else
		model.Bar1.Transparency = 0
		model.Bar2.Transparency = 0
		if pony:FindFirstChild("PonyMove") then pony.PonyMove:Destroy() end

	end
	
	
end

function putInCage()
	last_kicked = 1000
	pony.Anchored = true
	seat.Anchored = true
	pony.CFrame = cframe
	seat.CFrame = cframe2
	move(true)
	pony.BodyGyro.maxTorque = Vector3.new(0,0,0)
	pony.BodyVelocity.maxForce = Vector3.new(0,0,0)
	
end

function takeOutOfCage()
	last_kicked = 2
	pony.Anchored = false
	seat.Anchored = false
	--pony.CFrame = cframe + Vector3.new(0,4,0)
	move(false)
	
end


last_kicked = 1000
putInCage()
while true do
	wait(60)
	if last_kicked > 0 then
		last_kicked = last_kicked - 1
		if last_kicked == 0 then
			putInCage()
		end
	end
end