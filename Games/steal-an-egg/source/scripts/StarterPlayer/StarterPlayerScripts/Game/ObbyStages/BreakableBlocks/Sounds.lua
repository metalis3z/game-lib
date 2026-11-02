-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local CrackTemplate = Instance.new("Sound")

CrackTemplate.SoundId = "rbxassetid://84155768909514"
CrackTemplate.Volume = 0.05
CrackTemplate.Name = "CrackTemplate"

local ShatterTemplate = Instance.new("Sound")

ShatterTemplate.SoundId = "rbxassetid://89998269803036"
ShatterTemplate.Volume = 0.05
ShatterTemplate.Name = "ShatterTemplate"

local FreezeSFX = Instance.new("Sound")

FreezeSFX.SoundId = "rbxassetid://91367338760317"
FreezeSFX.Volume = 1.5
FreezeSFX.Name = "FreezeSFX"

local ThawSFX = Instance.new("Sound")

ThawSFX.SoundId = "rbxassetid://91367338760317"
ThawSFX.Volume = 0.6
ThawSFX.PlaybackSpeed = 0.7
ThawSFX.Name = "ThawSFX"

local t = {
	_play = function(p1, p2) --[[ _play | Line: 36 | Upvalues: SoundService (copy), Debris (copy) ]]
		local v1 = p1:Clone()

		if p2 then
			v1.PlaybackSpeed = p2
		end

		v1.Parent = SoundService
		v1:Play()
		Debris:AddItem(v1, v1.TimeLength + 0.1)

		return v1
	end
}

function t.PlayCrack(p1) --[[ PlayCrack | Line: 53 | Upvalues: t (copy), CrackTemplate (copy) ]]
	return t._play(CrackTemplate, p1)
end
function t.PlayShatter(p1) --[[ PlayShatter | Line: 57 | Upvalues: t (copy), ShatterTemplate (copy) ]]
	return t._play(ShatterTemplate, p1)
end
function t.PlayFreeze() --[[ PlayFreeze | Line: 61 | Upvalues: t (copy), FreezeSFX (copy) ]]
	return t._play(FreezeSFX, nil)
end
function t.PlayThaw() --[[ PlayThaw | Line: 65 | Upvalues: t (copy), ThawSFX (copy) ]]
	return t._play(ThawSFX, nil)
end

return t