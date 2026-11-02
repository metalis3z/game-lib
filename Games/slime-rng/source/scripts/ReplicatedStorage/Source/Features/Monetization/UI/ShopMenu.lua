-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopMenu, time of decompilation: Sun May  3 10:12:05 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local ShopLuckLadder = require(ReplicatedStorage.Source.Features.LuckLadder.UI.ShopLuckLadder)
local ShopBoosts = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopBoosts)
local ShopCoins = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopCoins)
local ShopCodes = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopCodes)
local ShopFood = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopFood)
local ShopJackpotSpins = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopJackpotSpins)
local ShopPacks = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopPacks)
local ShopPasses = require(ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopPasses)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return {
	menuId = "Shop",
	alwaysMounted = false,
	Component = function() --[[ ShopMenu ]] -- line: 15
		-- upvalues: Menu (copy), ScrollingFrame (copy), UIListLayout (copy), ShopLuckLadder (copy), ShopPasses (copy), ShopPacks (copy), ShopJackpotSpins (copy), ShopCodes (copy), ShopBoosts (copy), ShopCoins (copy), ShopFood (copy)
		return Menu.Component({
			menuId = "Shop",
			Title = "Shop",
			ScrollingFrame({
				Size = UDim2.fromScale(1, 1),
				CanvasSize = UDim2.fromScale(0, 0),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 0,
				BackgroundTransparency = 1,
				ScrollBarImageTransparency = 1,
				UIListLayout({
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 0)
				}),
				ShopLuckLadder(),
				ShopPasses(),
				ShopPacks(),
				ShopJackpotSpins(),
				ShopCodes(),
				ShopBoosts(),
				ShopCoins(),
				ShopFood()
			})
		})
	end
}
