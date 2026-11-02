local tool = script.Parent
local lastCharacter = nil
local smokepart = nil
local unequipConnection = nil

local function onUnequipped()
	if lastCharacter then
		lastCharacter.Humanoid.WalkSpeed = 16
	end
	if smokepart then
		smokepart:Destroy()
	end
	if unequipConnection then
		unequipConnection:disconnect()
	end
end

local function onEquipped()
	local character = tool.Parent
	
	unequipConnection = character.DescendantRemoving:connect(function(desc)
		if desc == tool then
			onUnequipped()
		end
	end)		
	
	lastCharacter = character
	character.Humanoid.WalkSpeed = 21
	local humanoid = character:FindFirstChild("Humanoid")
	local torso = character:FindFirstChild("Torso")
	if torso then
		smokepart = Instance.new("Part")
		smokepart.Size = Vector3.new(0,0,0)
		smokepart.CanCollide = false
		smokepart.Transparency = 1
		local weld=Instance.new("Weld")
		weld.Name = "SmokePartWeld"
		weld.Part0 = torso
		weld.Part1 = smokepart
		weld.C0 = CFrame.new(0, -3.5, 0) * CFrame.Angles(math.pi/4, 0, 0)
		weld.Parent = smokepart
		smokepart.Parent = character
		smoke = Instance.new("Smoke")
		smoke.Enabled = torso.Velocity.magnitude > SPEED_FOR_SMOKE
		smoke.RiseVelocity = 2
		smoke.Opacity = 0.25
		smoke.Size = 0.5
		smoke.Parent = smokepart
		humanoid.Running:connect(function(speed)
			if smoke and smoke~=nil then
				smoke.Enabled=speed > SPEED_FOR_SMOKE
			end
		end)	
	end
	
end

tool.Equipped:connect(onEquipped)