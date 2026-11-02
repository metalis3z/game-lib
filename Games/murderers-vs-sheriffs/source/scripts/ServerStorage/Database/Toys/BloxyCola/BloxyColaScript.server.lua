local Tool = script.Parent
local enabled = true
local cooldown = false
local cooldownTime = 60 
local bonusJump = 12.5

function onActivated()
	if not enabled or cooldown then
		return
	end

	enabled = false
	cooldown = true

	local character = Tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		local originalWalkSpeed = humanoid.WalkSpeed
		local originalJumpPower = humanoid.JumpPower

		Tool.GripForward = Vector3.new(0,-.759,-.651)
		Tool.GripPos = Vector3.new(1.5,-.5,.3)
		Tool.GripRight = Vector3.new(1,0,0)
		Tool.GripUp = Vector3.new(0,.651,-.759)

		Tool.Handle.DrinkSound:Play()

		humanoid.WalkSpeed = 23.8
		humanoid.JumpPower = 62.5

		task.wait(3)

		if humanoid.MaxHealth > humanoid.Health + 5 then
			humanoid.Health = humanoid.Health + 5
		else	
			humanoid.Health = humanoid.MaxHealth
		end

		Tool.GripForward = Vector3.new(-.976,0,-0.217)
		Tool.GripPos = Vector3.new(0.03,0,0)
		Tool.GripRight = Vector3.new(.217,0,-.976)
		Tool.GripUp = Vector3.new(0,1,0)

		task.delay(6, function()
			if humanoid then
				humanoid.WalkSpeed = originalWalkSpeed
				humanoid.JumpPower = originalJumpPower
			end
		end)
	end

	enabled = true

	task.delay(cooldownTime, function()
		cooldown = false
	end)
end

function onEquipped()
	Tool.Handle.OpenSound:Play()
end

Tool.Activated:Connect(onActivated)
Tool.Equipped:Connect(onEquipped)
