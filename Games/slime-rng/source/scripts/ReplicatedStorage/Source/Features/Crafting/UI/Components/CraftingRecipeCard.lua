-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingRecipeCard, time of decompilation: Sun May  3 10:12:28 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local InsetFrame = require(ReplicatedStorage.Source.Features.App.Components.InsetFrame)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local CraftingServiceClient = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceClient)
local CraftingSlice = require(ReplicatedStorage.Source.Features.Crafting.CraftingSlice)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local CraftingMenuUtils = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingMenuUtils)
local AutoCraftFrame = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.AutoCraftFrame)
local CraftingInventoryPicker = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingInventoryPicker)
local CraftingRecipeVisualRow = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingRecipeVisualRow)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Features.Crafting.Recipes)
require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local indexes = Vide.indexes

local function formatMutationChance(n1: number) -- line: 60
	local v33 = n1 * 100

	if v33 >= 99.95 then
		return "100%"
	end

	if v33 >= 10 then
		return string.format("%.0f%%", v33)
	end

	if v33 >= 1 then
		return string.format("%.1f%%", v33)
	end

	return string.format("%.2f%%", v33)
end
local function SelectionToggleButton(p1: ((...any) -> ...any), p2: ((...any) -> ...any), p3: ((...any) -> ...any)) -- line: 75
	-- upvalues: StylizedButton (copy)
	return StylizedButton({
		HoverScale = 1.05,
		ZIndex = 3,
		Theme = function() --[[ Theme ]] -- line: 78
			-- upvalues: p1 (copy)
			if p1() then
				return "Red"
			end

			return "Blue"
		end,
		Text = function() --[[ Text ]] -- line: 85
			-- upvalues: p1 (copy)
			if p1() then
				return "Cancel"
			end

			return "Select"
		end,
		Size = UDim2.fromOffset(152, 58),
		Position = UDim2.fromOffset(720, 120),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Activated = function() --[[ Activated ]] -- line: 95
			-- upvalues: p1 (copy), p3 (copy), p2 (copy)
			if p1() then
				p3()

				return
			end

			p2()
		end
	})
end
local function MutationPreviewFrame(p4) -- line: 106
	-- upvalues: InsetFrame (copy), UIPadding (copy), UIListLayout (copy), Vide (copy), indexes (copy), TextLabel (copy), formatMutationChance (copy)
	return InsetFrame({
		Name = "MutationPreviewFrame",
		Size = UDim2.fromOffset(180, 86),
		Position = UDim2.fromOffset(720, 225),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 3,
		UIPadding({
			PaddingTop = UDim.new(0, 8),
			PaddingBottom = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8)
		}),
		UIListLayout({
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2)
		}),
		Vide.show(function() -- line: 129
			-- upvalues: p4 (copy)
			return #p4() > 0
		end, function() -- line: 131
			-- upvalues: indexes (copy), p4 (copy), TextLabel (copy), formatMutationChance (copy)
			return indexes(p4, function(p5, p6) -- line: 132
				-- upvalues: TextLabel (copy), formatMutationChance (copy)
				return TextLabel({
					TextSize = 16,
					ZIndex = 4,
					Text = function() --[[ Text ]] -- line: 134
						-- upvalues: p5 (copy), formatMutationChance (copy)
						local v91 = p5()

						return `{ v91.name } { formatMutationChance(v91.chance) }`
					end,
					LayoutOrder = p6,
					Size = UDim2.new(1, 0, 0, 16),
					Stroke = {}
				})
			end)
		end, function() -- line: 145
			-- upvalues: TextLabel (copy)
			return TextLabel({
				Text = "No mutation chance",
				TextSize = 16,
				ZIndex = 4,
				Size = UDim2.new(1, 0, 0, 18),
				Stroke = {}
			})
		end)
	})
end
local function ActiveSelectionContent(t1: {[any]: any}) -- line: 157
	-- upvalues: TextLabel (copy), CraftingSlice (copy), CraftingServiceUtils (copy), InsetFrame (copy), CraftingInventoryPicker (copy), MutationPreviewFrame (copy), StylizedButton (copy), Vide (copy), AutoCraftFrame (copy)
	return {
		TextLabel({
			TextSize = 20,
			ZIndex = 3,
			Text = function() --[[ Text ]] -- line: 160
				-- upvalues: CraftingSlice (copy), t1 (copy), CraftingServiceUtils (copy)
				local v64 = CraftingSlice.pickerIngredientIndex()
				local v65 = if not v64 then nil else t1.Recipe.inputs[v64]

				if v65 == nil then
					return "Select a slot above."
				end

				return `Choose a { CraftingServiceUtils.getIngredientDisplayName(v65) }:`
			end,
			Size = UDim2.new(1, -24, 0, 28),
			Position = UDim2.fromOffset(20, 160),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {},
			DropShadow = {}
		}),
		InsetFrame({
			Name = "PickerPanel",
			Size = UDim2.new(0.7, 0, 0, 142),
			Position = UDim2.fromOffset(20, 180),
			ZIndex = 3,
			CraftingInventoryPicker({
				Entries = t1.PickerEntries,
				EmptyText = function() --[[ EmptyText ]] -- line: 186
					-- upvalues: CraftingSlice (copy), CraftingServiceUtils (copy), t1 (copy)
					local v66 = CraftingSlice.pickerIngredientIndex()

					if not v66 then
						return "Pick a recipe slot above first."
					end

					return `You don't have any { CraftingServiceUtils.getIngredientDisplayName(t1.Recipe.inputs[v66]) }.`
				end,
				OnSelect = t1.OnSelectIngredientUniqueId
			})
		}),
		MutationPreviewFrame(t1.MutationPreviewEntries),
		StylizedButton({
			Text = "Craft",
			ZIndex = 4,
			Theme = function() --[[ Theme ]] -- line: 203
				-- upvalues: t1 (copy)
				if t1.AllIngredientsSelected() then
					return "Green"
				end

				return "Grey"
			end,
			Size = UDim2.fromOffset(152, 58),
			Position = UDim2.fromOffset(720, 300),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = t1.OnCraftSelectedRecipe
		}),
		Vide.show(t1.ShouldShowAutoCraft, function() -- line: 214
			-- upvalues: AutoCraftFrame (copy), t1 (copy)
			return AutoCraftFrame({
				MaxCrafts = t1.MaxAutoCrafts,
				OnAutoCraft = t1.OnAutoCraftSelectedRecipe
			})
		end)
	}
end
local function OwnedContent(t2: {[any]: any}) -- line: 223
	-- upvalues: Frame (copy), CraftingRecipeVisualRow (copy), SelectionToggleButton (copy), Vide (copy), ActiveSelectionContent (copy)
	return Frame({
		Size = UDim2.fromScale(1, 1),
		CraftingRecipeVisualRow({
			Recipe = t2.Recipe,
			SelectionMode = t2.IsActive,
			HasDiscoveredSlime = t2.HasDiscoveredSlime,
			Inventory = t2.Inventory
		}),
		SelectionToggleButton(t2.IsActive, t2.OnBeginSelection, t2.OnCancelSelection),
		Vide.show(t2.IsActive, function() -- line: 236
			-- upvalues: ActiveSelectionContent (copy), t2 (copy)
			return (ActiveSelectionContent(t2))
		end)
	})
end
local function UnlockButton(p7: ((...any) -> ...any), n2: number?, p8: ((...any) -> ...any)) -- line: 242
	-- upvalues: StylizedButton (copy), Abbreviate (copy)
	return StylizedButton({
		ZIndex = 3,
		Theme = function() --[[ Theme ]] -- line: 244
			-- upvalues: p7 (copy)
			if p7() then
				return "Green"
			end

			return "Grey"
		end,
		Text = function() --[[ Text ]] -- line: 247
			-- upvalues: Abbreviate (copy), n2 (copy)
			return `BUY { Abbreviate(n2 or 0) }`
		end,
		Size = UDim2.fromOffset(260, 74),
		Position = UDim2.fromScale(0.5, 0.63),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Activated = p8
	})
end
local function LockedDescriptionContent(p9) -- line: 258
	-- upvalues: Frame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy)
	return Frame({
		Size = UDim2.fromScale(1, 1),
		ImageLabel({
			Name = "LockIcon",
			ImageTransparency = 0.5,
			ZIndex = 3,
			Image = ImageIds.lock,
			Size = UDim2.fromOffset(70, 70),
			Position = UDim2.fromScale(0.5, 0.33),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}),
		TextLabel({
			Name = "LockedDescription",
			TextWrapped = true,
			ZIndex = 3,
			Text = p9.description or "Recipe not unlocked yet.",
			Size = UDim2.new(0.8, 0, 0, 40),
			Position = UDim2.fromScale(0.5, 0.675),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = Color3.fromRGB(200, 200, 200)
		})
	})
end

return function(t3: {[any]: any}) -- line: 285
	-- upvalues: Vide (copy), CraftingServiceUtils (copy), CraftingSlice (copy), UpgradeServiceUtils (copy), CraftingMenuUtils (copy), InventoryServiceUtils (copy), IndexServiceUtils (copy), CraftingServiceClient (copy), Menu (copy), StylizedFrame (copy), OwnedContent (copy), UnlockButton (copy), LockedDescriptionContent (copy)
	local Recipe = t3.Recipe
	local v46 = Vide.derive(function() -- line: 287
		-- upvalues: CraftingServiceUtils (copy), t3 (copy), Recipe (copy)
		return CraftingServiceUtils.isRecipeOwned(t3.UnlockedRecipes() or {}, Recipe.id)
	end)
	local v47 = Vide.derive(function() -- line: 290
		-- upvalues: CraftingServiceUtils (copy), Recipe (copy), t3 (copy)
		return CraftingServiceUtils.isRecipeVisible(Recipe, t3.UnlockedRecipes() or {})
	end)
	local v48 = Vide.derive(function() -- line: 293
		-- upvalues: CraftingSlice (copy), Recipe (copy)
		return CraftingSlice.activeRecipeId() == Recipe.id
	end)
	local v49 = Vide.derive(function() -- line: 296
		-- upvalues: t3 (copy), Recipe (copy)
		return (t3.Coins() or 0) >= (Recipe.unlockPrice or 0)
	end)
	local v50 = Vide.derive(function() -- line: 299
		-- upvalues: UpgradeServiceUtils (copy), t3 (copy)
		return UpgradeServiceUtils.getUnlockedMutations(t3.UpgradesOwned() or {})
	end)
	local v51 = Vide.derive(function() -- line: 302
		-- upvalues: v48 (copy), CraftingMenuUtils (copy), Recipe (copy), CraftingSlice (copy)
		if not v48() then
			return false
		end

		return CraftingMenuUtils.getFirstMissingIngredientIndex(Recipe, CraftingSlice.selectedIngredientUniqueIds() or {}) == nil
	end)
	local v52 = Vide.derive(function() -- line: 312
		-- upvalues: v48 (copy), CraftingSlice (copy), Recipe (copy), t3 (copy), CraftingServiceUtils (copy), InventoryServiceUtils (copy)
		if not v48() then
			return {}
		end

		local v67 = CraftingSlice.pickerIngredientIndex()
		local v68 = if not v67 then nil else Recipe.inputs[v67]

		if v68 == nil then
			return {}
		end

		local v69 = t3.Inventory() or {}
		local v70 = CraftingSlice.selectedIngredientUniqueIds() or {}
		local t4 = {}

		for v72, v73 in v70 do
			if v72 ~= v67 and type(v73) == "string" and v73 ~= "" then
				t4[v73] = (t4[v73] or 0) + 1
			end
		end

		local t5 = {}

		for _, v76 in CraftingServiceUtils.getIngredientInventoryEntries(v68, v69) do
			local v77 = v76.ownedAmount - (t4[v76.uniqueId] or 0)

			if v77 > 0 then
				t5[v76.uniqueId] = {
					slimeData = v76.slimeData,
					amount = v77,
					layoutOrder = -InventoryServiceUtils.getLayoutOrder(v76.slimeData),
					isSelected = v70[v67] == v76.uniqueId,
					showLevel = type(v69[v76.uniqueId]) == "table"
				}
			end
		end

		return t5
	end)
	local v53 = Vide.derive(function() -- line: 348
		-- upvalues: CraftingServiceUtils (copy), t3 (copy), CraftingSlice (copy)
		return CraftingServiceUtils.getSelectedSlimeDatas(t3.Inventory() or {}, CraftingSlice.selectedIngredientUniqueIds() or {})
	end)
	local v54 = Vide.derive(function() -- line: 354
		-- upvalues: CraftingServiceUtils (copy), Recipe (copy), t3 (copy), CraftingSlice (copy)
		return CraftingServiceUtils.getSelectedRecipeMaxCrafts(Recipe, t3.Inventory() or {}, CraftingSlice.selectedIngredientUniqueIds() or {})
	end)
	local v55 = Vide.derive(function() -- line: 361
		-- upvalues: v51 (copy), v54 (copy)
		return v51() and v54() > 1
	end)
	local v56 = Vide.derive(function() -- line: 364
		-- upvalues: CraftingServiceUtils (copy), Recipe (copy), v53 (copy), v50 (copy)
		return CraftingServiceUtils.getCraftMutationPreview(Recipe, v53(), v50())
	end)
	local v57 = Vide.derive(function() -- line: 367
		-- upvalues: IndexServiceUtils (copy), t3 (copy)
		return IndexServiceUtils.reconcileIndexData(t3.IndexData()).categories.basic.unlocked
	end)

	local function hasDiscoveredSlime(s1: string) -- line: 371
		-- upvalues: CraftingServiceUtils (copy), t3 (copy), v57 (copy)
		return CraftingServiceUtils.hasDiscoveredSlime(s1, t3.Inventory() or {}, v57())
	end
	local function beginSelection() -- line: 375
		-- upvalues: CraftingSlice (copy), Recipe (copy)
		CraftingSlice.clearSelection()
		CraftingSlice.activeRecipeId(Recipe.id)
		CraftingSlice.pickerIngredientIndex(1)
	end
	local function cancelSelection() -- line: 381
		-- upvalues: v48 (copy), CraftingSlice (copy)
		if v48() then
			CraftingSlice.clearSelection()
		end
	end
	local function selectIngredientUniqueId(s2: string) -- line: 387
		-- upvalues: v48 (copy), CraftingSlice (copy), CraftingMenuUtils (copy), Recipe (copy)
		if not v48() then
			return
		end

		local v80 = CraftingSlice.pickerIngredientIndex()

		if not v80 then
			return
		end

		local v81 = table.clone(CraftingSlice.selectedIngredientUniqueIds() or {})

		v81[v80] = s2
		CraftingSlice.selectedIngredientUniqueIds(v81)
		CraftingSlice.pickerIngredientIndex(CraftingMenuUtils.getFirstMissingIngredientIndex(Recipe, v81) or v80)
	end
	local function craftSelectedRecipe() -- line: 405
		-- upvalues: v51 (copy), Recipe (copy), CraftingSlice (copy), CraftingServiceClient (copy)
		if not v51() then
			return
		end

		local t6 = {}

		for i = 1, #Recipe.inputs do
			local v84 = CraftingSlice.selectedIngredientUniqueIds()[i]

			if type(v84) ~= "string" or v84 == "" then
				return
			end

			t6[i] = v84
		end

		if CraftingServiceClient:craftRecipe(Recipe.id, t6, CraftingSlice.activeMachineId()) then
			CraftingSlice.clearSelection()
		end
	end
	local function autoCraftSelectedRecipe(n3: number) -- line: 426
		-- upvalues: v51 (copy), Recipe (copy), CraftingSlice (copy), CraftingServiceClient (copy), Menu (copy)
		if not v51() then
			return
		end

		local t7 = {}

		for i = 1, #Recipe.inputs do
			local v88 = CraftingSlice.selectedIngredientUniqueIds()[i]

			if type(v88) ~= "string" or v88 == "" then
				return
			end

			t7[i] = v88
		end

		if CraftingServiceClient:startAutoCraft(Recipe.id, t7, n3, CraftingSlice.activeMachineId()) then
			CraftingSlice.clearSelection()
			Menu.closeCurrentMenu()
		end
	end

	return Vide.show(v47, function() -- line: 449
		-- upvalues: StylizedFrame (copy), v48 (copy), v46 (copy), v55 (copy), Vide (copy), OwnedContent (copy), Recipe (copy), hasDiscoveredSlime (copy), t3 (copy), beginSelection (copy), cancelSelection (copy), v52 (copy), v56 (copy), selectIngredientUniqueId (copy), v51 (copy), v54 (copy), craftSelectedRecipe (copy), autoCraftSelectedRecipe (copy), CraftingServiceUtils (copy), UnlockButton (copy), v49 (copy), CraftingServiceClient (copy), LockedDescriptionContent (copy)
		return StylizedFrame({
			Theme = "Black",
			Size = function() --[[ Size ]] -- line: 452
				-- upvalues: v48 (copy), v46 (copy), v55 (copy)
				if v48() and v46() then
					if v55() then
						return UDim2.new(1, -6, 0, 460)
					end

					return UDim2.new(1, -6, 0, 360)
				end

				return UDim2.new(1, -6, 0, 180)
			end,
			Vide.show(v46, function() -- line: 473
				-- upvalues: OwnedContent (copy), Recipe (copy), v48 (copy), hasDiscoveredSlime (copy), t3 (copy), beginSelection (copy), cancelSelection (copy), v52 (copy), v56 (copy), selectIngredientUniqueId (copy), v51 (copy), v55 (copy), v54 (copy), craftSelectedRecipe (copy), autoCraftSelectedRecipe (copy)
				return OwnedContent({
					Recipe = Recipe,
					IsActive = v48,
					HasDiscoveredSlime = hasDiscoveredSlime,
					Inventory = t3.Inventory,
					OnBeginSelection = beginSelection,
					OnCancelSelection = cancelSelection,
					PickerEntries = v52,
					MutationPreviewEntries = v56,
					OnSelectIngredientUniqueId = selectIngredientUniqueId,
					AllIngredientsSelected = v51,
					ShouldShowAutoCraft = v55,
					MaxAutoCrafts = v54,
					OnCraftSelectedRecipe = craftSelectedRecipe,
					OnAutoCraftSelectedRecipe = autoCraftSelectedRecipe
				})
			end, function() -- line: 490
				-- upvalues: CraftingServiceUtils (copy), Recipe (copy), UnlockButton (copy), v49 (copy), CraftingServiceClient (copy), LockedDescriptionContent (copy)
				if CraftingServiceUtils.canPurchaseRecipe(Recipe) then
					return UnlockButton(v49, Recipe.unlockPrice, function() -- line: 492
						-- upvalues: CraftingServiceClient (copy), Recipe (copy)
						return CraftingServiceClient:unlockRecipe(Recipe.id)
					end)
				end

				return LockedDescriptionContent(Recipe)
			end)
		})
	end)
end
