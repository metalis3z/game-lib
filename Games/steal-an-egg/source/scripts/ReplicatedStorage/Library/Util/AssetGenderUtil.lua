-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)

require(ReplicatedStorage.Library.Types.AssetItem)

local t = {
	IsGender = function(p1) --[[ IsGender | Line: 24 ]]
		return if p1 == "Male" then true else p1 == "Female"
	end,
	Roll = function(p1) --[[ Roll | Line: 28 ]]
		if (if p1 then p1 else Random.new()):NextInteger(1, 2) == 1 then
			return "Male"
		end

		return "Female"
	end
}

function t.ResolveForCategory(p1, p2, p3) --[[ ResolveForCategory | Line: 37 | Upvalues: t (copy), Assets (copy) ]]
	if t.IsGender(p2) then
		return p2
	end

	local GenderLocked = Assets.Directory[p1].GenderLocked

	if t.IsGender(GenderLocked) then
		return GenderLocked
	end

	return t.Roll(p3)
end
function t.GetIcon(p1) --[[ GetIcon | Line: 51 ]]
	if p1 == "Male" then
		return "rbxassetid://88627876961976"
	end

	return "rbxassetid://98782480225988"
end

return t