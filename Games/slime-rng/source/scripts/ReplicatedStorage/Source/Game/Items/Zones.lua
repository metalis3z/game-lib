-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Zones, time of decompilation: Sun May  3 10:12:42 2026 ]]
local t1 = {
	[1] = {
		name = "Grasslands",
		price = 0,
		enemies = { 1 }
	},
	[2] = {
		name = "Desert",
		price = 400,
		enemies = { 2 }
	},
	[3] = {
		name = "Polar",
		price = 5000,
		enemies = { 3 }
	},
	[4] = {
		name = "Volcano",
		price = 50000,
		enemies = { 4 }
	},
	[5] = {
		name = "Islands",
		price = 400000,
		enemies = { 5 }
	},
	[6] = {
		name = "Cave",
		price = 2000000,
		enemies = { 6 }
	},
	[7] = {
		name = "Heaven",
		price = 12000000,
		enemies = { 7 }
	},
	[8] = {
		name = "Jungle",
		price = 54000000,
		enemies = { 8 }
	},
	[9] = {
		name = "Canyon",
		price = 216000000,
		enemies = { 9 }
	},
	[10] = {
		name = "Mushroom Forest",
		price = 936000000,
		enemies = { 10 }
	},
	[11] = {
		name = "Moon",
		price = 3800000000,
		enemies = { 11 }
	},
	[12] = {
		name = "Redwood Forest",
		price = 15600000000,
		enemies = { 12 }
	},
	[13] = {
		name = "Meteor",
		price = 75000000000,
		enemies = { 13 }
	},
	[14] = {
		name = "Candyland",
		price = 250000000000,
		enemies = { 14 }
	},
	[15] = {
		name = "Cherry Grove",
		price = 1000000000000,
		enemies = { 15 }
	},
	[16] = {
		name = "Crystal Cavern",
		price = 3500000000000,
		enemies = { 16 }
	},
	[17] = {
		name = "Pumpkin Patch",
		price = 11000000000000,
		enemies = { 17 }
	},
	[18] = {
		name = "Atlantis",
		price = 31000000000000,
		enemies = { 18 }
	},
	[19] = {
		name = "River",
		price = 94000000000000,
		enemies = { 19 }
	},
	[20] = {
		name = "Pyramids",
		price = 282000000000000,
		enemies = { 20 }
	},
	[21] = {
		name = "Graveyard",
		price = 846000000000000,
		enemies = { 21 }
	},
	[22] = {
		name = "Hot Springs",
		price = 2500000000000000,
		enemies = { 22 }
	},
	[23] = {
		name = "Tribe",
		price = 8000000000000000,
		enemies = { 23 }
	},
	[24] = {
		name = "Toxic Wasteland",
		price = 26000000000000000,
		enemies = { 24 }
	},
	[25] = {
		name = "Steampunk",
		price = 80000000000000000,
		enemies = { 25 }
	}
}

return {
	getZone = function(n1: number) --[[ getZone ]] -- line: 161
		-- upvalues: t1 (copy)
		local v3 = t1[n1]

		assert(v3 ~= nil, "Unknown zone: " .. tostring(n1))

		return v3
	end,
	hasZone = function(n2: number) --[[ hasZone ]] -- line: 167
		-- upvalues: t1 (copy)
		return t1[n2] ~= nil
	end,
	getMaxZone = function() --[[ getMaxZone ]] -- line: 171
		-- upvalues: t1 (copy)
		local n3 = 0

		for v6 in t1 do
			if n3 < v6 then
				n3 = v6
			end
		end

		return n3
	end
}
