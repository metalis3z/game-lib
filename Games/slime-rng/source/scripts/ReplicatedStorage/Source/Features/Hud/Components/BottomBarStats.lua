-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BottomBarStats, time of decompilation: Sun May  3 10:11:25 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local SlideFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.SlideFrame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local AdminLuckServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceClient)
local BoostServiceClient = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceClient)
local FriendsServiceClient = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceClient)
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local LuckHoverInfo = require(ReplicatedStorage.Source.Features.Hud.Components.LuckHoverInfo)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local useSetting = require(ReplicatedStorage.Source.Features.Settings.UI.Hooks.useSetting)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)

local function formatLuck(n1: number) -- line: 39
	-- upvalues: Abbreviate (copy)
	local v36 = math.round(n1 * 100) / 100

	if math.abs(v36) >= 1000 then
		return Abbreviate(v36, 4)
	end

	if v36 % 1 == 0 then
		return (tostring(v36))
	end

	return string.gsub(string.format("%.2f", v36), "%.?0+$", "")
end
local function formatRollSpeed(n2: number) -- line: 52
	return string.format("%.2fs", math.round(n2 * 100) / 100)
end
local function StatRow(t1: {[any]: any}) -- line: 56
	-- upvalues: Frame (copy), ImageLabel (copy), TextLabel (copy)
	return Frame({
		Name = t1.Name,
		Size = UDim2.fromOffset(64, 64),
		BackgroundTransparency = 1,
		LayoutOrder = t1.LayoutOrder,
		Visible = t1.Visible,
		ZIndex = 5,
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 6,
			ImageLabel({
				Name = "Icon",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(58, 58),
				Image = t1.Icon,
				ScaleType = Enum.ScaleType.Fit
			}),
			TextLabel({
				Name = "Value",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.6),
				Size = UDim2.fromOffset(48, 24),
				Text = t1.Value,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {},
				DropShadow = {}
			})
		})
	})
end
local function LuckStatRow(p1, p2, p3, p4, p5, p6, p7) -- line: 97
	-- upvalues: Vide (copy), useSetting (copy), Button (copy), Frame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), formatLuck (copy), RollSlice (copy), UICorner (copy), UIStroke (copy), LuckHoverInfo (copy)
	local v46 = Vide.source(false)
	local v47 = useSetting("luckOverrideEnabled")

	return Button({
		Name = "LuckStat",
		Image = "",
		Size = UDim2.fromOffset(64, 64),
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		HoverScale = 1,
		ZIndex = 5,
		OnEnter = function() --[[ OnEnter ]] -- line: 117
			-- upvalues: v46 (copy)
			v46(true)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 120
			-- upvalues: v46 (copy)
			v46(false)
		end,
		ClipsDescendants = false,
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 6,
			ImageLabel({
				Name = "Icon",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(58, 58),
				Image = ImageIds.luckIcons[1],
				ScaleType = Enum.ScaleType.Fit
			}),
			TextLabel({
				Name = "Value",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.6),
				Size = UDim2.fromOffset(48, 24),
				Text = function() --[[ Text ]] -- line: 146
					-- upvalues: formatLuck (copy), RollSlice (copy)
					return "x" .. formatLuck(RollSlice.luck() or 0)
				end,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {},
				DropShadow = {}
			}),
			Frame({
				Name = "OverrideWarning",
				Visible = v47,
				Size = UDim2.fromOffset(22, 22),
				Position = UDim2.fromScale(0.82, 0.18),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(230, 24, 48),
				ZIndex = 8,
				UICorner({
					CornerRadius = UDim.new(1, 0)
				}),
				UIStroke({
					Thickness = 2,
					Color = Color3.fromRGB(70, 0, 12)
				}),
				TextLabel({
					Text = "!",
					TextSize = 22,
					ZIndex = 9,
					Size = UDim2.fromScale(1, 1),
					Stroke = {
						Thickness = 2
					},
					DropShadow = {}
				})
			})
		}),
		LuckHoverInfo({
			Visible = v46,
			upgradesOwned = p1,
			furthestZone = p2,
			rebirths = p3,
			boosts = p4,
			friendCount = p5,
			indexData = p6,
			likeGroupLuckActive = p7,
			OverrideEnabled = v47
		})
	})
end
local function createBoostStatRow(_, p9) -- line: 200
	-- upvalues: StatRow (copy), ImageIds (copy), FormatTime (copy), BoostServiceClient (copy), BoostServiceUtils (copy)
	return StatRow({
		Name = `{ p9 }BoostStat`,
		Icon = ImageIds.boosts[p9],
		Value = function() --[[ Value ]] -- line: 204
			-- upvalues: FormatTime (copy), BoostServiceClient (copy), p9 (copy)
			return FormatTime(BoostServiceClient:getTimeRemaining(p9))
		end,
		LayoutOrder = 100 + BoostServiceUtils.getOrder(p9)
	})
end
local function createServerLuckStatRow() -- line: 211
	-- upvalues: StatRow (copy), ImageIds (copy), FormatTime (copy), LuckLadderServiceClient (copy)
	return StatRow({
		Name = "ServerLuckStat",
		LayoutOrder = 99,
		Icon = ImageIds.passes.luckyRolls,
		Value = function() --[[ Value ]] -- line: 215
			-- upvalues: FormatTime (copy), LuckLadderServiceClient (copy)
			return FormatTime(LuckLadderServiceClient:getTimeRemaining())
		end,
		Visible = function() --[[ Visible ]] -- line: 219
			-- upvalues: LuckLadderServiceClient (copy)
			return LuckLadderServiceClient:isActive()
		end
	})
end
local function createAdminLuckStatRow() -- line: 225
	-- upvalues: Vide (copy), Button (copy), AdminLuckServiceClient (copy), Frame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), FormatTime (copy), StylizedFrame (copy)
	local v50 = Vide.source(false)

	return Button({
		Name = "AdminLuckStat",
		Image = "",
		Size = UDim2.fromOffset(64, 64),
		BackgroundTransparency = 1,
		LayoutOrder = 98,
		Visible = function() --[[ Visible ]] -- line: 234
			-- upvalues: AdminLuckServiceClient (copy)
			return AdminLuckServiceClient:isActive()
		end,
		HoverScale = 1,
		ZIndex = 5,
		ClipsDescendants = false,
		OnEnter = function() --[[ OnEnter ]] -- line: 240
			-- upvalues: v50 (copy)
			v50(true)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 243
			-- upvalues: v50 (copy)
			v50(false)
		end,
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 6,
			ImageLabel({
				Name = "Icon",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(58, 58),
				Image = ImageIds.luckIcons[2],
				ScaleType = Enum.ScaleType.Fit
			}),
			TextLabel({
				Name = "Value",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.6),
				Size = UDim2.fromOffset(48, 24),
				Text = function() --[[ Text ]] -- line: 268
					-- upvalues: FormatTime (copy), AdminLuckServiceClient (copy)
					return FormatTime(AdminLuckServiceClient:getTimeRemaining())
				end,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {},
				DropShadow = {}
			})
		}),
		StylizedFrame({
			Name = "AdminLuckHoverInfo",
			Theme = "Black",
			Visible = v50,
			Size = UDim2.fromOffset(250, 112),
			Position = UDim2.fromScale(0.5, -0.12),
			AnchorPoint = Vector2.new(0.5, 1),
			ZIndex = 20,
			TextLabel({
				Text = "Admin Luck",
				TextSize = 22,
				ZIndex = 21,
				Size = UDim2.new(1, -20, 0, 32),
				Position = UDim2.fromScale(0.5, 0.12),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {
					Thickness = 2
				},
				DropShadow = {}
			}),
			TextLabel({
				TextSize = 17,
				TextWrapped = true,
				ZIndex = 21,
				Text = function() --[[ Text ]] -- line: 300
					-- upvalues: AdminLuckServiceClient (copy)
					return AdminLuckServiceClient:getDescription()
				end,
				Size = UDim2.new(1, -26, 0, 58),
				Position = UDim2.fromScale(0.5, 0.42),
				AnchorPoint = Vector2.new(0.5, 0),
				TextYAlignment = Enum.TextYAlignment.Top,
				Stroke = {
					Thickness = 1
				},
				DropShadow = {}
			})
		})
	})
end
local function createArmedSpecialDiceStatRow(p10, p11, p12, n3: number) -- line: 317
	-- upvalues: SpecialDiceServiceUtils (copy), Vide (copy), Button (copy), InventoryServiceClient (copy), Frame (copy), ImageLabel (copy), TextLabel (copy), StylizedFrame (copy)
	local v55 = SpecialDiceServiceUtils.getDefinition(p12)
	local v56 = Vide.source(false)

	return Button({
		Name = `{ p12 }ArmedSpecialDiceStat`,
		Image = "",
		Size = UDim2.fromOffset(64, 64),
		BackgroundTransparency = 1,
		LayoutOrder = n3,
		Visible = function() --[[ Visible ]] -- line: 332
			-- upvalues: SpecialDiceServiceUtils (copy), p10 (copy), p12 (copy), p11 (copy)
			return SpecialDiceServiceUtils.getCount(p10(), p12, p11()) > 0
		end,
		HoverScale = 1,
		ZIndex = 5,
		ClipsDescendants = false,
		OnEnter = function() --[[ OnEnter ]] -- line: 338
			-- upvalues: v56 (copy)
			v56(true)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 341
			-- upvalues: v56 (copy)
			v56(false)
		end,
		Activated = function() --[[ Activated ]] -- line: 344
			-- upvalues: SpecialDiceServiceUtils (copy), p10 (copy), p12 (copy), p11 (copy), InventoryServiceClient (copy)
			if SpecialDiceServiceUtils.getCount(p10(), p12, p11()) <= 0 then
				return
			end

			InventoryServiceClient:unarmSpecialDice(p12)
		end,
		Frame({
			Name = "Content",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 6,
			ImageLabel({
				Name = "Icon",
				ZIndex = 7,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(58, 58),
				Image = v55.icon,
				ScaleType = Enum.ScaleType.Fit
			}),
			TextLabel({
				Name = "CancelOverlay",
				Text = "X",
				TextSize = 42,
				ZIndex = 9,
				Visible = v56,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.48),
				Size = UDim2.fromOffset(48, 48),
				TextColor3 = Color3.fromRGB(255, 45, 45),
				Stroke = {
					Thickness = 4,
					Color = Color3.fromRGB(90, 0, 0)
				},
				DropShadow = {
					Offset = UDim2.fromOffset(2, 3)
				}
			}),
			TextLabel({
				Name = "Value",
				ZIndex = 8,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.6),
				Size = UDim2.fromOffset(48, 24),
				Text = function() --[[ Text ]] -- line: 387
					-- upvalues: SpecialDiceServiceUtils (copy), p10 (copy), p12 (copy), p11 (copy)
					return tostring(SpecialDiceServiceUtils.getCount(p10(), p12, p11())) .. "x"
				end,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {},
				DropShadow = {}
			})
		}),
		StylizedFrame({
			Name = "SpecialDiceHoverInfo",
			Theme = "Black",
			Visible = v56,
			Size = UDim2.fromOffset(230, 110),
			Position = UDim2.fromScale(0.5, -0.12),
			AnchorPoint = Vector2.new(0.5, 1),
			ZIndex = 20,
			TextLabel({
				TextSize = 22,
				ZIndex = 21,
				Text = v55.name,
				Size = UDim2.new(1, -20, 0, 32),
				Position = UDim2.fromScale(0.5, 0.12),
				AnchorPoint = Vector2.new(0.5, 0),
				Stroke = {
					Thickness = 2
				},
				DropShadow = {}
			}),
			TextLabel({
				TextSize = 17,
				TextWrapped = true,
				ZIndex = 21,
				Text = v55.description,
				Size = UDim2.new(1, -26, 0, 58),
				Position = UDim2.fromScale(0.5, 0.42),
				AnchorPoint = Vector2.new(0.5, 0),
				TextYAlignment = Enum.TextYAlignment.Top,
				Stroke = {
					Thickness = 1
				},
				DropShadow = {}
			})
		})
	})
end

return function() -- line: 434
	-- upvalues: Vide (copy), BoostServiceClient (copy), getDataSource (copy), FriendsServiceClient (copy), SpecialDiceServiceUtils (copy), createArmedSpecialDiceStatRow (copy), SlideFrame (copy), screenCoveredSource (copy), Frame (copy), UIListLayout (copy), LuckStatRow (copy), StatRow (copy), ImageIds (copy), formatRollSpeed (copy), RollSlice (copy), createAdminLuckStatRow (copy), createServerLuckStatRow (copy), createBoostStatRow (copy)
	local v57 = Vide.derive(function() -- line: 435
		-- upvalues: BoostServiceClient (copy)
		return BoostServiceClient:getActiveBoosts()
	end)
	local v58 = getDataSource("upgrades")
	local v59 = getDataSource("furthestZone")
	local v60 = getDataSource("rebirths")
	local v61 = getDataSource("boosts")
	local v62 = getDataSource("index")
	local v63 = getDataSource("armedSpecialDice")
	local v64 = getDataSource("armedJackpotSpins")
	local v65 = FriendsServiceClient:getFriendCountSource()
	local v66 = getDataSource("likeGroupLuckActive")
	local t2 = {}

	for v68, v69 in SpecialDiceServiceUtils.getInventoryItemIds() do
		table.insert(t2, createArmedSpecialDiceStatRow(v63, v64, v69, 90 + v68))
	end

	return SlideFrame({
		Name = "BottomBarStats",
		Shown = function() --[[ Shown ]] -- line: 457
			-- upvalues: screenCoveredSource (copy)
			return not screenCoveredSource()
		end,
		CanStartShown = true,
		ShownPosition = UDim2.fromScale(0.015, 0.965),
		HiddenPosition = UDim2.fromScale(-0.25, 0.965),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.fromOffset(0, 64),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		ZIndex = 5,
		Frame({
			Name = "StatsList",
			Size = UDim2.fromOffset(0, 64),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 8)
			}),
			LuckStatRow(v58, v59, v60, v61, v65, v62, v66),
			StatRow({
				Name = "RollSpeedStat",
				LayoutOrder = 2,
				Icon = ImageIds.dice,
				Value = function() --[[ Value ]] -- line: 488
					-- upvalues: formatRollSpeed (copy), RollSlice (copy)
					return formatRollSpeed(RollSlice.rollSpeed() or 0)
				end
			}),
			t2,
			createAdminLuckStatRow(),
			createServerLuckStatRow(),
			Vide.indexes(v57, createBoostStatRow)
		})
	})
end
