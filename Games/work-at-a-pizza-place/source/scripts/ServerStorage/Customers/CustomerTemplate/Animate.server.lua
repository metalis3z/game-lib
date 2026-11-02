-- Now with exciting TeamColors HACK!
--[[script.Parent:WaitForChild("Torso")
script.Parent:WaitForChild("HumanoidRootPart")
script.Parent:WaitForChild("Right Leg")
script.Parent:WaitForChild("Left Leg")
script.Parent:WaitForChild("Left Arm")
script.Parent:WaitForChild("Right Arm")
script.Parent:WaitForChild("Head")

local sp = script.Parent
local torso = script.Parent.Torso


local nName = "Neck"
local n = Instance.new("Motor6D")
n.Name = nName
n.Part0 = torso
n.Part1 = sp["Head"]
n.C0 = script[nName].C0
n.C1 = script[nName].C1
n.MaxVelocity = 0.1
local nOld = torso:FindFirstChild(nName)
n.Parent = torso
if nOld ~= nil then nOld:Destroy() end


local jName = "RootJoint"
local j = Instance.new("Motor6D")
j.Name = jName
j.Part0 = sp.HumanoidRootPart
j.Part1 = sp["Torso"]
j.C0 = script[jName].C0
j.C1 = script[jName].C1
j.MaxVelocity = 0.1
local jOld = sp.HumanoidRootPart:FindFirstChild(jName)
j.Parent = sp.HumanoidRootPart
if jOld ~= nil then jOld:Destroy() end


local rsName = "Right Shoulder"
local rs = Instance.new("Motor6D")
rs.Name = rsName
rs.Part0 = torso
rs.Part1 = sp["Right Arm"]
rs.C0 = script[rsName].C0
rs.C1 = script[rsName].C1
rs.MaxVelocity = 0.1
local rsOld = torso:FindFirstChild(rsName)
rs.Parent = torso
if rsOld ~= nil then rsOld:Destroy() end


local lsName = "Left Shoulder"
local ls = Instance.new("Motor6D")
ls.Name = lsName
ls.Part0 = torso
ls.Part1 = sp["Left Arm"]
ls.C0 = script[lsName].C0
ls.C1 = script[lsName].C1
ls.MaxVelocity = 0.1
local lsOld = torso:FindFirstChild(lsName)
ls.Parent = torso
if lsOld ~= nil then lsOld:Destroy() end

local rhName = "Right Hip"
local rh = Instance.new("Motor6D")
rh.Name = rhName
rh.Part0 = torso
rh.Part1 = sp["Right Leg"]
rh.C0 = script[rhName].C0
rh.C1 = script[rhName].C1
rh.MaxVelocity = 0.1
local rhOld = torso:FindFirstChild(rhName)
rh.Parent = torso
if rhOld ~= nil then rhOld:Destroy() end
RightHip = rh

local lhName = "Left Hip"
local lh = Instance.new("Motor6D")
lh.Name = lhName
lh.Part0 = torso
lh.Part1 = sp["Left Leg"]
lh.C0 = script[lhName].C0
lh.C1 = script[lhName].C1
lh.MaxVelocity = 0.1
local lhOld = torso:FindFirstChild(lhName)
lh.Parent = torso
if lhOld ~= nil then lhOld:Destroy() end
local LeftHip = lh

script.Parent.Head:MakeJoints()

]]


function waitForChild(parent, childName)
	while true do
		local child = parent:findFirstChild(childName)
		if child then
			return child
		end
		parent.ChildAdded:wait()
	end
end


----------------------------- TEAM COLORS


----------------------------- ANIMATION

-- declarations

local Figure = script.Parent
local Torso = waitForChild(Figure, "Torso")

local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local isSeated = false

--[[RightShoulder:Destroy()

LeftShoulder:Destroy()

RightHip:Destroy()

LeftHip:Destroy()

Neck:Destroy()]]

-- functions

function onRunning(speed)
	if isSeated then return end

	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function onDied()
	pose = "Dead"
end

function onJumping()
	isSeated = false
	pose = "Jumping"
end

function onClimbing()
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	isSeated = true
	pose = "Seated"
	
end



function moveJump()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
	RightShoulder.DesiredAngle = 3.14
	LeftShoulder.DesiredAngle = -3.14
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end

function moveFreeFall()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
	RightShoulder.DesiredAngle = 1
	LeftShoulder.DesiredAngle = -1
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end


function moveClimb()
	RightShoulder.MaxVelocity = 0.5
	LeftShoulder.MaxVelocity = 0.5
	RightShoulder.DesiredAngle = -3.14
	LeftShoulder.DesiredAngle = 3.14
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end

function moveSit()
	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	RightShoulder.DesiredAngle = 3.14 /2
	LeftShoulder.DesiredAngle = -3.14 /2
	RightHip.DesiredAngle = 3.14 /2
	LeftHip.DesiredAngle = -3.14 /2
end

function getTool()
	
	kidTable = Figure:children()
	if (kidTable ~= nil) then
		numKids = #kidTable
		for i=1,numKids do
			if (kidTable[i].className == "Tool") then return kidTable[i] end
		end
	end
	
	return nil
end

function getToolAnim(tool)

	c = tool:children()
	for i=1,#c do
		if (c[i].Name == "toolanim" and c[i].className == "StringValue") then
			return c[i]
		end
	end
	return nil
end

function animateTool()
	
	if (toolAnim == "None") then
		RightShoulder.DesiredAngle = 1.57
		return
	end

	if (toolAnim == "Slash") then
		RightShoulder.MaxVelocity = 0.5
		RightShoulder.DesiredAngle = 0
		return
	end

	if (toolAnim == "Lunge") then
		RightShoulder.MaxVelocity = 0.5
		LeftShoulder.MaxVelocity = 0.5
		RightHip.MaxVelocity = 0.5
		LeftHip.MaxVelocity = 0.5
		RightShoulder.DesiredAngle = 1.57
		LeftShoulder.DesiredAngle = 1.0
		RightHip.DesiredAngle = 1.57
		LeftHip.DesiredAngle = 1.0
		return
	end
end

function move(time)
	local amplitude
	local frequency

	if (pose == "Jumping") then
		moveJump()
		return
	end

	if (pose == "FreeFall") then
		moveFreeFall()
		return
	end

	if (pose == "Climbing") then
		moveClimb()
		return
	end

	if (pose == "Seated") then
		moveSit()
		return
	end


	RightShoulder.MaxVelocity = 0.15
	LeftShoulder.MaxVelocity = 0.15
	if (pose == "Running" and script.Parent.Humanoid.WalkSpeed ~= 0) then
		amplitude = 1
		frequency = 9
	else
		amplitude = 0.1
		frequency = 1
	end

	desiredAngle = amplitude * math.sin(time*frequency)

	RightShoulder.DesiredAngle = desiredAngle
	LeftShoulder.DesiredAngle = desiredAngle
	RightHip.DesiredAngle = -desiredAngle
	LeftHip.DesiredAngle = -desiredAngle


	local tool = getTool()

	if tool ~= nil then
	
		animStringValueObject = getToolAnim(tool)

		if animStringValueObject ~= nil then
			toolAnim = animStringValueObject.Value
			-- message recieved, delete StringValue
			animStringValueObject.Parent = nil
			toolAnimTime = time + .3
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()

		
	else
		toolAnim = "None"
		toolAnimTime = 0
	end
end


-- connect events

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)

-- main program

local nextTime = 0
local runService = game:service("RunService");

while Figure.Parent~=nil do
	time = runService.Stepped:wait()
	if time > nextTime then
		move(time)
		nextTime = time + 0.1
	end
end
