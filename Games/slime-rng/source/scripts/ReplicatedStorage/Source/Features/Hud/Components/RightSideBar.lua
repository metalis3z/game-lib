-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RightSideBar, time of decompilation: Sun May  3 10:11:26 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local BottomBarButton = require(script.Parent.BottomBarButton)
local IndexRewardUtils = require(ReplicatedStorage.Source.Features.Index.IndexRewardUtils)
local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local getUpgradeOwnership = require(ReplicatedStorage.Source.Features.Upgrades.Sources.getUpgradeOwnership)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return function() -- line: 15
	-- upvalues: getDataSource (copy), getUpgradeOwnership (copy), SlideFrame (copy), screenCoveredSource (copy), Frame (copy), UIListLayout (copy), BottomBarButton (copy), ImageIds (copy), Menu (copy), IndexRewardUtils (copy), RebirthServiceUtils (copy)
	local v13 = getDataSource("goop")
	local v14 = getDataSource("index")
	local v15 = getDataSource("rebirths")
	local v16 = getUpgradeOwnership("teleporter")

	return SlideFrame({
		Name = "RightSideBar",
		Shown = function() --[[ Shown ]] -- line: 23
			-- upvalues: screenCoveredSource (copy)
			return not screenCoveredSource()
		end,
		Size = UDim2.fromOffset(140, 1500),
		ShownPosition = UDim2.fromScale(0.99, 0.5),
		HiddenPosition = UDim2.fromScale(1.3, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Frame({
			Name = "ButtonStack",
			Size = UDim2.fromOffset(106, 430),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 18)
			}),
			BottomBarButton({
				Name = "ShopButton",
				Label = "SHOP",
				LayoutOrder = 1,
				Image = ImageIds.shop,
				Size = UDim2.fromOffset(101.60000000000001, 81.60000000000001),
				Activated = function() --[[ Activated ]] -- line: 52
					-- upvalues: Menu (copy)
					Menu.setOpenedMenu("Shop")
				end,
				TextPosition = UDim2.fromScale(0.5, 1),
				IconPosition = UDim2.fromScale(0.5, 0.5),
				ShadowPosition = UDim2.fromScale(0.5, 0.95)
			}),
			BottomBarButton({
				Name = "IndexButton",
				Label = "INDEX",
				LayoutOrder = 3,
				Image = ImageIds.index,
				Size = UDim2.fromOffset(98.27, 92.38),
				NotificationCount = function() --[[ NotificationCount ]] -- line: 66
					-- upvalues: IndexRewardUtils (copy), v14 (copy)
					return IndexRewardUtils.getClaimableRewardCount(v14())
				end,
				NotificationBadgeSize = UDim2.fromOffset(24, 24),
				NotificationBadgePosition = UDim2.fromScale(0.16, 0.15),
				NotificationBadgeAnchorPoint = Vector2.new(0.5, 0.5),
				Activated = function() --[[ Activated ]] -- line: 72
					-- upvalues: Menu (copy)
					Menu.setOpenedMenu("Index")
				end,
				TextPosition = UDim2.fromScale(0.5, 0.95),
				IconPosition = UDim2.fromScale(0.5, 0.54),
				ShadowPosition = UDim2.fromScale(0.5, 1)
			}),
			BottomBarButton({
				Name = "RebirthButton",
				Label = "REBIRTH",
				NotificationBadgeText = "!",
				LayoutOrder = 2,
				Image = ImageIds.rebirth,
				Size = UDim2.fromOffset(87.04, 83.30000000000001),
				NotificationCount = function() --[[ NotificationCount ]] -- line: 86
					-- upvalues: RebirthServiceUtils (copy), v15 (copy), v13 (copy)
					if RebirthServiceUtils.canAffordRebirth(v15(), v13()) then
						return 1
					end

					return 0
				end,
				NotificationBadgeSize = UDim2.fromOffset(24, 24),
				NotificationBadgePosition = UDim2.fromScale(0.1, 0.08),
				NotificationBadgeAnchorPoint = Vector2.new(0.5, 0.5),
				Activated = function() --[[ Activated ]] -- line: 96
					-- upvalues: Menu (copy)
					Menu.setOpenedMenu("Rebirth")
				end,
				TextPosition = UDim2.fromScale(0.5, 1),
				IconPosition = UDim2.fromScale(0.5, 0.55),
				ShadowPosition = UDim2.fromScale(0.5, 1.08)
			}),
			BottomBarButton({
				Name = "TeleporterButton",
				Label = "TELEPORT",
				LayoutOrder = 4,
				Image = ImageIds.teleporter,
				TextSize = UDim2.fromScale(1.4, 0.21),
				Size = UDim2.fromOffset(77.03999999999999, 94.32),
				Visible = v16,
				Activated = function() --[[ Activated ]] -- line: 112
					-- upvalues: Menu (copy)
					Menu.setOpenedMenu("Teleporter")
				end,
				TextPosition = UDim2.fromScale(0.5, 1),
				IconPosition = UDim2.fromScale(0.5, 0.5),
				ShadowPosition = UDim2.fromScale(0.5, 1.08)
			})
		})
	})
end
