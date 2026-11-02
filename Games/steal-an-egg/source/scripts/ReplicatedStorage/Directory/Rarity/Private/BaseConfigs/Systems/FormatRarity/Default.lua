-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 8 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)

	return function(p12) --[[ Line: 11 | Upvalues: Asserts (ref), p1 (copy) ]]
		Asserts.optional.string(p12)

		local v1

		if p12 then
			local v2 = ("%*: "):format(p12)

			v1 = if v2 then v2 else ""
		else
			v1 = ""
		end

		return v1 .. p1
	end
end