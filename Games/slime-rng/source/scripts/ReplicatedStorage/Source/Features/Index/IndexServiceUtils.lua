-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexServiceUtils, time of decompilation: Sun May  3 10:12:31 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local IndexRewards = require(ReplicatedStorage.Source.Features.Index.IndexRewards)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	"basic",
	"big",
	"huge",
	"shiny",
	"inverted"
}
local t2 = {
	basic = {
		id = "basic",
		name = "Basic",
		title = "Slime Index",
		buttonText = "Base",
		icon = Slimes.getImage("goopy"),
		slimeData = {
			id = "goopy",
			level = 1,
			xp = 0
		}
	},
	big = {
		id = "big",
		name = "Big",
		title = "Big Index",
		buttonText = "Big",
		icon = Slimes.getImage("goopy", {
			big = true
		}),
		slimeData = {
			id = "goopy",
			level = 1,
			xp = 0,
			mutations = {
				big = true
			}
		}
	},
	huge = {
		id = "huge",
		name = "Huge",
		title = "Huge Index",
		buttonText = "Huge",
		icon = Slimes.getImage("goopy", {
			huge = true
		}),
		slimeData = {
			id = "goopy",
			level = 1,
			xp = 0,
			mutations = {
				huge = true
			}
		}
	},
	shiny = {
		id = "shiny",
		name = "Shiny",
		title = "Shiny Index",
		buttonText = "Shiny",
		icon = Slimes.getImage("goopy", {
			shiny = true
		}),
		slimeData = {
			id = "goopy",
			level = 1,
			xp = 0,
			mutations = {
				shiny = true
			}
		}
	},
	inverted = {
		id = "inverted",
		name = "Inverted",
		title = "Inverted Index",
		buttonText = "Inverted",
		icon = Slimes.getImage("goopy", {
			inverted = true
		}),
		slimeData = {
			id = "goopy",
			level = 1,
			xp = 0,
			mutations = {
				inverted = true
			}
		}
	}
}
local t3 = {
	createCategoryData = function() --[[ createCategoryData ]] -- line: 93
		return {
			counts = {},
			unlocked = {},
			claimedRewards = {}
		}
	end
}

function t3.createDefaultIndexData() -- line: 101
	-- upvalues: t3 (copy)
	return {
		migratedV1 = false,
		categories = {
			basic = t3.createCategoryData(),
			big = t3.createCategoryData(),
			huge = t3.createCategoryData(),
			shiny = t3.createCategoryData(),
			inverted = t3.createCategoryData()
		}
	}
end
function t3.reconcileCategoryData(p1) -- line: 114
	local v9 = if type(p1) ~= "table" then {} else p1
	local t4 = {}
	local t5 = {}
	local t6 = {}

	for v13, v14 in v9.counts or {} do
		if type(v13) == "string" and type(v14) == "number" and v14 > 0 then
			t4[v13] = math.max(math.floor(v14 + 0.5), 0)
		end
	end

	for v15, v16 in v9.unlocked or {} do
		if type(v15) == "string" and v16 == true then
			t5[v15] = true
		end
	end

	for v17, v18 in v9.claimedRewards or {} do
		if type(v17) == "string" and v18 == true then
			t6[v17] = true
		end
	end

	return {
		counts = t4,
		unlocked = t5,
		claimedRewards = t6
	}
end
function t3.reconcileIndexData(p2) -- line: 145
	-- upvalues: t3 (copy), t1 (copy)
	local v20 = if type(p2) ~= "table" then {} else p2
	local categories = t3.createDefaultIndexData().categories

	if type(v20.categories) == "table" then
		for _, v23 in t1 do
			categories[v23] = t3.reconcileCategoryData(v20.categories[v23])
		end
	end

	return {
		migratedV1 = v20.migratedV1 == true,
		categories = categories
	}
end
function t3.cloneIndexData(p3) -- line: 162
	-- upvalues: t3 (copy), t1 (copy)
	local v25 = t3.reconcileIndexData(p3)
	local v26 = t3.createDefaultIndexData()

	v26.migratedV1 = v25.migratedV1

	for _, v28 in t1 do
		v26.categories[v28] = {
			counts = table.clone(v25.categories[v28].counts),
			unlocked = table.clone(v25.categories[v28].unlocked),
			claimedRewards = table.clone(v25.categories[v28].claimedRewards)
		}
	end

	return v26
end
function t3.isCategoryId(p4) -- line: 178
	-- upvalues: t2 (copy)
	return t2[p4] ~= nil
end
function t3.getCategoryIds() -- line: 182
	-- upvalues: t1 (copy)
	return table.clone(t1)
end
function t3.getCategoryDisplayInfo(p5) -- line: 186
	-- upvalues: t2 (copy)
	return t2[p5]
end
function t3.createDisplaySlimeData(p6, s1: string) -- line: 190
	local t7 = nil

	if p6 ~= "basic" then
		t7 = {
			[p6] = true
		}
	end

	return {
		level = 1,
		xp = 0,
		id = s1,
		mutations = t7
	}
end
function t3.getTrackedCategoryIds(p7) -- line: 206
	-- upvalues: Mutations (copy)
	local t8 = { "basic" }

	if p7 == nil then
		return t8
	end

	for _, v37 in Mutations.sortedMutations do
		if p7[v37] == true then
			table.insert(t8, v37)
		end
	end

	return t8
end
function t3.markUnlocked(p8, p9, s2: string) -- line: 221
	p8.categories[p9].unlocked[s2] = true
end
function t3.addCount(p10, p11, s3: string, n1: number?) -- line: 225
	local v45 = math.max(math.floor((n1 or 1) + 0.5), 0)

	if v45 <= 0 then
		return
	end

	local v46 = p10.categories[p11]

	v46.unlocked[s3] = true
	v46.counts[s3] = (v46.counts[s3] or 0) + v45
end
function t3.trackSlimeData(p12, p13, n2: number?) -- line: 236
	-- upvalues: t3 (copy)
	for _, v51 in t3.getTrackedCategoryIds(p13.mutations) do
		t3.addCount(p12, v51, p13.id, n2)
	end
end
function t3.getUnlockedCountFromData(p14, p15) -- line: 246
	local n3 = 0

	for _, v56 in p14.categories[p15].unlocked do
		if v56 == true then
			n3 += 1
		end
	end

	return n3
end
function t3.getUnlockedCount(p16, p17) -- line: 257
	-- upvalues: t3 (copy)
	local v59 = t3.reconcileIndexData(p16)

	return t3.getUnlockedCountFromData(v59, p17)
end
function t3.isUnlockedFromData(p18, p19, s4: string) -- line: 262
	return p18.categories[p19].unlocked[s4] == true
end
function t3.isUnlocked(p20, p21, s5: string) -- line: 270
	-- upvalues: t3 (copy)
	local v66 = t3.reconcileIndexData(p20)

	return t3.isUnlockedFromData(v66, p21, s5)
end
function t3.getCountFromData(p22, p23, s6: string) -- line: 275
	return p22.categories[p23].counts[s6] or 0
end
function t3.getCount(p24, p25, s7: string) -- line: 279
	-- upvalues: t3 (copy)
	local v73 = t3.reconcileIndexData(p24)

	return t3.getCountFromData(v73, p25, s7)
end
function t3.getMaxUnlockCount() -- line: 284
	-- upvalues: Slimes (copy)
	return #Slimes.getSortedSlimes()
end
function t3.getPermanentBonusesFromData(p26) -- line: 288
	-- upvalues: t1 (copy), IndexRewards (copy)
	local t9 = {
		flatLuck = 0,
		luckMultiplier = 0,
		coinMultiplier = 0
	}

	for _, v77 in t1 do
		local claimedRewards = p26.categories[v77].claimedRewards
		local v79 = IndexRewards[v77]

		if type(v79) == "table" then
			for _, v81 in v79 do
				if type(v81) == "table" and type(v81.key) == "string" and claimedRewards[v81.key] == true then
					for _, v83 in v81.rewards or {} do
						if type(v83) == "table" then
							if v83.kind == "luckFlat" then
								t9.flatLuck = t9.flatLuck + math.max(math.floor((v83.amount or 0) + 0.5), 0)
							elseif v83.kind == "luckMultiplier" then
								t9.luckMultiplier = t9.luckMultiplier + math.max(tonumber(v83.amount) or 0, 0)
							elseif v83.kind == "coinMultiplier" then
								t9.coinMultiplier = t9.coinMultiplier + math.max(tonumber(v83.amount) or 0, 0)
							end
						end
					end
				end
			end
		end
	end

	return t9
end
function t3.getPermanentBonuses(p27) -- line: 329
	-- upvalues: t3 (copy)
	local v85 = t3.reconcileIndexData(p27)

	return t3.getPermanentBonusesFromData(v85)
end
function t3.getLuckModifiersFromData(p28) -- line: 334
	-- upvalues: t3 (copy)
	local v87 = t3.getPermanentBonusesFromData(p28)
	local t10 = {}

	if v87.flatLuck > 0 then
		table.insert(t10, {
			id = "index.luckFlat",
			stat = "luck",
			mode = "add",
			value = v87.flatLuck
		})
	end

	if v87.luckMultiplier > 0 then
		table.insert(t10, {
			id = "index.luckMultiplier",
			stat = "luck",
			mode = "multiply",
			applyToFinalLuck = true,
			value = 1 + v87.luckMultiplier
		})
	end

	return t10
end
function t3.getLuckModifiers(p29) -- line: 360
	-- upvalues: t3 (copy)
	local v90 = t3.reconcileIndexData(p29)

	return t3.getLuckModifiersFromData(v90)
end
function t3.getCoinRewardMultiplierFromData(p30) -- line: 365
	-- upvalues: t3 (copy)
	return math.max(t3.getPermanentBonusesFromData(p30).coinMultiplier, 0) + 1
end
function t3.getCoinRewardMultiplier(p31) -- line: 369
	-- upvalues: t3 (copy)
	local v93 = t3.reconcileIndexData(p31)

	return t3.getCoinRewardMultiplierFromData(v93)
end

return t3
