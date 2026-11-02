-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Client = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client")
local SettingsCmds = require(Client.SettingsCmds)
local Default = SoundService:WaitForChild("Default")
local DefaultReverb = SoundService:WaitForChild("DefaultReverb")
local Music = SoundService:WaitForChild("Music")
local Volume = Default.Volume
local Volume2 = DefaultReverb.Volume
local Volume3 = Music.Volume

local function applySfx(p1) --[[ applySfx | Line: 22 | Upvalues: Default (copy), Volume (copy), DefaultReverb (copy), Volume2 (copy) ]]
	Default.Volume = if p1 then Volume or 0 else 0
	DefaultReverb.Volume = if p1 then Volume2 or 0 else 0
end

local function applyMusic(p1) --[[ applyMusic | Line: 27 | Upvalues: Music (copy), Volume3 (copy) ]]
	Music.Volume = if p1 then Volume3 or 0 else 0
end

local function applyAll() --[[ applyAll | Line: 31 | Upvalues: SettingsCmds (copy), Default (copy), Volume (copy), DefaultReverb (copy), Volume2 (copy), Music (copy), Volume3 (copy) ]]
	local v1 = SettingsCmds.IsEnabled("SFX")

	Default.Volume = if v1 then Volume or 0 else 0
	DefaultReverb.Volume = if v1 then Volume2 or 0 else 0
	Music.Volume = if SettingsCmds.IsEnabled("Music") then Volume3 or 0 else 0
end

SettingsCmds.Changed:Connect(function(p1, p2) --[[ Line: 37 | Upvalues: Default (copy), Volume (copy), DefaultReverb (copy), Volume2 (copy), Music (copy), Volume3 (copy) ]]
	if p1 == "SFX" then
		local v1 = p2 ~= false

		Default.Volume = if v1 then Volume or 0 else 0
		DefaultReverb.Volume = if v1 then Volume2 or 0 else 0
	else
		if p1 ~= "Music" then
			return
		end

		Music.Volume = if p2 ~= false then Volume3 or 0 else 0
	end
end)

local v1 = SettingsCmds.IsEnabled("SFX")

Default.Volume = if v1 and Volume then Volume else 0
DefaultReverb.Volume = if v1 and Volume2 then Volume2 else 0
Music.Volume = if SettingsCmds.IsEnabled("Music") and Volume3 then Volume3 else 0