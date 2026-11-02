-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)

return function(p1, p2, p3) --[[ PatchReplicatedProps | Line: 15 | Upvalues: Asserts (copy), TableUtil (copy) ]]
	Asserts.optional.table(p2)
	Asserts.optional.string(p3)
	Asserts.optional.table(p1)

	return p3 and TableUtil.Reconcile(if p2 then p2 else {}, p1[p3]) or p2
end