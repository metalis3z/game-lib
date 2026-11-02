--!strict
-- LOCATION: ServerScriptService/BrainrotCollision
-- Safety net: ensures equipped brainrot tools never collide with the player's body.
-- This prevents the player from sinking into the ground while holding a brainrot.

local Players = game:GetService("Players")

local function isBrainrotTool(tool: Instance): boolean
	if not tool:IsA("Tool") then return false end
	-- Brainrot tools are tagged with the BrainrotName attribute by ItemManager
	return tool:GetAttribute("BrainrotName") ~= nil
end

local function fixBrainrotCollision(tool: Instance)
	if not isBrainrotTool(tool) then return end

	for _, part in ipairs(tool:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end

	-- Remove any internal Humanoid so it can't try to control the player's body
	-- while the brainrot is held (this caused sinking and movement slowdown).
	-- The Humanoid is nested inside the inner Model, so scan all descendants.
	for _, d in ipairs(tool:GetDescendants()) do
		if d:IsA("Humanoid") then
			d:Destroy()
		end
	end

	-- Remove Motor6D joints that conflict with the welds applied on equip.
	for _, m in ipairs(tool:GetDescendants()) do
		if m:IsA("Motor6D") then
			m:Destroy()
		end
	end
end

local function setupCharacter(character: Model)
	-- Fix tools already equipped when the character loads
	for _, child in ipairs(character:GetChildren()) do
		if child:IsA("Tool") then
			fixBrainrotCollision(child)
		end
	end

	-- Fix tools equipped later (moved from Backpack to Character)
	character.DescendantAdded:Connect(function(desc)
		if desc:IsA("Tool") then
			fixBrainrotCollision(desc)
		end
	end)
end

local function onPlayerAdded(player: Player)
	player.CharacterAdded:Connect(setupCharacter)
	if player.Character then
		setupCharacter(player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

print("[BrainrotCollision] Loaded - brainrot tools forced non-collidable when equipped.")