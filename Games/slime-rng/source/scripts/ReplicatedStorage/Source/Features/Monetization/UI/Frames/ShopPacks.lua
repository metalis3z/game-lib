-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopPacks, time of decompilation: Sun May  3 10:12:09 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local SlimeButton = require(ReplicatedStorage.Source.Features.App.Components.SlimeButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local rect = Rect.new(52, 60, 52, 60)
local t1 = {
	id = "mushy",
	level = 1,
	xp = 0
}
local v21 = math.max(1, (math.ceil(1 / Slimes.getSlime(t1.id).odds)))
local t2 = {
	mushy = {
		title = "Mushy",
		amount = "Starter Pet",
		description = "A strong early-game slime to kick off your team.",
		titleGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 88, 172)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 34))
		})
	},
	coins = {
		title = "Coins",
		amount = "100K",
		description = "Instantly grants 100,000 coins.",
		titleGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 125)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 178, 46))
		})
	},
	luckBoost = {
		title = "Luck Boost",
		amount = "x3",
		description = "+1 Luck for 3 mins each. Activate in Backpack -> Items.",
		titleGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(174, 255, 110)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 214, 84))
		})
	},
	rollSpeedBoost = {
		title = "Roll Speed Boost",
		amount = "x2",
		description = "x2 faster rolls for 3 mins each. Activate in Backpack -> Items.",
		titleGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(105, 225, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(62, 133, 255))
		})
	},
	apple = {
		title = "Apples",
		amount = "x10",
		description = "Feed slimes for +75 XP each.",
		titleGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 99, 99)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(133, 221, 74))
		})
	}
}

local function RewardTitle(s1: string) -- line: 90
	-- upvalues: TextLabel (copy), t2 (copy)
	return TextLabel({
		TextSize = 20,
		TextWrapped = true,
		ZIndex = 4,
		Text = t2[s1].title,
		Size = UDim2.fromScale(0.9, 0.33),
		TextYAlignment = Enum.TextYAlignment.Top,
		Position = UDim2.fromScale(0.5, 0.08),
		AnchorPoint = Vector2.new(0.5, 0),
		Stroke = {
			Thickness = 2
		},
		Gradient = {
			Rotation = 90,
			Color = t2[s1].titleGradient
		}
	})
end
local function RewardSquare(n1: number, p1) -- line: 108
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy)
	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromOffset(120, 120),
		LayoutOrder = n1,
		ZIndex = 2,
		p1
	})
end
local function RewardHoverInfo(s2: string, p2) -- line: 121
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy), t2 (copy)
	return ImageLabel({
		Name = "RewardHoverInfo",
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Visible = function() --[[ Visible ]] -- line: 127
			-- upvalues: p2 (copy), s2 (copy)
			return p2() == s2
		end,
		Size = UDim2.fromOffset(230, 160),
		Position = UDim2.fromScale(0.5, 0.9),
		AnchorPoint = Vector2.new(0.5, 0),
		ZIndex = 20,
		TextLabel({
			Text = function() --[[ Text ]] -- line: 136
				-- upvalues: t2 (copy), s2 (copy)
				return t2[s2].title
			end,
			Size = UDim2.new(0.9, 0, 0, 36),
			Position = UDim2.fromScale(0.5, 0.05),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2
			},
			Gradient = {
				Rotation = 90,
				Color = function() --[[ Color ]] -- line: 145
					-- upvalues: t2 (copy), s2 (copy)
					return t2[s2].titleGradient
				end
			}
		}),
		TextLabel({
			Text = function() --[[ Text ]] -- line: 152
				-- upvalues: t2 (copy), s2 (copy)
				return t2[s2].amount
			end,
			Size = UDim2.new(1, -20, 0, 30),
			Position = UDim2.fromScale(0.5, 0.25),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2
			},
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}),
		TextLabel({
			TextSize = 20,
			TextWrapped = true,
			Text = function() --[[ Text ]] -- line: 163
				-- upvalues: t2 (copy), s2 (copy)
				return t2[s2].description
			end,
			TextYAlignment = Enum.TextYAlignment.Top,
			Size = UDim2.new(1, -30, 0, 65),
			Position = UDim2.fromScale(0.5, 0.45),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 2
			}
		})
	})
end
local function StaticRewardSlot(p3) -- line: 177
	-- upvalues: Button (copy), ImageIds (copy), rect (copy), RewardTitle (copy), ImageLabel (copy), TextLabel (copy), RewardHoverInfo (copy)
	return Button({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromOffset(120, 120),
		LayoutOrder = p3.LayoutOrder,
		HoverScale = 1,
		OnEnter = function() --[[ OnEnter ]] -- line: 185
			-- upvalues: p3 (copy)
			p3.HoveredReward(p3.HoverKey)
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 188
			-- upvalues: p3 (copy)
			if p3.HoveredReward() == p3.HoverKey then
				p3.HoveredReward(nil)
			end
		end,
		RewardTitle(p3.HoverKey),
		ImageLabel({
			ZIndex = 3,
			Image = p3.Image,
			Size = p3.ImageSize or UDim2.fromScale(0.7, 0.7),
			Position = p3.ImagePosition or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 4,
			Text = p3.Amount,
			Size = UDim2.fromScale(0.8, 0.25),
			Position = UDim2.fromScale(0.9, 0.9),
			AnchorPoint = Vector2.new(1, 1),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {}
		}),
		RewardHoverInfo(p3.HoverKey, p3.HoveredReward)
	})
end
local function StarterPackFrame(p4) -- line: 224
	-- upvalues: Vide (copy), Food (copy), StylizedFrame (copy), TextLabel (copy), Frame (copy), UIListLayout (copy), RewardSquare (copy), RewardTitle (copy), SlimeButton (copy), t1 (copy), StaticRewardSlot (copy), ImageIds (copy), Abbreviate (copy), RobuxButton (copy), Products (copy)
	local v37 = Vide.source(nil)
	local v38 = assert(Food.getFood("apple"), "Missing apple food definition for starter pack")

	return StylizedFrame({
		Name = "StarterPack",
		Theme = "Yellow",
		Size = UDim2.new(1, 0, 0, 250),
		LayoutOrder = p4.LayoutOrder,
		ZIndex = 9,
		TextLabel({
			Text = "\238\128\130499",
			Size = UDim2.new(0.3, 0, 0, 40),
			Position = UDim2.fromScale(0.865, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {},
			Frame({
				BackgroundTransparency = 0,
				Rotation = -10,
				Size = UDim2.fromOffset(140, 2),
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
		}),
		TextLabel({
			Text = "Starter Pack",
			ZIndex = 2,
			Size = UDim2.fromScale(1, 0.28),
			Position = UDim2.fromScale(0.5, 0.06),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 4,
				Color = Color3.fromRGB(34, 34, 34)
			},
			Gradient = {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 199, 46))
				})
			}
		}),
		Frame({
			Name = "RewardRow",
			Size = UDim2.fromScale(0.7, 0.5),
			Position = UDim2.fromScale(0.025, 0.9),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 2,
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, -2)
			}),
			RewardSquare(1, Frame({
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				RewardTitle("mushy"),
				SlimeButton({
					ZIndex = 3,
					IconScale = 0.9,
					Size = UDim2.fromScale(0.84, 0.84),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					SlimeData = t1,
					IconPosition = UDim2.fromScale(0.5, 0.9)
				})
			})),
			StaticRewardSlot({
				LayoutOrder = 2,
				HoverKey = "coins",
				HoveredReward = v37,
				Image = ImageIds.coin,
				ImageSize = UDim2.fromScale(0.62, 0.62),
				Amount = Abbreviate(100000)
			}),
			StaticRewardSlot({
				LayoutOrder = 3,
				HoverKey = "luckBoost",
				Amount = "x3",
				HoveredReward = v37,
				Image = ImageIds.boosts.luck,
				ImageSize = UDim2.fromScale(0.72, 0.72)
			}),
			StaticRewardSlot({
				LayoutOrder = 4,
				HoverKey = "rollSpeedBoost",
				Amount = "x2",
				HoveredReward = v37,
				Image = ImageIds.boosts.rollSpeed,
				ImageSize = UDim2.fromScale(0.72, 0.72)
			}),
			StaticRewardSlot({
				LayoutOrder = 5,
				HoverKey = "apple",
				Amount = "x10",
				HoveredReward = v37,
				Image = v38.icon,
				ImageSize = UDim2.fromScale(0.68, 0.68)
			})
		}),
		RobuxButton({
			Product = Products.starterPack,
			Position = UDim2.fromScale(0.97, 0.85),
			Size = UDim2.fromOffset(180, 65),
			AnchorPoint = Vector2.new(1, 1)
		})
	})
end

return function() -- line: 349
	-- upvalues: Vide (copy), MonetizationServiceClient (copy), Products (copy), getDataSource (copy), client (copy), StarterPackFrame (copy), v21 (copy)
	local v39 = Vide.source(MonetizationServiceClient:ownsOneTimePurchase(Products.starterPack))
	local v40 = getDataSource({
		"stats",
		"rarestRoll"
	})
	local connection = client:getChangedSignal("__oneTimePurchases"):Connect(function() -- line: 352
		-- upvalues: v39 (copy), MonetizationServiceClient (copy), Products (copy)
		v39(MonetizationServiceClient:ownsOneTimePurchase(Products.starterPack))
	end)

	Vide.cleanup(function() -- line: 356
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return Vide.show(function() -- line: 360
		-- upvalues: v39 (copy)
		return not v39()
	end, function() -- line: 362
		-- upvalues: StarterPackFrame (copy), v40 (copy), v21 (copy)
		return StarterPackFrame({
			LayoutOrder = function() --[[ LayoutOrder ]] -- line: 364
				-- upvalues: v40 (copy), v21 (copy)
				local v42 = v40()
				local v43 = if v42 ~= nil then v42.odds else nil

				if type(v43) == "number" and v43 >= v21 then
					return 351
				end

				return -1
			end
		})
	end)
end
