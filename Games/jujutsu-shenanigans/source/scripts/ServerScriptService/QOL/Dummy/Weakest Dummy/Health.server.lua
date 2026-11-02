-- Gradually regenerates the Humanoid's Health over time.

local REGEN_RATE = 1 -- Regenerate this fraction of MaxHealth per second.
local REGEN_STEP = 2 -- Wait this long between each regeneration step.

--------------------------------------------------------------------------------

local Character: Model = script.Parent
local Humanoid: Humanoid = Character:WaitForChild'Humanoid'

--------------------------------------------------------------------------------

local HasBeen0 = false
local Past = 0

game["Run Service"].Heartbeat:Connect(function(deltaTime)
	Past += deltaTime
	
	if ((Past >= REGEN_STEP) or deltaTime > REGEN_STEP) and Humanoid.Health < Humanoid.MaxHealth and not Character:HasTag('Stunned') and HasBeen0 == false then
		Past = 0
		
		if Humanoid.Health <= 0 then
			HasBeen0 = true
			
			return
		end
		
		Humanoid.Health += REGEN_RATE
	end
end)

Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
	if Humanoid.Health <= 0 then
		HasBeen0 = true
	end
end)