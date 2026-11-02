-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeCurrencyHeader, time of decompilation: Sun May  3 10:11:37 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local CurrencyLabel = require(ReplicatedStorage.Source.Features.App.Components.CurrencyLabel)
local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)

return function() -- line: 14
	-- upvalues: getDataSource (copy), SlideFrame (copy), UpgradeSlice (copy), DropShadow (copy), Frame (copy), UIPadding (copy), UIListLayout (copy), CurrencyLabel (copy), UpgradeServiceUtils (copy)
	local v11 = getDataSource("coins")
	local v12 = getDataSource("goop")
	local v13 = getDataSource("rollCurrency")
	local v14 = getDataSource("upgrades")

	return SlideFrame({
		Name = "CurrencyHeader",
		Shown = UpgradeSlice.shown,
		ShownPosition = UDim2.fromScale(0.5, 0.045),
		HiddenPosition = UDim2.fromScale(0.5, -0.08),
		CanStartShown = true,
		Size = UDim2.fromOffset(620, 52),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		ZIndex = 10,
		DropShadow({
			Name = "Shadow",
			ZIndex = 9,
			ImageTransparency = 0.2,
			Size = UDim2.fromScale(1.22, 1.9),
			Position = UDim2.fromScale(0.5, 0.46),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageColor3 = Color3.fromRGB(14, 18, 26)
		}),
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 10,
			UIPadding({
				PaddingLeft = UDim.new(0, 18),
				PaddingRight = UDim.new(0, 18)
			}),
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 24)
			}),
			CurrencyLabel({
				Name = "CoinsAmount",
				LayoutOrder = 1,
				Currency = "coins",
				Amount = v11,
				Size = UDim2.fromOffset(150, 50)
			}),
			CurrencyLabel({
				Name = "GoopAmount",
				LayoutOrder = 2,
				Currency = "goop",
				Visible = function() --[[ Visible ]] -- line: 71
					-- upvalues: UpgradeServiceUtils (copy), v14 (copy), v12 (copy)
					return UpgradeServiceUtils.ownsUpgrade("goop", v14() or {}) or (v12() or 0) > 0
				end,
				Amount = v12,
				Size = UDim2.fromOffset(150, 50)
			}),
			CurrencyLabel({
				Name = "RollCurrencyAmount",
				LayoutOrder = 3,
				Currency = "rollCurrency",
				Amount = v13,
				Size = UDim2.fromOffset(150, 50)
			})
		})
	})
end
