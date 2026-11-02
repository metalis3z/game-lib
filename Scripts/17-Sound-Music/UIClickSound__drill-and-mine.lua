-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: StarterPlayer/StarterPlayerScripts/UIClickSound.client.luau  (client, 62 lines)
-- Categories: sound-music 11.2, loading-screen 10.0, notifications 9.0
-- What it does: Global UI click sound: hooks every GuiButton in PlayerGui (now and later, via DescendantAdded) plus every ProximityPrompt trigger, preloads the sound, and plays a short-lived clone.

-- Global UI click SFX: plays a quiet click on EVERY GuiButton press across the
-- whole game (current + future buttons), via PlayerGui.DescendantAdded.
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local ContentProvider = game:GetService("ContentProvider")
local ProximityPromptService = game:GetService("ProximityPromptService")

-- Custom click sound removed -- waiting on the final in-game asset ID. Put the
-- real "rbxassetid://..." here and every button click plays it again. The
-- button-hook system stays wired; empty = silent, no errors.
local CLICK_SOUND_ID = "rbxassetid://72297116609623"
local CLICK_VOLUME = 0.3

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Preloaded template (created now so the asset is cached before first click).
local template = Instance.new("Sound")
template.SoundId = CLICK_SOUND_ID
template.Volume = CLICK_VOLUME
template.Parent = SoundService
task.spawn(function()
	pcall(function()
		ContentProvider:PreloadAsync({ template })
	end)
end)

local function playClick()
	if CLICK_SOUND_ID == "" then
		return
	end
	local s = template:Clone()
	s.Parent = SoundService
	s:Play()
	s.Ended:Once(function()
		s:Destroy()
	end)
	task.delay(4, function()
		if s and s.Parent then
			s:Destroy()
		end
	end)
end

local function hook(inst)
	if inst:IsA("GuiButton") and not inst:GetAttribute("_ClickSoundHooked") then
		inst:SetAttribute("_ClickSoundHooked", true)
		inst.Activated:Connect(playClick)
	end
end

for _, d in ipairs(playerGui:GetDescendants()) do
	hook(d)
end
playerGui.DescendantAdded:Connect(hook)

-- proximity prompts (E interactions) pop the same click as UI buttons;
-- the service-level signal also covers prompts created at runtime
ProximityPromptService.PromptTriggered:Connect(function()
	playClick()
end)
