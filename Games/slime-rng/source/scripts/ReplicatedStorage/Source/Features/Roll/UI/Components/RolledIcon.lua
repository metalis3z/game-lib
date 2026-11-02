-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RolledIcon, time of decompilation: Sun May  3 10:11:49 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BonusRollIcon = require(script.Parent.BonusRollIcon)
local LuckRollIcon = require(script.Parent.LuckRollIcon)
local SlimeRollIcon = require(script.Parent.SlimeRollIcon)
local Vide = require(ReplicatedStorage.Packages.Vide)
local RollServiceUtils = require(ReplicatedStorage.Source.Features.Roll.RollServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

return function(t1: {[any]: any}) -- line: 15
	-- upvalues: Vide (copy), RollServiceUtils (copy), BonusRollIcon (copy), LuckRollIcon (copy), SlimeRollIcon (copy)
	local v8 = Vide.derive(function() -- line: 16
		-- upvalues: t1 (copy), RollServiceUtils (copy)
		local v9 = t1.data()

		if not v9 then
			return "NONE"
		end

		if RollServiceUtils.isBonusRoll(v9) then
			return "BONUS"
		end

		if RollServiceUtils.isLuckRoll(v9) then
			return "LUCK"
		end

		return "SLIME"
	end)

	return Vide.switch(v8)({
		BONUS = function() --[[ BONUS ]] -- line: 30
			-- upvalues: BonusRollIcon (copy), t1 (copy)
			return BonusRollIcon(t1.transparency)
		end,
		LUCK = function() --[[ LUCK ]] -- line: 33
			-- upvalues: LuckRollIcon (copy), t1 (copy)
			return LuckRollIcon(t1.data, t1.transparency)
		end,
		SLIME = function() --[[ SLIME ]] -- line: 36
			-- upvalues: SlimeRollIcon (copy), t1 (copy)
			return SlimeRollIcon(t1.data, t1.transparency)
		end
	})
end
