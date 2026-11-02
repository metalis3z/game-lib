local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local LOW_GRAVITY = 50
local NORMAL_GRAVITY = 196.2

-- Continuously enforce gravity while the Shakira event is active
-- This overrides SpaceZoneClient which resets gravity to 196.2 on respawn
task.spawn(function()
	while true do
		task.wait(0.5)
		local active = ReplicatedStorage:GetAttribute("ShakiraEventActive")
		if active then
			workspace.Gravity = LOW_GRAVITY
		end
	end
end)