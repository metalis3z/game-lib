-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopFood, time of decompilation: Sun May  3 10:12:09 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

local function FoodFrame(p1) -- line: 11
	-- upvalues: StylizedFrame (copy), ImageLabel (copy), TextLabel (copy), RobuxButton (copy)
	return StylizedFrame({
		Theme = p1.Theme,
		Size = UDim2.fromOffset(280, 300),
		LayoutOrder = p1.LayoutOrder,
		ImageLabel({
			Image = p1.Image,
			Size = p1.ImageSize,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = p1.ImagePosition,
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Title,
			Size = UDim2.fromScale(0.8, 0.175),
			Position = UDim2.fromScale(0.5, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			}
		}),
		TextLabel({
			TextSize = 20,
			TextWrapped = true,
			ZIndex = 2,
			Text = p1.Description or "",
			TextColor3 = Color3.fromRGB(228, 228, 228),
			Size = UDim2.fromScale(0.8, 0.15),
			Position = UDim2.fromScale(0.5, 0.6),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 2
			}
		}),
		RobuxButton({
			Product = p1.Product,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.fromScale(0.5, 0.9)
		})
	})
end

return function() -- line: 56
	-- upvalues: ShopContentFrame (copy), TextLabel (copy), FoodFrame (copy), ImageIds (copy), Products (copy)
	return ShopContentFrame({
		Text = "Food",
		LayoutOrder = 160,
		TextLabel({
			TextSize = 20,
			Text = "Feed slimes to level them up!",
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, 40),
			TextYAlignment = Enum.TextYAlignment.Top,
			Stroke = {
				Thickness = 2
			}
		}),
		FoodFrame({
			Theme = "Yellow",
			Title = "Snack",
			Description = "20x Apples, 10x Carrots, 5x Bananas (3,375 xp)",
			Image = ImageIds.snackPack,
			ImageSize = UDim2.fromScale(0.83, 0.83),
			ImagePosition = UDim2.fromScale(0.5, 0.3),
			Product = Products.foodSnack
		}),
		FoodFrame({
			Theme = "Orange",
			Title = "Meal",
			Description = "20x Watermelons, 10x Pizza, 5x Chicken (7,500 xp)",
			Image = ImageIds.mealPack,
			ImageSize = UDim2.fromScale(0.83, 0.83),
			ImagePosition = UDim2.fromScale(0.5, 0.3),
			Product = Products.foodMeal
		}),
		FoodFrame({
			Theme = "Red",
			Title = "Feast",
			Description = "40x Pizza, 20x Chicken, 10x Drumstick (16,750 xp)",
			Image = ImageIds.feastPack,
			ImageSize = UDim2.fromScale(0.87, 0.87),
			ImagePosition = UDim2.fromScale(0.5, 0.3),
			Product = Products.foodFeast
		})
	})
end
