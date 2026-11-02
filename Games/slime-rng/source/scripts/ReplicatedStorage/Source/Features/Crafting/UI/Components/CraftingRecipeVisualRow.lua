-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingRecipeVisualRow, time of decompilation: Sun May  3 10:12:29 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local CraftingSlice = require(ReplicatedStorage.Source.Features.Crafting.CraftingSlice)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local CraftingIngredientSlot = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingIngredientSlot)
local CraftingMenuUtils = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingMenuUtils)
local CraftingRecipePreviewSlot = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingRecipePreviewSlot)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Features.Crafting.Recipes)
require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

local function RecipeDivider(s1: string, n1: number, p1) -- line: 26
	-- upvalues: TextLabel (copy), Vide (copy)
	return TextLabel({
		ZIndex = 3,
		Text = s1,
		LayoutOrder = n1,
		Size = function() --[[ Size ]] -- line: 30
			-- upvalues: Vide (copy), p1 (copy)
			return UDim2.fromOffset(24, Vide.read(p1))
		end,
		TextSize = s1 ~= "->" and 40 or 50,
		Stroke = {}
	})
end
local function createIngredientRowItem(t1: {[any]: any}) -- line: 39
	-- upvalues: CraftingServiceUtils (copy), Vide (copy), CraftingIngredientSlot (copy), CraftingSlice (copy), ImageIds (copy), CraftingMenuUtils (copy), CraftingRecipePreviewSlot (copy)
	local v18 = t1.Recipe.inputs[t1.IngredientIndex]
	local v19 = CraftingServiceUtils.getIngredientDisplayData(v18)

	return Vide.show(t1.SelectionMode, function() -- line: 50
		-- upvalues: CraftingIngredientSlot (copy), t1 (copy), CraftingSlice (copy), ImageIds (copy), v19 (copy), CraftingMenuUtils (copy), v18 (copy)
		return CraftingIngredientSlot({
			ZIndex = 3,
			LayoutOrder = t1.LayoutOrder,
			Size = UDim2.fromOffset(124, 124),
			Image = function() --[[ Image ]] -- line: 54
				-- upvalues: CraftingSlice (copy), t1 (copy), ImageIds (copy)
				if CraftingSlice.pickerIngredientIndex() == t1.IngredientIndex then
					return ImageIds.blackButtonWhiteOutline
				end

				return ImageIds.blackCheckeredButton
			end,
			RequiredSlimeData = v19,
			SelectedSlimeData = function() --[[ SelectedSlimeData ]] -- line: 62
				-- upvalues: CraftingMenuUtils (copy), t1 (copy), CraftingSlice (copy)
				return CraftingMenuUtils.getSelectedSlimeData(t1.Inventory() or {}, CraftingSlice.selectedIngredientUniqueIds() or {}, t1.IngredientIndex)
			end,
			ShowLevel = function() --[[ ShowLevel ]] -- line: 69
				-- upvalues: CraftingMenuUtils (copy), t1 (copy), CraftingSlice (copy)
				return CraftingMenuUtils.shouldShowSelectedLevel(t1.Inventory() or {}, CraftingSlice.selectedIngredientUniqueIds() or {}, t1.IngredientIndex)
			end,
			Discovered = function() --[[ Discovered ]] -- line: 76
				-- upvalues: t1 (copy), v18 (copy)
				return t1.HasDiscoveredSlime(v18.id)
			end,
			Activated = function() --[[ Activated ]] -- line: 79
				-- upvalues: CraftingSlice (copy), t1 (copy)
				CraftingSlice.pickerIngredientIndex(t1.IngredientIndex)
			end
		})
	end, function() -- line: 84
		-- upvalues: CraftingRecipePreviewSlot (copy), t1 (copy), v18 (copy), v19 (copy)
		return CraftingRecipePreviewSlot({
			ShowDetails = true,
			LayoutOrder = t1.LayoutOrder,
			Discovered = function() --[[ Discovered ]] -- line: 87
				-- upvalues: t1 (copy), v18 (copy)
				return t1.HasDiscoveredSlime(v18.id)
			end,
			SlimeData = v19
		})
	end)
end

return function(t2: {[any]: any}) -- line: 96
	-- upvalues: Vide (copy), CraftingServiceUtils (copy), CraftingSlice (copy), UIListLayout (copy), createIngredientRowItem (copy), RecipeDivider (copy), CraftingRecipePreviewSlot (copy), Frame (copy)
	local v21 = Vide.derive(function() -- line: 97
		-- upvalues: t2 (copy), CraftingServiceUtils (copy), CraftingSlice (copy)
		if not t2.SelectionMode() then
			return CraftingServiceUtils.getOutputDisplayData(t2.Recipe)
		end

		local v27 = CraftingServiceUtils.getSelectedSlimeDatas(t2.Inventory() or {}, CraftingSlice.selectedIngredientUniqueIds() or {})

		if #v27 == 0 then
			return CraftingServiceUtils.getOutputDisplayData(t2.Recipe)
		end

		return CraftingServiceUtils.getCraftOutputSlimeData(t2.Recipe, v27)
	end)
	local t3 = {
		Size = UDim2.new(1, -180, 0, 96),
		Position = UDim2.fromOffset(18, 40),
		BackgroundTransparency = 1,
		UIListLayout({
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 0)
		})
	}
	local n2 = 1

	for v24, _ in t2.Recipe.inputs do
		table.insert(t3, createIngredientRowItem({
			Recipe = t2.Recipe,
			IngredientIndex = v24,
			LayoutOrder = n2,
			SelectionMode = t2.SelectionMode,
			HasDiscoveredSlime = t2.HasDiscoveredSlime,
			Inventory = t2.Inventory
		}))
		n2 += 1

		if v24 < #t2.Recipe.inputs then
			table.insert(t3, RecipeDivider("+", n2, function() -- line: 144
				-- upvalues: t2 (copy)
				if t2.SelectionMode() then
					return 132
				end

				return 92
			end))
			n2 += 1
		end
	end

	table.insert(t3, RecipeDivider("->", n2, function() -- line: 154
		-- upvalues: t2 (copy)
		if t2.SelectionMode() then
			return 132
		end

		return 92
	end))

	local v26 = n2 + 1

	table.insert(t3, CraftingRecipePreviewSlot({
		ShowDetails = true,
		LayoutOrder = v26,
		Discovered = function() --[[ Discovered ]] -- line: 164
			-- upvalues: t2 (copy)
			return t2.HasDiscoveredSlime(t2.Recipe.outputId)
		end,
		SlimeData = v21,
		Size = UDim2.fromOffset(150, 150)
	}))

	return Frame(t3)
end
