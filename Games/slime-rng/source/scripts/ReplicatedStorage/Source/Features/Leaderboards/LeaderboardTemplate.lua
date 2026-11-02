-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LeaderboardTemplate, time of decompilation: Sun May  3 10:12:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.LeaderboardTypes)

local LongNum = require(ReplicatedStorage.Source.Core.Math.LongNum)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)

return {
	mostRolls = {
		title = "Most Rolls",
		min = 10,
		smallestFirst = false,
		dataPath = {
			"stats",
			"rolls"
		},
		parent = workspace:WaitForChild("Leaderboards"):WaitForChild("MostRolls"),
		mutator = function(n1: number) --[[ mutator ]] -- line: 17
			-- upvalues: Abbreviate (copy)
			return Abbreviate(n1)
		end
	},
	rebirths = {
		title = "Most Rebirths",
		min = 1,
		smallestFirst = false,
		dataPath = { "rebirths" },
		parent = workspace:WaitForChild("Leaderboards"):WaitForChild("Rebirths")
	},
	rarestRoll1 = {
		title = "Best Roll",
		min = 100,
		smallestFirst = false,
		dataPath = {
			"stats",
			"rarestRoll",
			"odds"
		},
		parent = workspace:WaitForChild("Leaderboards"):WaitForChild("RarestRoll"),
		rounder = function(n2: number) --[[ rounder ]] -- line: 36
			-- upvalues: LongNum (copy)
			return LongNum.encode((math.round(n2)))
		end,
		mutator = function(n3: number) --[[ mutator ]] -- line: 39
			-- upvalues: LongNum (copy), Abbreviate (copy)
			local v7 = LongNum.decode(n3)

			return "1/" .. Abbreviate(v7)
		end
	},
	dailyRarestRoll1 = {
		title = "Daily Best Roll",
		min = 100,
		smallestFirst = false,
		resetFrequency = 86400,
		dataPath = {
			"stats",
			"dailyRarestRoll"
		},
		parent = workspace:WaitForChild("Leaderboards"):WaitForChild("DailyRarestRoll"),
		rounder = function(n4: number) --[[ rounder ]] -- line: 52
			-- upvalues: LongNum (copy)
			return LongNum.encode((math.round(n4)))
		end,
		mutator = function(n5: number) --[[ mutator ]] -- line: 55
			-- upvalues: LongNum (copy), Abbreviate (copy)
			local v10 = LongNum.decode(n5)

			return "1/" .. Abbreviate(v10)
		end
	}
}
