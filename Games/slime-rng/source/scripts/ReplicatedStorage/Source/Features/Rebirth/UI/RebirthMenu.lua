-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthMenu, time of decompilation: Sun May  3 10:11:40 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local RebirthServiceClient = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceClient)
local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local RebirthProgressBar = require(ReplicatedStorage.Source.Features.Rebirth.UI.Components.RebirthProgressBar)
local RebirthStatRow = require(ReplicatedStorage.Source.Features.Rebirth.UI.Components.RebirthStatRow)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return {
	menuId = "Rebirth",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 26
		-- upvalues: getDataSource (copy), Vide (copy), RebirthServiceUtils (copy), Menu (copy), Frame (copy), TextLabel (copy), UIListLayout (copy), RebirthStatRow (copy), ImageIds (copy), Abbreviate (copy), RebirthProgressBar (copy), StylizedButton (copy), RebirthServiceClient (copy)
		local v17 = getDataSource("coins")
		local v18 = getDataSource("goop")
		local v19 = getDataSource("rebirths")
		local v20 = getDataSource("maxZone")
		local v21 = Vide.derive(function() -- line: 32
			-- upvalues: RebirthServiceUtils (copy), v18 (copy), v19 (copy)
			return RebirthServiceUtils.getRemainingGoop(v18(), v19())
		end)

		return Menu.Component({
			menuId = "Rebirth",
			Title = "Rebirth",
			Frame({
				Name = "RebirthContent",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				TextLabel({
					Text = "Slimes, upgrades and items are all kept!",
					ZIndex = 2,
					Size = UDim2.fromOffset(500, 28),
					Position = UDim2.fromScale(0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					Stroke = {},
					DropShadow = {},
					TextColor3 = Color3.fromRGB(158, 255, 145)
				}),
				Frame({
					Name = "Rows",
					Size = UDim2.new(1, 0, 0, 338),
					Position = UDim2.new(0.525, 0, 0, 40),
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 1,
					UIListLayout({
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Top,
						Padding = UDim.new(0, 4)
					}),
					RebirthStatRow({
						LayoutOrder = 1,
						RightValue = "0",
						Icon = ImageIds.coin,
						IconPosition = UDim2.fromScale(0, 0.45),
						IconSize = UDim2.fromOffset(80, 80),
						LeftValue = function() --[[ LeftValue ]] -- line: 75
							-- upvalues: Abbreviate (copy), v17 (copy)
							return Abbreviate(v17(), 3)
						end,
						RightValueColor = Color3.fromRGB(255, 145, 145)
					}),
					RebirthStatRow({
						LayoutOrder = 1,
						RightValue = "1",
						Icon = ImageIds.zoneInvert,
						IconPosition = UDim2.fromScale(-0.05, 0.425),
						IconSize = UDim2.fromOffset(84, 84),
						LeftValue = function() --[[ LeftValue ]] -- line: 87
							-- upvalues: v20 (copy)
							return v20()
						end,
						RightValueColor = Color3.fromRGB(255, 145, 145)
					}),
					RebirthStatRow({
						LayoutOrder = 2,
						Icon = ImageIds.goop,
						IconPosition = UDim2.fromScale(-0.01, 0.45),
						IconSize = UDim2.fromOffset(88, 88),
						LeftValue = function() --[[ LeftValue ]] -- line: 99
							-- upvalues: Abbreviate (copy), v18 (copy)
							return Abbreviate(v18(), 3)
						end,
						RightValue = function() --[[ RightValue ]] -- line: 102
							-- upvalues: Abbreviate (copy), v21 (copy)
							return Abbreviate(v21(), 3)
						end,
						RightValueColor = function() --[[ RightValueColor ]] -- line: 105
							-- upvalues: v21 (copy)
							if v21() >= 0 then
								return (Color3.fromRGB(255, 145, 145))
							end

							return (Color3.fromRGB(255, 41, 41))
						end
					}),
					RebirthStatRow({
						LayoutOrder = 3,
						Icon = ImageIds.luckIcons[1],
						IconPosition = UDim2.fromScale(-0.01, 0.45),
						IconSize = UDim2.fromOffset(88, 88),
						LeftValue = function() --[[ LeftValue ]] -- line: 117
							-- upvalues: RebirthServiceUtils (copy), v19 (copy), Abbreviate (copy)
							local v22 = math.round(RebirthServiceUtils.getLuckMultiplier(v19()) * 100) / 100

							if v22 >= 1000 then
								return Abbreviate(v22, 4) .. "x"
							end

							return string.gsub(string.format("%.2f", v22), "%.?0+$", "") .. "x"
						end,
						RightValue = function() --[[ RightValue ]] -- line: 120
							-- upvalues: RebirthServiceUtils (copy), v19 (copy), Abbreviate (copy)
							local v23 = math.round(RebirthServiceUtils.getLuckMultiplier((v19() or 0) + 1) * 100) / 100

							if v23 >= 1000 then
								return Abbreviate(v23, 4) .. "x"
							end

							return string.gsub(string.format("%.2f", v23), "%.?0+$", "") .. "x"
						end,
						RightValueColor = Color3.fromRGB(186, 255, 139)
					})
				}),
				Frame({
					Name = "Footer",
					Size = UDim2.new(1, -18, 0, 105),
					Position = UDim2.fromScale(0.5, 1),
					AnchorPoint = Vector2.new(0.5, 1),
					RebirthProgressBar({
						Current = function() --[[ Current ]] -- line: 134
							-- upvalues: v18 (copy)
							return v18() or 0
						end,
						Required = function() --[[ Required ]] -- line: 137
							-- upvalues: RebirthServiceUtils (copy), v19 (copy)
							return RebirthServiceUtils.getCost(v19() or 0)
						end,
						Size = UDim2.fromOffset(340, 72),
						Position = UDim2.new(0, 6, 1, -4),
						AnchorPoint = Vector2.new(0, 1)
					}),
					TextLabel({
						Name = "RebirthCount",
						ZIndex = 2,
						Text = function() --[[ Text ]] -- line: 147
							-- upvalues: v19 (copy)
							return `You have { v19() } rebirth{ v19() ~= 1 and "s" or "" }`
						end,
						Size = UDim2.fromOffset(170, 24),
						Position = UDim2.fromScale(0.8, 0.05),
						AnchorPoint = Vector2.new(0.5, 0),
						Stroke = {}
					}),
					StylizedButton({
						Name = "RebirthButton",
						Text = "REBIRTH",
						HoverScale = 1.05,
						ZIndex = 2,
						Theme = function() --[[ Theme ]] -- line: 159
							-- upvalues: RebirthServiceUtils (copy), v19 (copy), v18 (copy)
							if RebirthServiceUtils.canAffordRebirth(v19() or 0, v18() or 0) then
								return "Green"
							end

							return "Grey"
						end,
						Size = UDim2.fromOffset(210, 80),
						Position = UDim2.fromScale(0.8, 0.66),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Activated = function() --[[ Activated ]] -- line: 170
							-- upvalues: RebirthServiceClient (copy)
							RebirthServiceClient:attemptRebirth()
						end
					})
				})
			})
		})
	end
}
