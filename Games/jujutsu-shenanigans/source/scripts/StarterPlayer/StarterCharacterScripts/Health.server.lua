-- Gradually regenerates the Humanoid's Health over time.

local REGEN_RATE = 1 -- Regenerate this fraction of MaxHealth per second.
local REGEN_STEP = 4 -- Wait this long between each regeneration step.

--------------------------------------------------------------------------------

local Character: Model = script.Parent
local Humanoid: Humanoid = Character:WaitForChild'Humanoid'

--------------------------------------------------------------------------------

local function AddDeadStatus()
	local Status = Instance.new('BoolValue')
	Status.Name = 'Dead'
	Status.Value = true
	Status.Parent = Character
end

--------------------------------------------------------------------------------

local Past = 0
local HealC: RBXScriptConnection

HealC = game["Run Service"].Heartbeat:Connect(function(deltaTime)
	Past += deltaTime

	if ((Past >= REGEN_STEP) or (deltaTime >= REGEN_STEP)) and Humanoid.Health < Humanoid.MaxHealth and not Character:HasTag('Stunned') then
		Past = 0

		if Humanoid.Health <= 0 then
			HealC:Disconnect()

			AddDeadStatus()

			return
		else
			Humanoid.Health += REGEN_RATE
		end
	end
end)

Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
	if Humanoid.Health <= 0 then
		HealC:Disconnect()

		AddDeadStatus()
	end
end)