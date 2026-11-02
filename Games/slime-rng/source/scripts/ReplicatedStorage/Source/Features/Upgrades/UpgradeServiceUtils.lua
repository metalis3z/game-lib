-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeServiceUtils, time of decompilation: Sun May  3 10:11:33 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	origin = 0,
	top = 1,
	topRight = 2,
	botRight = 3,
	bot = 4,
	botLeft = 5,
	topLeft = 6
}
local t2 = {
	slots = {
		[0] = 2,
		[2] = 3,
		[3] = 4,
		[4] = 5,
		[5] = 6,
		[6] = 7,
		[7] = 8
	},
	enemyCount = {
		[0] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7
	},
	enemySpawnSpeed = {
		[0] = 1,
		[1] = 1.2,
		[2] = 1.4,
		[3] = 1.65
	},
	slimeTargetRange = {
		[0] = 1,
		[1] = 1.15,
		[2] = 1.3,
		[3] = 1.5
	},
	luck = {
		[0] = 1,
		[1] = 1.2,
		[2] = 1.5,
		[3] = 2,
		[4] = 2.5,
		[5] = 3,
		[6] = 3.5,
		[7] = 4,
		[8] = 4.5,
		[9] = 5,
		[10] = 5.5,
		[11] = 6,
		[12] = 6.5,
		[13] = 7,
		[14] = 7.5,
		[15] = 8
	},
	rollSpeed = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2,
		[3] = 1.3,
		[4] = 1.4,
		[5] = 1.5,
		[6] = 1.6
	},
	cloverRolls = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2,
		[3] = 1.3,
		[4] = 1.4,
		[5] = 1.5
	},
	bonusRolls = {
		[0] = 1,
		[1] = 1.05,
		[2] = 1.1,
		[3] = 1.15
	},
	extraRollChance = {
		[0] = 0,
		[1] = 0.01,
		[2] = 0.02,
		[3] = 0.03
	},
	coinIncome = {
		[0] = 1,
		[1] = 1.25,
		[2] = 1.5,
		[3] = 2,
		[4] = 2.5,
		[5] = 3,
		[6] = 3.5,
		[7] = 4,
		[8] = 4.5,
		[9] = 5,
		[10] = 5.5,
		[11] = 6,
		[12] = 6.5,
		[13] = 7,
		[14] = 7.5,
		[15] = 8
	},
	overkill = {
		[0] = 0,
		[1] = 0.33,
		[2] = 0.66,
		[3] = 1.33,
		[4] = 1.66,
		[5] = 2,
		[6] = 2.33,
		[7] = 2.66,
		[8] = 3
	},
	bigEnemyChance = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2,
		[3] = 1.3
	},
	shinyEnemyChance = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2
	},
	hugeEnemyChance = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2
	},
	invertedEnemyChance = {
		[0] = 1,
		[1] = 1.1,
		[2] = 1.2
	},
	offlineLootAmount = {
		[0] = 0.1,
		[1] = 0.11000000000000001,
		[2] = 0.125,
		[3] = 0.15000000000000002,
		[4] = 0.17500000000000002,
		[5] = 0.2
	},
	magnetRadius = {
		[0] = 0,
		[1] = 18,
		[2] = 28,
		[3] = 38
	},
	walkSpeed = {
		[0] = 22,
		[1] = 24,
		[2] = 26,
		[3] = 28
	},
	friendLuck = {
		[0] = 0,
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
		[8] = 8,
		[9] = 9
	},
	friendLuckBoost = {
		[0] = 1,
		[1] = 1.5,
		[2] = 2,
		[3] = 2.5,
		[4] = 3
	},
	goopDropRate = {
		[0] = 0.25,
		[1] = 0.35,
		[2] = 0.45,
		[3] = 0.55,
		[4] = 0.65,
		[5] = 0.75,
		[6] = 0.85,
		[7] = 0.95
	}
}
local t3 = {
	hexSize = 0.07142857142857142,
	originDependency = "origin",
	sides = t1,
	levelBasedUpgrades = t2,
	coords = {
		[t1.origin] = Vector2.new(0, 0),
		[t1.top] = Vector2.new(0, -0.9),
		[t1.bot] = Vector2.new(0, 0.9),
		[t1.topRight] = Vector2.new(0.4, -0.45),
		[t1.botRight] = Vector2.new(0.4, 0.45),
		[t1.topLeft] = Vector2.new(-0.4, -0.45),
		[t1.botLeft] = Vector2.new(-0.4, 0.45)
	},
	luckRolls = {
		golden = {
			[1] = 10,
			[2] = 9,
			[3] = 8
		},
		diamond = {
			[1] = 100,
			[2] = 90,
			[3] = 75
		},
		void = {
			[1] = 1000,
			[2] = 950,
			[3] = 900
		}
	}
}
local t4 = {
	"big",
	"huge",
	"shiny",
	"inverted"
}
local t5 = {
	big = "bigSlimes",
	huge = "hugeSlimes",
	shiny = "shinySlimes",
	inverted = "invertedSlimes"
}
local t7 = {
	enums = t3,
	getUpgradeLevel = function(s1: string, t6: {[any]: any}) --[[ getUpgradeLevel ]] -- line: 243
		local v10 = t6 or {}
		local v11 = not v10[s1] and 0 or 1
		local v12 = string.len(s1)

		for v13, v14 in v10 do
			if v14 and s1 == string.sub(v13, 1, v12) then
				local num = tonumber((string.sub(v13, v12 + 1)))

				if num and v11 < num then
					v11 = num
				end
			end
		end

		return v11
	end,
	getUpgradeValue = function(s2: string, n1: number) --[[ getUpgradeValue ]] -- line: 266
		-- upvalues: t3 (copy)
		local v18 = t3.levelBasedUpgrades[s2]

		if not v18 then
			return 0
		end

		local v19 = v18[n1]

		if v19 ~= nil then
			return v19
		end

		return v18[0] or 0
	end
}

function t7.getGoopDropRate(t8: {[any]: any}?) -- line: 280
	-- upvalues: t7 (copy)
	local v21 = t8 or {}

	if not t7.ownsUpgrade("goop", v21) then
		return 0
	end

	local v22 = t7.getUpgradeLevel("goopDropRate", v21)

	return (math.clamp(t7.getUpgradeValue("goopDropRate", v22), 0, 1))
end
function t7.ownsUpgrade(s3: string, t9: {[any]: any}) -- line: 290
	return (t9 or {})[s3] == true
end
function t7.isMutationUnlocked(p1, t10: {[any]: any}?) -- line: 295
	-- upvalues: t5 (copy), t7 (copy)
	local v27 = t5[p1]

	if v27 == nil then
		return true
	end

	return t7.ownsUpgrade(v27, t10 or {})
end
function t7.getUnlockedMutations(t11: {[any]: any}?) -- line: 304
	-- upvalues: t4 (copy), t7 (copy)
	local t12 = {}

	for _, v31 in t4 do
		if t7.isMutationUnlocked(v31, t11) then
			t12[v31] = true
		end
	end

	return t12
end

return t7
