local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local testing: boolean = script:GetAttribute("Testing")

local Janitor = require(script.Janitor)

local eye = script.Parent
local handle = eye.Parent
local tool = handle:FindFirstAncestorOfClass("Tool")
local floatOffset = Vector3.new(0, 0.1, 0)
local turnAngle = Vector3.new(0, 45, 0)
local floatTime = 0.45
local turnTime = 1.65

local spinInfo = TweenInfo.new(turnTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local maxIdleInterval = if testing then 10 else 40
local function waitIdleInterval(): number
	return task.wait(if testing then math.random(3, maxIdleInterval) else math.random(10, maxIdleInterval))
end

local function getOriginalEyeCFrame(): CFrame
	return handle.CFrame + Vector3.new(0, 2.55, 0)
end

local function quad(t: number)
	local a = 2
	local b = -1
	local c = 0
	return a * t * t + b * t + c
end

local janitor = Janitor.new()
janitor:LinkToInstance(script)

local equipped = false
janitor:Add(tool.Equipped:Connect(function()
	equipped = true
end))

janitor:Add(tool.Unequipped:Connect(function()
	equipped = false
end))

local goingDown = false
janitor:Add(RunService.Heartbeat:Connect(function(dt)
	if not equipped then return end
	
	local offset = floatOffset * floatTime * dt
	offset = Vector3.new(offset.X, quad(offset.Y), offset.Z)
	eye.Position +=  offset * (if goingDown then -1 else 1)	
	
	local diff = math.abs(eye.Position.Y - getOriginalEyeCFrame().Y)
	goingDown = if goingDown then diff < floatOffset.Y else diff >= floatOffset.Y
end))

-- do spinnies

local thread = task.spawn(function()
	while waitIdleInterval() do
		if not equipped then return end
		
		local spin = Tween:Create(eye, spinInfo, {
			Orientation = tool.Parent.PrimaryPart.Orientation + turnAngle
		})

		spin:Play()
		spin.Completed:Wait()
		task.wait(0.6)
		local spin2 = Tween:Create(eye, spinInfo, {
			Orientation = tool.Parent.PrimaryPart.Orientation - turnAngle
		})

		spin2:Play()
		spin2.Completed:Wait()
		task.wait(1)
		Tween:Create(eye, spinInfo, {
			Orientation = tool.Parent.PrimaryPart.Orientation
		}):Play()
	end
end)

janitor:Add(function()
	task.cancel(thread)
end)