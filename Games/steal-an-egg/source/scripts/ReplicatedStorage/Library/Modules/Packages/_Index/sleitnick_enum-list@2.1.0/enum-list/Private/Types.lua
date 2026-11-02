-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	_cloneParams = t.tuple(t.optional(t.string), t.optional(t.table)),
	_basicParams = t.tuple(t.string, t.table),
	_complexStruct = t.interface({
		Position = t.number,
		Name = t.optional(t.any),
		Value = t.any
	})
}

function t2._currentEnum(p1, p2) --[[ Line: 44 | Upvalues: t (copy), t2 (copy) ]]
	if typeof(p1) == "table" then
		return t2._complexStruct(p1)
	end

	return t.tuple(t.any(p1), t.number(p2))
end
t2.EnumItem = t.strictInterface({
	Name = t.any,
	Value = t.any,
	Position = t.number,
	EnumType = t.any,
	Id = t.optional(t.string)
})

return t2