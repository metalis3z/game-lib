-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopPasses, time of decompilation: Sun May  3 10:12:07 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

local function PassFrame(p1) -- line: 11
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
			Size = UDim2.fromScale(0.8, 0.15),
			Position = p1.TitlePosition or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			}
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Description,
			Size = p1.DescriptionSize or UDim2.fromScale(0.8, 0.1),
			Position = UDim2.fromScale(0.5, 0.6),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 1
			}
		}),
		RobuxButton({
			Product = p1.Product,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.fromScale(0.5, 0.9)
		})
	})
end

return function() -- line: 51
	-- upvalues: ShopContentFrame (copy), PassFrame (copy), Products (copy), ImageIds (copy)
	return ShopContentFrame({
		Text = "Passes",
		LayoutOrder = 100,
		Padding = 20,
		PassFrame({
			Theme = "Blue",
			LayoutOrder = 1,
			Title = "Double Roll",
			Description = "Roll 2 slimes every roll!",
			Product = Products.doubleRoll,
			ImageSize = UDim2.fromScale(1, 1),
			ImagePosition = UDim2.fromScale(0.5, 0.2),
			Image = ImageIds.passes.doubleRoll
		}),
		PassFrame({
			Theme = "Red",
			LayoutOrder = 2,
			Title = "Fast Roll",
			Description = "Roll twice as fast!",
			Product = Products.fastRoll,
			ImageSize = UDim2.fromScale(0.8, 0.8),
			ImagePosition = UDim2.fromScale(0.5, 0.28),
			Image = ImageIds.passes.fastRoll
		}),
		PassFrame({
			Theme = "Green",
			LayoutOrder = 3,
			Title = "Lucky Rolls",
			Description = "+1 Permanent Luck!",
			Product = Products.luckyRolls,
			ImageSize = UDim2.fromScale(0.8, 0.8),
			ImagePosition = UDim2.fromScale(0.5, 0.25),
			Image = ImageIds.passes.luckyRolls
		}),
		PassFrame({
			Theme = "Yellow",
			LayoutOrder = 4,
			Title = "VIP!",
			Description = "Chat Tag, VIP Trail, Bonus Coins and Luck!",
			Product = Products.vip,
			TitlePosition = UDim2.fromScale(0.5, 0.45),
			DescriptionSize = UDim2.fromScale(0.8, 0.2),
			ImageSize = UDim2.fromScale(1, 1),
			ImagePosition = UDim2.fromScale(0.5, 0.2),
			Image = ImageIds.passes.vip
		}),
		PassFrame({
			Theme = "Purple",
			LayoutOrder = 5,
			Title = "Auto Collect",
			Description = "Auto collect loot without moving!",
			Product = Products.autoCollect,
			TitlePosition = UDim2.fromScale(0.5, 0.45),
			DescriptionSize = UDim2.fromScale(0.8, 0.175),
			ImageSize = UDim2.fromScale(0.85, 0.85),
			ImagePosition = UDim2.fromScale(0.5, 0.3),
			Image = ImageIds.passes.autoCollect
		}),
		PassFrame({
			Theme = "Orange",
			LayoutOrder = 6,
			Title = "+1 Equip",
			Description = "Equip an extra slime!",
			Product = Products.extraEquip,
			TitlePosition = UDim2.fromScale(0.5, 0.45),
			DescriptionSize = UDim2.fromScale(0.8, 0.175),
			ImageSize = UDim2.fromScale(0.8, 0.8),
			ImagePosition = UDim2.fromScale(0.5, 0.25),
			Image = ImageIds.passes.extarSlot
		}),
		PassFrame({
			Theme = "Blue",
			LayoutOrder = 7,
			Title = "More Loot",
			Description = "Better odds of loot drops!",
			Product = Products.moreDrops,
			ImageSize = UDim2.fromScale(0.75, 0.75),
			ImagePosition = UDim2.fromScale(0.5, 0.275),
			Image = ImageIds.passes.moreLoot
		})
	})
end
