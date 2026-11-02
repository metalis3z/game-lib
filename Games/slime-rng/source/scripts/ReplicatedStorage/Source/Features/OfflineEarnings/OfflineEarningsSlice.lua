-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OfflineEarningsSlice, time of decompilation: Sun May  3 10:12:12 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local v3 = Vide.source(nil)
local v4 = Vide.source(0)
local v5 = Vide.source(nil)

return {
	pendingReward = v3,
	burstId = v4,
	latestBurst = v5,
	actions = {
		setPendingReward = function(p1) --[[ setPendingReward ]] -- line: 28
			-- upvalues: v3 (copy)
			v3(p1)
		end,
		clearPendingReward = function() --[[ clearPendingReward ]] -- line: 32
			-- upvalues: v3 (copy)
			v3(nil)
		end,
		triggerBurst = function(t1: {[any]: any}) --[[ triggerBurst ]] -- line: 36
			-- upvalues: Vide (copy), v5 (copy), v4 (copy)
			if #t1 == 0 then
				return
			end

			Vide.batch(function() -- line: 41
				-- upvalues: v5 (copy), t1 (copy), v4 (copy)
				v5({
					entries = t1
				})
				v4(v4() + 1)
			end)
		end,
		clearBurst = function() --[[ clearBurst ]] -- line: 49
			-- upvalues: v5 (copy)
			v5(nil)
		end
	}
}
