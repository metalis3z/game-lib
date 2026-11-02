-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeUIUtils, time of decompilation: Sun May  3 10:11:38 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)

local hexSize = UpgradeServiceUtils.enums.hexSize
local v4 = hexSize * 0.66 * 0.5 / 1.86799501867995
local rect = Rect.new(28, 22, 107, 100)

return {
	HOVER_INFO_WIDTH = 330,
	HOVER_INFO_HEIGHT = 166,
	HOVER_INFO_MOBILE_HEIGHT = 220,
	HEX_SIZE = hexSize,
	HOVER_FRAME_SLICE = rect,
	resolveCurrencyAmount = function(t1: {[any]: any}, s1: string) --[[ resolveCurrencyAmount ]] -- line: 22
		local v8 = t1[s1]

		if not v8 then
			return 0
		end

		local v9 = v8()

		if type(v9) ~= "number" then
			return 0
		end

		return v9
	end,
	isTouchPreferred = function(p1) --[[ isTouchPreferred ]] -- line: 36
		return p1 == Enum.PreferredInput.Touch
	end,
	getUpgradeDescription = function(p2) --[[ getUpgradeDescription ]] -- line: 40
		if p2.description ~= "" then
			return p2.description
		end

		if p2.tree then
			if p2.tree == "main" then
				return "Return to the main upgrade tree."
			end

			return `Open the { p2.name } tree.`
		end

		return `Unlock { p2.name }.`
	end,
	getActiveUpgradeCostAmount = function(p3) --[[ getActiveUpgradeCostAmount ]] -- line: 52
		local v13 = p3()

		if v13 and v13.cost then
			return v13.cost.amount
		end

		return 0
	end,
	isFreeUpgrade = function(p4) --[[ isFreeUpgrade ]] -- line: 61
		return p4 ~= nil and (p4.cost ~= nil and p4.cost.amount <= 0)
	end,
	getHoverPanelPosition = function(p5) --[[ getHoverPanelPosition ]] -- line: 65
		-- upvalues: hexSize (copy), v4 (copy)
		local v16 = 0.5 + p5.coords.X * hexSize + v4
		local v17 = 0.5 + p5.coords.Y * hexSize

		return UDim2.fromScale(v16, v17)
	end
}
