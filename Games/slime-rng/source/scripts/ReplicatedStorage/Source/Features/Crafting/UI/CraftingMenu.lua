-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CraftingMenu, time of decompilation: Sun May  3 10:12:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local CraftingSlice = require(ReplicatedStorage.Source.Features.Crafting.CraftingSlice)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local CraftingServiceUtils = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceUtils)
local CraftingRecipeCard = require(ReplicatedStorage.Source.Features.Crafting.UI.Components.CraftingRecipeCard)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)

return {
	menuId = "Crafting",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 14
		-- upvalues: CraftingServiceUtils (copy), getDataSource (copy), CraftingRecipeCard (copy), Menu (copy), CraftingSlice (copy), ScrollingFrame (copy), UIListLayout (copy), UIPadding (copy)
		local v10 = CraftingServiceUtils.getRecipes()
		local v11 = getDataSource("inventory")
		local v12 = getDataSource("index")
		local v13 = getDataSource("craftingRecipes")
		local v14 = getDataSource("coins")
		local v15 = getDataSource("upgrades")
		local t1 = {}

		for _, v18 in v10 do
			table.insert(t1, (CraftingRecipeCard({
				Recipe = v18,
				Inventory = v11,
				IndexData = v12,
				UnlockedRecipes = v13,
				Coins = v14,
				UpgradesOwned = v15
			})))
		end

		return Menu.Component({
			menuId = "Crafting",
			Title = "Crafting",
			OnClose = function() --[[ OnClose ]] -- line: 39
				-- upvalues: CraftingSlice (copy), Menu (copy)
				CraftingSlice.clearSelection()
				CraftingSlice.activeMachineId(nil)
				Menu.setOpenedMenu(nil)
			end,
			ScrollingFrame({
				Size = UDim2.fromScale(1, 1),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 0,
				ScrollBarImageTransparency = 1,
				BackgroundTransparency = 1,
				UIListLayout({
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 8)
				}),
				UIPadding({
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 4)
				}),
				t1
			})
		})
	end
}
