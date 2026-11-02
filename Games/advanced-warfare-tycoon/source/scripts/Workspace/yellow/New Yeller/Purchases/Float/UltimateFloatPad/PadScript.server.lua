function waitForChild(instance, name)
	while not instance:FindFirstChild(name) do
		instance.ChildAdded:wait()
	end
end

local pad = script.Parent
waitForChild(pad, "Base")
waitForChild(pad, "FakeBase")
waitForChild(pad, "Configuration")
waitForChild(pad.Configuration, "Height")
waitForChild(pad.Configuration, "Speed")
waitForChild(pad, "UpFacingWedge")

local base = pad.Base
local base2 = pad.FakeBase
local height = pad.Configuration.Height
local speed = pad.Configuration.Speed

local debris = game:GetService("Debris")
local r = game:GetService("RunService")

local airDir = pad.UpFacingWedge.CFrame.lookVector

-- animation variables
local continueAnimation = false

waitForChild(base, "Fire")
waitForChild(base, "Smoke")

local onColor = BrickColor.new("Toothpaste")
local offColor = BrickColor.new("Really blue")


function truncate(value)
	if value < .5 then return 0
	else return 1 end
end

function zeroOut(value)
	if math.abs(value) < .01 then return 0
	else return 1 end
end

local dX = Vector3.new(0,0,0)
local dY = base.CFrame.lookVector
local truncatedAirDir = Vector3.new(zeroOut(airDir.X), zeroOut(airDir.Y), zeroOut(airDir.Z))
function updateAirDirection()
	airDir = pad.UpFacingWedge.CFrame.lookVector
	dY = base.CFrame.lookVector -- we assume when upFacingWedge changes, so too does base
	dX = airDir:Cross(dY)
	truncatedAirDir = Vector3.new(zeroOut(airDir.X), zeroOut(airDir.Y), zeroOut(airDir.Z))
end

local debounce = false
function touchHandler(part)
	if part == nil then return end
	if part.Anchored then return end
	while debounce do wait() end
	if(part.Parent:FindFirstChild("Humanoid") ~= nil) then
		-- If part is the arm or leg of a humanoid, then move everything to the torso.
		-- This is so we can't double up forces on a humanoid (scripts inside each leg, arm, etc)
		waitForChild(part.Parent, "Torso")
		part = part.Parent.Torso
	end

	-- below case necessary for hats and tools (don't want to float them separately)
	if (part.Parent.Parent ~= nil and part.Parent.Parent:FindFirstChild("Humanoid") ~= nil) then
		waitForChild(part.Parent.Parent, "Torso")
		part = part.Parent.Parent.Torso
	end

	debounce = true

	local newBV = part:FindFirstChild("FloatMe")

	if newBV ~= nil then
		if math.abs(newBV.velocity:Dot(airDir)) > speed.ConstrainedValue then debounce = false return end

		newBV.velocity = speed.ConstrainedValue*airDir + newBV.velocity - newBV.velocity:Dot(airDir)*airDir
		newBV.maxForce = truncatedAirDir*Vector3.new(newBV.P, newBV.P, newBV.P)
	else
		-- make new float force
		newBV = Instance.new("BodyVelocity")
		newBV.Name = "FloatMe"
		newBV.P = 100000

		newBV.velocity = speed.ConstrainedValue * airDir
		newBV.maxForce = truncatedAirDir*Vector3.new(newBV.P, newBV.P, newBV.P)

		newBV.Parent = part
		debris:AddItem(newBV, .5) -- force disappears after .5 seconds
	end

	continueAnimation = true
	debounce = false
end

-- to use the region3 or raycast code, unfortunately, we still have to poll
pad.UpFacingWedge.Changed:connect(updateAirDirection)

local lastOn = 0
local curTime = 0
local wasOn = false

local baseSize = base.Size.X / 6 -- we assume square base, and want to travel 1/6 from the center, so we divide region into 3rds

while true do		
	continueAnimation = false
	currTime = r.Stepped:wait()  -- serves as the loop wait; want this to be as fast as possible

	-- pass up to 4 parts (first parts caught by the rays) to our touchHandler every polling period
	for xStep = -1, 1, 2 do
		for yStep = -1, 1, 2 do
			touchHandler(game.Workspace:FindPartOnRay(Ray.new(base.Position + xStep * dX * baseSize + yStep * dY * baseSize , height.ConstrainedValue * airDir), pad))
		end
	end

	if continueAnimation then 
		base.BrickColor = onColor
		base.Fire.Enabled = true
		base.Smoke.Enabled = true
		lastOn = currTime
		wasOn = true
	else
		base.Fire.Enabled = false
		--wait(0.5)
		-- only shut off smoke and change brick color if it's been at least .5 seconds since blast pad was active
		if currTime - lastOn > .5 and wasOn then
			base.Smoke.Enabled = false
			base.BrickColor = offColor
			wasOn = false
		end
	end
end
