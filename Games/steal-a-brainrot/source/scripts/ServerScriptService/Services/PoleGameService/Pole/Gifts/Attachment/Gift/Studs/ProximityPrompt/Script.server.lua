-- IMPORTANT: This must be a regular 'Script', not a 'LocalScript'.
-- The server needs to handle the destruction of world objects so all players see the change.

local proximityPrompt = script.Parent
-- 'proximityPrompt' is the ProximityPrompt object the script is inside.

-- Find the target Attachment. Based on your hierarchy:
-- script.Parent (ProximityPrompt) -> Studs -> Gift -> Attachment (the target)
-- Using FindFirstAncestor is the safest way to grab the target object.
local targetAttachment = proximityPrompt:FindFirstAncestor("Attachment")

-- Add a safety check to make sure the target was found
if not targetAttachment then
	warn("Could not find the 'Attachment' ancestor. Check the object hierarchy.")
	return
end

-- Connect the Triggered event, which fires when a player activates the prompt
proximityPrompt.Triggered:Connect(function(playerWhoTriggered)

	-- Disconnect the Triggered event immediately so it can't be triggered again
	-- before the object is destroyed.
	proximityPrompt.Enabled = false 

	-- Destroy the Attachment. This will also destroy the ProximityPrompt, Studs, and Gift.
	targetAttachment:Destroy()

	-- We print the name of the player who triggered it for debugging purposes
	print(playerWhoTriggered.Name .. " triggered the prompt and destroyed the Attachment.")
end)