-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopJackpotSpins, time of decompilation: Sun May  3 10:12:08 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local JackpotSpinServiceUtils = require(ReplicatedStorage.Source.Features.JackpotSpins.JackpotSpinServiceUtils)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

local function JackpotSpinFrame(p1) -- line: 12
	-- upvalues: StylizedFrame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), RobuxButton (copy)
	return StylizedFrame({
		Theme = "DarkBlue",
		Size = UDim2.fromOffset(280, 300),
		LayoutOrder = p1.LayoutOrder,
		ImageLabel({
			Image = ImageIds.jackpotDice,
			Size = UDim2.fromScale(0.72, 0.72),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.26),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Title,
			Size = UDim2.fromScale(0.8, 0.15),
			Position = UDim2.fromScale(0.5, 0.52),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			Gradient = {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.41, Color3.fromRGB(70, 57, 255)),
					ColorSequenceKeypoint.new(0.67, Color3.fromRGB(57, 199, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(23, 0, 152))
				})
			}
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Description or "",
			Size = UDim2.fromScale(0.8, 0.08),
			Position = UDim2.fromScale(0.5, 0.62),
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

return function() -- line: 61
	-- upvalues: JackpotSpinServiceUtils (copy), ShopContentFrame (copy), TextLabel (copy), JackpotSpinFrame (copy), Products (copy)
	local v12 = JackpotSpinServiceUtils.getProductDefinitions()

	return ShopContentFrame({
		Text = "Jackpot Spins",
		LayoutOrder = 150,
		TextLabel({
			TextSize = 20,
			Text = "<font size=\"30\"><font color=\"rgb(105,255,75)\">1,000X Luck</font></font> bonus jackpot on next spin! <font size=\"18\">(Activate in Backpack -> Items)</font>",
			RichText = true,
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, 60),
			TextYAlignment = Enum.TextYAlignment.Top,
			Stroke = {
				Thickness = 2
			}
		}),
		JackpotSpinFrame({
			Theme = "Yellow",
			Title = "1 Spin",
			Product = Products[v12[1].key],
			LayoutOrder = v12[1].layoutOrder,
			Description = v12[1].description
		}),
		JackpotSpinFrame({
			Theme = "Orange",
			Title = "5 Spins",
			Product = Products[v12[2].key],
			LayoutOrder = v12[2].layoutOrder,
			Description = v12[2].description
		}),
		JackpotSpinFrame({
			Theme = "Green",
			Title = "12 Spins",
			Product = Products[v12[3].key],
			LayoutOrder = v12[3].layoutOrder,
			Description = v12[3].description
		})
	})
end
