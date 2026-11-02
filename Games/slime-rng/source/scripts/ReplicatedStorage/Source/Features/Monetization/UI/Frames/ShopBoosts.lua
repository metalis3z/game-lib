-- ShopBoosts (Client ModuleScript) - FIXED
-- Place: ReplicatedStorage.Source.Features.Monetization.UI.Frames.ShopBoosts
--
-- FIX: Line 62 crashed with "attempt to index number with 'amount'" because
-- boosts can be stored as either a plain number (old data) OR {amount = N} (new data).
-- getBoostAmount() handles both shapes safely so the UI never crashes.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

-- ─── Safe boost amount reader ─────────────────────────────────────────────────
-- Handles three possible shapes for a boost value:
--   {amount = 3}  → new server shape, returns 3
--   3             → old server shape (plain number), returns 3
--   nil           → no boosts purchased yet, returns 0
local function getBoostAmount(boostValue): number
	if type(boostValue) == "table" then
		local n = boostValue.amount
		return type(n) == "number" and math.max(math.floor(n), 0) or 0
	elseif type(boostValue) == "number" then
		return math.max(math.floor(boostValue), 0)
	end
	return 0
end

-- ─── BoostFrame ───────────────────────────────────────────────────────────────
local function BoostFrame(p1)
	local v12 = getDataSource({
		"boosts",
		p1.boostId
	})

	return StylizedFrame({
		Theme = p1.Theme,
		Size = UDim2.new(1, 0, 0, 160),
		LayoutOrder = p1.LayoutOrder,
		ImageLabel({
			Image = p1.Image,
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.1, 0.3),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Title,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.fromScale(0.56, 0.375),
			Position = UDim2.fromScale(0.18, 0),
			AnchorPoint = Vector2.new(0, 0),
			Stroke = {
				Thickness = 4
			}
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Description,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.fromScale(0.56, 0.275),
			Position = UDim2.fromScale(0.19, 0.74),
			AnchorPoint = Vector2.new(0, 1),
			Stroke = {
				Thickness = 3
			}
		}),
		RobuxButton({
			Product = p1.Product,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.fromScale(0.85, 0.85)
		}),
		TextLabel({
			-- FIXED: was `v12().amount` which crashes when the value is a plain number.
			-- Now uses getBoostAmount() which safely handles number, table, or nil.
			Text = function()
				return "You have: " .. getBoostAmount(v12())
			end,
			Size = UDim2.fromScale(0.25, 0.2),
			Position = UDim2.fromScale(0.815, 0.425),
			AnchorPoint = Vector2.new(0.5, 1),
			Stroke = {}
		})
	})
end

-- ─── Module return ────────────────────────────────────────────────────────────
return function()
	return ShopContentFrame({
		Text = "Boosts",
		LayoutOrder = 300,
		TextLabel({
			TextSize = 20,
			Text = "Activate boosts in Backpack -> Items!",
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, 26),
			TextYAlignment = Enum.TextYAlignment.Top,
			Stroke = {
				Thickness = 2
			}
		}),
		BoostFrame({
			Theme = "Green",
			Title = "Luck Boost",
			Description = "+1 Luck for 3 mins",
			boostId = "luck",
			LayoutOrder = 1,
			Image = ImageIds.boosts.luck,
			Product = Products.luckBoost
		}),
		BoostFrame({
			Theme = "Purple",
			Title = "Ultra Luck Boost",
			Description = "+2 Luck for 3 mins",
			boostId = "ultraLuck",
			LayoutOrder = 2,
			Image = ImageIds.boosts.ultraLuck,
			Product = Products.ultraLuckBoost
		}),
		BoostFrame({
			Theme = "Blue",
			Title = "Roll Speed Boost",
			Description = "x2 faster rolls for 3 mins",
			boostId = "rollSpeed",
			LayoutOrder = 3,
			Image = ImageIds.boosts.rollSpeed,
			Product = Products.rollSpeedBoost
		}),
		BoostFrame({
			Theme = "Yellow",
			Title = "Coin Boost",
			Description = "x2 Coins for 3 mins",
			boostId = "currency",
			LayoutOrder = 4,
			Image = ImageIds.boosts.currency,
			Product = Products.coinBoost
		})
	})
end