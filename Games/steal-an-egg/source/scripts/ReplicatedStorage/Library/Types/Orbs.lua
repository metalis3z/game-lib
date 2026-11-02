-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Currency = require(ReplicatedStorage.Library.Types.Currency)
local t2 = {
	DespawnTime = 300,
	Types = {
		Orb = 1
	},
	OrbTypesInverse = { Currency.AllCurrencyTypes.Money },
	OrbTypes = {},
	SchemaValidation = {
		OrbSpec = t.interface({
			Type = t.optional(t.number),
			Index = t.optional(t.number),
			PickupDelay = t.optional(t.number)
		}),
		AllOrbTypes = t.union(t.literal(Currency.AllCurrencyTypes.Money))
	}
}

for v1, v2 in t2.OrbTypesInverse do
	t2.OrbTypes[v2] = v1
end

return t2