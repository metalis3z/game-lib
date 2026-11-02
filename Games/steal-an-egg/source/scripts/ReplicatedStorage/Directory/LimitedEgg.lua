-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script.Types.Interface)

local v1 = table.freeze({
	table.freeze({ "Tung Tung Sahur", 39 }),
	table.freeze({ "Bananita Dolphinita", 25 }),
	table.freeze({ "Belula Beluga", 20 }),
	table.freeze({ "Mangolini Parrochini", 10 }),
	table.freeze({ "Bomboclat Crocolat", 5 }),
	table.freeze({ "Strawberry Elephant", 1 })
})

assert(#v1 == 6, "Limited egg presentation requires exactly six drop entries")

local t = {}

for i, v in ipairs(v1) do
	local v3 = v[1]
	local v4 = v[2]

	Asserts.string(v3)
	Asserts.number(v4)
	assert(if v4 > 0 then true else false, (("Limited egg drop entry %* requires positive weight"):format(i)))
	table.insert(t, table.freeze({
		AssetId = v3,
		Weight = v4
	}))
end

return table.freeze({
	DropTable = v1,
	Entries = table.freeze(t),
	Offers = table.freeze({
		table.freeze({
			Amount = 1,
			ProductName = "Limited Egg"
		}),
		table.freeze({
			Amount = 3,
			ProductName = "Limited Egg x3"
		}),
		table.freeze({
			Amount = 10,
			ProductName = "Limited Egg x10"
		}),
		table.freeze({
			Amount = 50,
			ProductName = "Limited Egg x50"
		})
	})
})