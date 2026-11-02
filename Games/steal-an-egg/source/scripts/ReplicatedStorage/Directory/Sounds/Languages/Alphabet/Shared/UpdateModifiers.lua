-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Interface = require(script.Parent.Parent.Types.Interface)
local v1 = require(script.Parent.Parent)

return function(p1, p2) --[[ Line: 10 | Upvalues: Interface (copy), v1 (copy), Asserts (copy) ]]
	assert(Interface.UpdateModifiers(p1, p2))

	local v12 = if typeof(p1) == "string" then v1[p1] else p1

	Asserts.table(v12)

	for v2, v3 in p2 do
		local v6 = assert(v12[v2], (("Letter \"%*\" does not exist in the alphabet container"):format(v2)))

		for v7, v8 in v6.Modifiers do
			v8.Parent = nil
		end

		for v9, v10 in v3 do
			v10.Parent = v6.Sound
		end
	end

	return v12
end