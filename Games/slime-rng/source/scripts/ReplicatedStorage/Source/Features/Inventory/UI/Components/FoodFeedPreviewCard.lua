-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FoodFeedPreviewCard, time of decompilation: Sun May  3 10:11:28 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local OddsGradients = require(ReplicatedStorage.Source.Game.Items.OddsGradients)
local RarityTiers = require(ReplicatedStorage.Source.Game.Items.RarityTiers)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)
local rect = Rect.new(28, 22, 107, 100)
local color3 = Color3.fromRGB(48, 48, 48)
local color3_2 = Color3.fromRGB(116, 255, 122)

local function Divider(n1: number, n2: number?) -- line: 34
	-- upvalues: Frame (copy), UIGradient (copy)
	return Frame({
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		LayoutOrder = n1,
		BorderSizePixel = 0,
		Size = UDim2.new(n2 or 0.7, 0, 0, 5),
		UIGradient({
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.4, 0),
				NumberSequenceKeypoint.new(0.6, 0),
				NumberSequenceKeypoint.new(1, 1)
			})
		})
	})
end
local function getXpBarTransparency(n3: number) -- line: 60
	local v32 = math.clamp(n3, 0, 1)

	if v32 <= 0 then
		return NumberSequence.new(1)
	end

	if v32 >= 1 then
		return NumberSequence.new(0)
	end

	local v33 = math.max(v32 - 0.001, 0)
	local v34 = math.min(v32 + 0.001, 1)

	return NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(v33, 0),
		NumberSequenceKeypoint.new(v34, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
end
local function StatLabel(s1: string, p1: ((...any) -> ...any), n4: number, s2: string, p2) -- line: 79
	-- upvalues: TextLabel (copy)
	return TextLabel({
		TextSize = 28,
		Name = s1,
		Text = p1,
		Size = UDim2.new(0.86, 0, 0, 30),
		LayoutOrder = n4,
		TextColor3 = p2,
		Stroke = {},
		Prefix = {
			Image = s2,
			Size = UDim2.fromScale(0.8, 0.8),
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			Padding = UDim.new(0, 8)
		}
	})
end
local function XpBar(p3: ((...any) -> ...any), n5: number) -- line: 103
	-- upvalues: Frame (copy), UIGradient (copy), UICorner (copy), UIStroke (copy), TextLabel (copy), Abbreviate (copy), getXpBarTransparency (copy)
	return Frame({
		Name = "XpBarBack",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Size = UDim2.new(0.731, 0, 0, 18),
		ClipsDescendants = true,
		BorderSizePixel = 0,
		LayoutOrder = n5,
		UIGradient({
			Rotation = 90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 49, 54)),
				ColorSequenceKeypoint.new(0.3, Color3.fromRGB(92, 100, 112)),
				ColorSequenceKeypoint.new(0.9, Color3.fromRGB(92, 100, 112)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 49, 54))
			})
		}),
		UICorner({
			CornerRadius = UDim.new(1, 0)
		}),
		UIStroke({
			Thickness = 2,
			Color = Color3.fromRGB(0, 0, 0)
		}),
		TextLabel({
			Name = "XpLabel",
			TextSize = 16,
			ZIndex = 9,
			Text = function() --[[ Text ]] -- line: 137
				-- upvalues: p3 (copy), Abbreviate (copy)
				local v70 = p3()

				return `{ Abbreviate(v70.xp) }/{ Abbreviate(v70.xpRequired) } XP`
			end,
			Size = UDim2.new(1, 0, 0, 16),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {}
		}),
		Frame({
			Name = "XpBarFill",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0,
			Size = UDim2.fromScale(1, 1),
			BorderSizePixel = 0,
			UICorner({
				CornerRadius = UDim.new(1, 0)
			}),
			UIGradient({
				Rotation = 0,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 220, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(132, 255, 255))
				}),
				Transparency = function() --[[ Transparency ]] -- line: 166
					-- upvalues: getXpBarTransparency (copy), p3 (copy)
					return getXpBarTransparency(p3().progress)
				end
			})
		})
	})
end
local function SlimeInfoPanel(s3: string, n6: number, p4: ((...any) -> ...any), p5: ((...any) -> ...any), p6: ((...any) -> ...any), p7: ((...any) -> ...any), p8: ((...any) -> ...any), p9: ((...any) -> ...any), p10: ((...any) -> ...any)?, p11: ((...any) -> ...any)?) -- line: 174
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy), Frame (copy), TextLabel (copy), Mutations (copy), Abbreviate (copy), color3 (copy), OddsGradients (copy), Divider (copy), StatLabel (copy), InventoryServiceUtils (copy), color3_2 (copy), Vide (copy), XpBar (copy), UIListLayout (copy)
	return ImageLabel({
		Name = s3,
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromOffset(208, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = n6,
		Frame({
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0, 3)
		}),
		TextLabel({
			Name = "SlimeName",
			LayoutOrder = 4,
			Text = function() --[[ Text ]] -- line: 199
				-- upvalues: Mutations (copy), p5 (copy), p4 (copy)
				return Mutations.getDisplayName(p5().name, p4().mutations)
			end,
			Size = UDim2.new(1, 0, 0, 32),
			Stroke = {}
		}),
		TextLabel({
			Name = "Odds",
			LayoutOrder = 10,
			Text = function() --[[ Text ]] -- line: 209
				-- upvalues: Abbreviate (copy), p6 (copy)
				return `1/{ Abbreviate((math.ceil(1 / p6()))) }`
			end,
			Size = UDim2.new(1, 0, 0, 26),
			Stroke = {
				Color = color3
			},
			Gradient = {
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 216
					-- upvalues: OddsGradients (copy), p6 (copy)
					return OddsGradients.getGradient(p6())
				end
			}
		}),
		TextLabel({
			Name = "Rarity",
			LayoutOrder = 12,
			Text = function() --[[ Text ]] -- line: 225
				-- upvalues: p7 (copy)
				return p7().name
			end,
			Size = UDim2.new(1, 0, 0, 24),
			Stroke = {
				Color = color3
			},
			Gradient = {
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 232
					-- upvalues: p7 (copy)
					return p7().gradient
				end
			}
		}),
		Divider(18, 0.8),
		Frame({
			LayoutOrder = 19,
			Size = UDim2.new(1, 0, 0, 6)
		}),
		StatLabel("Damage", function() -- line: 242
			-- upvalues: Abbreviate (copy), InventoryServiceUtils (copy), p8 (copy)
			return Abbreviate((math.round((InventoryServiceUtils.getDpsFromStats(p8())))))
		end, 20, ImageIds.damageIcon, function() -- line: 244
			-- upvalues: p11 (copy), InventoryServiceUtils (copy), p8 (copy), color3_2 (copy)
			if p11 and InventoryServiceUtils.getDpsFromStats(p8()) > InventoryServiceUtils.getDpsFromStats(p11()) then
				return color3_2
			end

			return Color3.fromRGB(255, 255, 255)
		end),
		StatLabel("Health", function() -- line: 256
			-- upvalues: Abbreviate (copy), p8 (copy)
			return Abbreviate(p8().maxHealth)
		end, 22, ImageIds.healthIcon, function() -- line: 258
			-- upvalues: p11 (copy), p8 (copy), color3_2 (copy)
			if p11 and p8().maxHealth > p11().maxHealth then
				return color3_2
			end

			return Color3.fromRGB(255, 255, 255)
		end),
		TextLabel({
			Name = "Level",
			LayoutOrder = 30,
			TextSize = 20,
			Text = function() --[[ Text ]] -- line: 268
				-- upvalues: p4 (copy)
				return `Level { p4().level }`
			end,
			Size = UDim2.new(0.86, 0, 0, 30),
			TextColor3 = function() --[[ TextColor3 ]] -- line: 274
				-- upvalues: p10 (copy), p4 (copy), color3_2 (copy)
				if p10 and p4().level > p10().level then
					return color3_2
				end

				return Color3.fromRGB(255, 255, 255)
			end,
			Stroke = {}
		}),
		Vide.show(function() -- line: 284
			-- upvalues: p9 (copy)
			return p9().showBar
		end, function() -- line: 286
			-- upvalues: XpBar (copy), p9 (copy)
			return XpBar(p9, 32)
		end),
		Frame({
			LayoutOrder = 999,
			Size = UDim2.new(1, 0, 0, 36)
		}),
		UIListLayout({
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 0)
		})
	})
end
local function ComparisonColumn(s4: string, s5: string, n7: number, p12) -- line: 300
	-- upvalues: Frame (copy), TextLabel (copy), UIListLayout (copy)
	return Frame({
		Name = s4,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(214, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = n7,
		TextLabel({
			Name = "ComparisonLabel",
			LayoutOrder = 1,
			TextSize = 18,
			Text = s5,
			Size = UDim2.new(1, 0, 0, 24),
			Stroke = {}
		}),
		Frame({
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, 6)
		}),
		p12,
		UIListLayout({
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 0)
		})
	})
end
local function ComparisonArrow(n8: number) -- line: 333
	-- upvalues: Frame (copy), TextLabel (copy)
	return Frame({
		Name = "ComparisonArrow",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(36, 260),
		LayoutOrder = n8,
		TextLabel({
			Name = "ArrowLabel",
			Text = ">",
			TextSize = 44,
			Size = UDim2.fromScale(1, 1),
			Stroke = {}
		})
	})
end

return function(t1: {[any]: any}) -- line: 350
	-- upvalues: Vide (copy), InventoryServiceUtils (copy), Slimes (copy), RarityTiers (copy), Frame (copy), ComparisonColumn (copy), SlimeInfoPanel (copy), ComparisonArrow (copy), UIListLayout (copy)
	local v58 = Vide.derive(function() -- line: 351
		-- upvalues: InventoryServiceUtils (copy), Vide (copy), t1 (copy)
		return InventoryServiceUtils.reconcileSlimeData(Vide.read(t1.CurrentSlimeData))
	end)
	local v59 = Vide.derive(function() -- line: 354
		-- upvalues: InventoryServiceUtils (copy), Vide (copy), t1 (copy)
		return InventoryServiceUtils.reconcileSlimeData(Vide.read(t1.PreviewSlimeData))
	end)
	local v60 = Vide.derive(function() -- line: 357
		-- upvalues: Slimes (copy), v58 (copy)
		return Slimes.getSlime(v58().id)
	end)
	local v61 = Vide.derive(function() -- line: 360
		-- upvalues: Slimes (copy), v59 (copy)
		return Slimes.getSlime(v59().id)
	end)
	local v62 = Vide.derive(function() -- line: 363
		-- upvalues: InventoryServiceUtils (copy), v58 (copy)
		return InventoryServiceUtils.getVisualOdds(v58())
	end)
	local v63 = Vide.derive(function() -- line: 366
		-- upvalues: InventoryServiceUtils (copy), v59 (copy)
		return InventoryServiceUtils.getVisualOdds(v59())
	end)
	local v64 = Vide.derive(function() -- line: 369
		-- upvalues: RarityTiers (copy), v62 (copy)
		return RarityTiers.getTier(v62())
	end)
	local v65 = Vide.derive(function() -- line: 372
		-- upvalues: RarityTiers (copy), v63 (copy)
		return RarityTiers.getTier(v63())
	end)
	local v66 = Vide.derive(function() -- line: 375
		-- upvalues: InventoryServiceUtils (copy), v58 (copy)
		return InventoryServiceUtils.getSlimeStatsFromData(v58())
	end)
	local v67 = Vide.derive(function() -- line: 378
		-- upvalues: InventoryServiceUtils (copy), v59 (copy)
		return InventoryServiceUtils.getSlimeStatsFromData(v59())
	end)
	local v68 = Vide.derive(function() -- line: 381
		-- upvalues: InventoryServiceUtils (copy), v58 (copy)
		return InventoryServiceUtils.getLevelProgress(v58())
	end)
	local v69 = Vide.derive(function() -- line: 384
		-- upvalues: InventoryServiceUtils (copy), v59 (copy)
		return InventoryServiceUtils.getLevelProgress(v59())
	end)

	return Frame({
		Name = "FoodFeedPreviewCard",
		Size = UDim2.fromOffset(490, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = t1.Position,
		AnchorPoint = t1.AnchorPoint,
		BackgroundTransparency = 1,
		ComparisonColumn("BeforeColumn", "Before", 1, SlimeInfoPanel("BeforePanel", 3, v58, v60, v62, v64, v66, v68, nil, nil)),
		ComparisonArrow(2),
		ComparisonColumn("AfterColumn", "After Feed", 3, SlimeInfoPanel("AfterPanel", 3, v59, v61, v63, v65, v67, v69, v58, v66)),
		UIListLayout({
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Padding = UDim.new(0, 8)
		})
	})
end
