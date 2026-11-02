--[[
	Music Mute button (repurposed Satchel loader).

	The Satchel BACKPACK is intentionally NOT loaded here. This game already runs
	its own custom loot hotbar (RarityLootClient / IslandBrainrotClient) and the
	native Backpack GUI is disabled, so loading Satchel's backpack would just
	stack a second, duplicate backpack on top of it.

	Instead we reuse only the TopbarPlus icon library that ships inside the
	Satchel package to place a single Mute button on the RIGHT of the topbar,
	wired to the songs in SoundService.Music. TopbarPlus swaps the icon image
	automatically between its Deselected (music on) and Selected (muted) states.

	Mute is VOLUME-based (not Stop/Pause): MusicController loops the track and has
	a watchdog that immediately restarts any stopped/paused song, so the only way
	to silence it is Volume = 0. Unmute restores the music to UNMUTED_VOLUME.

	Satchel DevForum: https://devforum.roblox.com/t/2451549
	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0 (see the bundled Satchel module).
]]

local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

-- Icon images (music on / muted). These are the underlying IMAGE (texture) ids
-- resolved from the source decals 100440929449009 / 112945900095250 -- a raw
-- decal id does NOT load in a 2D ImageLabel, only its texture does.
local IMAGE_ON = "rbxassetid://88670216869914"
local IMAGE_OFF = "rbxassetid://77479202353787"

-- Volume the music is restored to when unmuted.
local UNMUTED_VOLUME = 0.5

-- Belt-and-suspenders: keep the native backpack off (the game already disables
-- it, but SetCoreGuiEnabled can lose early races on join).
task.spawn(function()
	for _ = 1, 10 do
		local ok = pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end)
		if ok then break end
		task.wait(0.5)
	end
end)

-- TopbarPlus icon library, bundled inside the Satchel package.
local Icon = require(script:WaitForChild("Satchel"):WaitForChild("Packages"):WaitForChild("topbarplus"))

local musicFolder = SoundService:WaitForChild("Music")

local function setMusicVolume(volume)
	for _, sound in ipairs(musicFolder:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Volume = volume
		end
	end
end

-- Single Mute toggle on the right side of the topbar. TopbarPlus shows the
-- Deselected image (music on) by default and the Selected image while muted.
local icon = Icon.new()
	:setName("MusicMute")
	:setImage(IMAGE_ON, "Deselected")
	:setImage(IMAGE_OFF, "Selected")
	:setImageScale(0.7)
	:setCaption("Music")
icon:align("Right") -- :align may not return the icon, so call it un-chained

icon.selected:Connect(function()
	setMusicVolume(0)
end)

icon.deselected:Connect(function()
	setMusicVolume(UNMUTED_VOLUME)
end)
