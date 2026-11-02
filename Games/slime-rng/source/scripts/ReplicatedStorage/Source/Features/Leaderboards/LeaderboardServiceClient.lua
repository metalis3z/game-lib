-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LeaderboardServiceClient, time of decompilation: Sun May  3 10:12:18 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.LeaderboardTypes)

local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)

return {
	leaderboardData = {},
	leaderboardsChanged = Signal.new(),
	init = function(p1) --[[ init ]] -- line: 12
		-- upvalues: Networker (copy)
		p1.networker = Networker.client.new("LeaderboardServiceServer", p1)
		task.spawn(function() -- line: 14
			-- upvalues: p1 (copy)
			p1.leaderboardData = p1.networker:fetch("getAllLeaderboardData")
			p1.leaderboardsChanged:Fire()
		end)
	end,
	leaderboardUpdated = function(p2, s1: string, p3) --[[ leaderboardUpdated ]] -- line: 20
		p2.leaderboardData[s1] = p3
		p2.leaderboardsChanged:Fire()
	end
}
