local Workspace = game:GetService("Workspace")

local SOUND_ID = "rbxassetid://96591611478915"

-- Cree un Sound et le parente a la part
local function playSound(part)
	local sound = Instance.new("Sound")
	sound.SoundId = SOUND_ID
	sound.Volume = 1
	sound.Parent = part
	sound:Play()

	-- Supprime le Sound quand il termine pour eviter l'accumulation
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

local function onTouch(otherPart, keycapPart)
	local character = otherPart.Parent
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	playSound(keycapPart)
end

local function setupKeycap(part)
	if part:IsA("BasePart") and string.sub(string.lower(part.Name), 1, 7) == "keycap_" then
		-- Evite de connecter deux fois le meme part
		if part:GetAttribute("KeycapSoundConnected") then return end
		part:SetAttribute("KeycapSoundConnected", true)

		part.Touched:Connect(function(otherPart)
			onTouch(otherPart, part)
		end)
	end
end

-- Connecte tous les keycap_ existants
for _, descendant in Workspace:GetDescendants() do
	setupKeycap(descendant)
end

-- Connecte les keycap_ ajoutes pendant le jeu
Workspace.DescendantAdded:Connect(setupKeycap)-- KeycapSoundScript (SERVER-SIDE) - DISABLED
-- Keycap sounds are now handled entirely client-side by KeycapSoundManager (LocalScript)
-- This avoids creating 9,377+ Sound instances on the server and replicating them to all clients
--
-- The old system created one Sound instance per keycap on the server, causing:
--   - Massive server overhead (9,377 Sound instances)
--   - Network replication of all sound instances to every client
--   - All clients hearing every player's keycap sounds (unnecessary)
--
-- The new KeycapSoundManager (in StarterPlayerScripts) uses a single shared Sound instance
-- per client, so each player only hears their own keycap sounds with zero server overhead.

return