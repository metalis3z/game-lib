-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexSlice, time of decompilation: Sun May  3 10:12:32 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.IndexRewardUtils)

local Vide = require(ReplicatedStorage.Packages.Vide)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local v5 = IndexServiceUtils.getCategoryIds()[1] or "basic"
local v6 = Slimes.getSortedSlimes()
local v7 = if not v6[1] then nil else v6[1].id
local t1 = {}

for _, v10 in IndexServiceUtils.getCategoryIds() do
	t1[v10] = v7
end

local v11 = Vide.source(t1)
local v12 = Vide.source(v5)
local v13 = Vide.source(nil)

return {
	activeCategoryId = v12,
	selectedSlimeIds = v11,
	hoveredReward = v13,
	getActiveCategoryId = function() --[[ getActiveCategoryId ]] -- line: 27
		-- upvalues: v12 (copy)
		return v12
	end,
	getSelectedSlimeId = function(s1: string) --[[ getSelectedSlimeId ]] -- line: 31
		-- upvalues: Vide (copy), v11 (copy)
		return Vide.derive(function() -- line: 32
			-- upvalues: v11 (copy), s1 (copy)
			return v11()[s1]
		end)
	end,
	actions = {
		setActiveCategoryId = function(s2: string) --[[ setActiveCategoryId ]] -- line: 38
			-- upvalues: v12 (copy)
			if s2 == v12() then
				return
			end

			v12(s2)
		end,
		setSelectedSlimeId = function(s3: string, s4: string?) --[[ setSelectedSlimeId ]] -- line: 45
			-- upvalues: v11 (copy)
			if s4 == v11()[s3] then
				return
			end

			local v18 = table.clone(v11())

			v18[s3] = s4
			v11(v18)
		end
	}
}
