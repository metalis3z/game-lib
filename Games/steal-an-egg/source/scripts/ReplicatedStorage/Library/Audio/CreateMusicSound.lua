-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ParseAssetId = require(ReplicatedStorage.Library.Functions.ParseAssetId)

return function(p1, p2, p3) --[[ Line: 20 | Upvalues: ParseAssetId (copy), SoundService (copy) ]]
	local v1 = if type(p2) == "string" then ParseAssetId(p2) else p2

	assert(if type(v1) == "number" then true else false, "Music sound id must resolve to a number")
	assert(if v1 > 0 then true else false, "Music sound id must be greater than 0")

	local Music = script.Parent.Music

	assert(Music:IsA("Folder"), "Expected Audio.Music folder")

	local Music2 = SoundService.Music

	assert(Music2:IsA("SoundGroup"), "Expected SoundService.Music sound group")

	local Sound = Instance.new("Sound")

	Sound.Name = p1
	Sound.SoundId = ("rbxassetid://%d"):format(v1)
	Sound.Volume = 0
	Sound.Looped = p3
	Sound.SoundGroup = Music2
	Sound.Parent = Music

	return Sound
end