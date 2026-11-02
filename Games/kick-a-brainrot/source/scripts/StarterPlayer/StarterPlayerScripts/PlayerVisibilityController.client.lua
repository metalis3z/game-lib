--!strict
-- LOCATION: StarterPlayerScripts/PlayerVisibilityController

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("[PlayerVisibilityController] Initialized (Hiding Morphed Players)")

local function updateVisibility(player: Player)
	-- We don't want to hide ourselves; KickController already handles our local morph!
	if player == localPlayer then return end

	local isMorphed = player:GetAttribute("IsMorphed")
	local char = player.Character
	if not char then return end

	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			if isMorphed then
				if not part:GetAttribute("OriginalTransparency") then
					part:SetAttribute("OriginalTransparency", part.Transparency)
				end
				part.Transparency = 1
			else
				part.Transparency = part:GetAttribute("OriginalTransparency") or 0
			end
		elseif part:IsA("Decal") and part.Name == "face" then
			part.Transparency = isMorphed and 1 or 0
		elseif part:IsA("ParticleEmitter") or part:IsA("Trail") then
			if isMorphed then
				if part:GetAttribute("OriginalEnabled") == nil then
					part:SetAttribute("OriginalEnabled", part.Enabled)
				end
				part.Enabled = false
			else
				local orig = part:GetAttribute("OriginalEnabled")
				if orig ~= nil then part.Enabled = orig end
			end
		end
	end
end

local function onPlayerAdded(player: Player)
	-- Listen for when they morph/un-morph
	player:GetAttributeChangedSignal("IsMorphed"):Connect(function()
		updateVisibility(player)
	end)

	-- Handle if they respawn while we are watching
	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		updateVisibility(player)
	end)

	-- Handle if they already exist when we join the game
	if player.Character then
		updateVisibility(player)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, p in ipairs(Players:GetPlayers()) do
	onPlayerAdded(p)
end