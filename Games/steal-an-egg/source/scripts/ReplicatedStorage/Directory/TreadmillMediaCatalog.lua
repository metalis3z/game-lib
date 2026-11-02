-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	BASELINE_RELEASE_VERSION = 1,
	BASELINE_MEDIA_COUNT = 246,
	CURRENT_RELEASE_VERSION = 2
}

function t.ResolveEntryReleaseVersion(p1) --[[ ResolveEntryReleaseVersion | Line: 20 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.positiveInteger(p1)
	assert(p1 <= t.CURRENT_RELEASE_VERSION, (("Treadmill media release %* exceeds current release %*"):format(p1, t.CURRENT_RELEASE_VERSION)))

	return p1
end

return t