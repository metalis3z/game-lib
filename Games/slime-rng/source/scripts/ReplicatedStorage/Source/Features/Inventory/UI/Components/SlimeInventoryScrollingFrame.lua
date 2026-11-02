-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SlimeInventoryScrollingFrame, time of decompilation: Sun May  3 10:11:29 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local indexes = Vide.indexes

local function getHiddenRolledSlimeCounts() -- line: 29
	-- upvalues: RollSlice (copy), InventoryServiceUtils (copy)
	local t1 = {}

	if RollSlice.rollResults()[1] ~= nil and (not RollSlice.rollComplete() or (RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil)) then
		for _, v19 in RollSlice.rollResults() do
			local v20 = v19[#v19]

			if type(v20) == "table" and v20.id ~= nil then
				local v21 = InventoryServiceUtils.genKey(v20)

				t1[v21] = (t1[v21] or 0) + 1
			end
		end
	end

	if RollSlice.jackpotScreenShown() or RollSlice.jackpotSpinData() ~= nil then
		for _, v23 in RollSlice.jackpotSpinQueue() do
			local reward = v23.reward

			if type(reward) == "table" and reward.id ~= nil then
				local v25 = InventoryServiceUtils.genKey(reward)

				t1[v25] = (t1[v25] or 0) + 1
			end
		end
	end

	return t1
end
local function InventoryButton(p1, s1: string) -- line: 54
	-- upvalues: Vide (copy), InventoryServiceUtils (copy), SlimeButton (copy), InventoryServiceClient (copy)
	local v28 = Vide.derive(function() -- line: 55
		-- upvalues: InventoryServiceUtils (copy), s1 (copy), p1 (copy)
		return InventoryServiceUtils.getSlimeData(s1, p1().value)
	end)

	return SlimeButton({
		Name = "InventorySlime_" .. s1,
		SlimeData = v28,
		Amount = function() --[[ Amount ]] -- line: 62
			-- upvalues: p1 (copy)
			return p1().amount
		end,
		ShowLevel = function() --[[ ShowLevel ]] -- line: 65
			-- upvalues: p1 (copy)
			return type(p1().value) == "table"
		end,
		LayoutOrder = function() --[[ LayoutOrder ]] -- line: 68
			-- upvalues: InventoryServiceUtils (copy), v28 (copy)
			return InventoryServiceUtils.getLayoutOrder(v28())
		end,
		Activated = function() --[[ Activated ]] -- line: 71
			-- upvalues: InventoryServiceClient (copy), s1 (copy)
			InventoryServiceClient:equipSlime(s1)
		end
	})
end

return function() -- line: 77
	-- upvalues: getDataSource (copy), Vide (copy), getHiddenRolledSlimeCounts (copy), InventoryServiceUtils (copy), ScrollingFrame (copy), indexes (copy), InventoryButton (copy), UIGridLayout (copy), UIPadding (copy)
	local v29 = getDataSource("inventory")
	local v30 = getDataSource("equipped")
	local v31 = Vide.derive(function() -- line: 80
		-- upvalues: v29 (copy), v30 (copy), getHiddenRolledSlimeCounts (copy), InventoryServiceUtils (copy)
		local t2 = {}
		local v33 = v29() or {}
		local v34 = v30() or {}
		local v35 = getHiddenRolledSlimeCounts()

		for v36, v37 in v33 do
			local v38 = v37
			local v39 = v35[v36] or 0

			if v39 > 0 and type(v37) == "number" then
				v38 = math.max(v37 - v39, 0)
			end

			local v40 = InventoryServiceUtils.getAvailableAmount(v36, v38, v34)

			if v40 > 0 then
				t2[v36] = {
					value = v37,
					amount = v40
				}
			end
		end

		return t2
	end)

	return ScrollingFrame({
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0.6),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.fromScale(0.5, 1),
		ScrollBarImageTransparency = 1,
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		indexes(v31, InventoryButton),
		UIGridLayout({
			CellSize = UDim2.fromOffset(120, 120),
			CellPadding = UDim2.fromOffset(17, 10),
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		UIPadding({
			PaddingTop = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10)
		})
	})
end
