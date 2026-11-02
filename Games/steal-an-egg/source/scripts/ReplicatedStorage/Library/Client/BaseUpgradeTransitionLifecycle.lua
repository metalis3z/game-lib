-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local v1 = false
local t = {
	Completed = Signal.new(),
	Begin = function() --[[ Begin | Line: 20 | Upvalues: v1 (ref) ]]
		assert(not v1, "Base upgrade transition is already playing")
		v1 = true
	end
}

function t.Complete() --[[ Complete | Line: 25 | Upvalues: v1 (ref), t (copy) ]]
	assert(v1, "Base upgrade transition must be playing before completion")
	v1 = false
	t.Completed:Fire()
end
function t.IsPlaying() --[[ IsPlaying | Line: 31 | Upvalues: v1 (ref) ]]
	return v1
end

return t