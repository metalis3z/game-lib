-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()

return function(p1, p2) --[[ Line: 10 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.table(p1)

	for k, v in pairs(p1) do
		if typeof(v) == "table" then
			if not table.isfrozen(v) then
				v._id = k
			end

			if p2 and not table.isfrozen(v) then
				table.freeze(v)
			end

			continue
		end

		v1:AtWarning():Log((("Invalid value for \'%*\' when loading dir"):format(k)))
	end

	return p1
end