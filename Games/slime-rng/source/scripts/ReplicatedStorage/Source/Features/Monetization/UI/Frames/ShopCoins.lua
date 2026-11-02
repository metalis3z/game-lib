-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopCoins, time of decompilation: Sun May  3 10:12:08 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local getDataSource = require(ReplicatedStorage.Source.Core.UI.Sources.getDataSource)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local Enemies = require(ReplicatedStorage.Source.Game.Items.Enemies)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)

local function getAverageEnemyCoinReward(n1: number) -- line: 15
	-- upvalues: Zones (copy), Enemies (copy)
	local n2 = 0
	local n3 = 0

	for _, v19 in Zones.getZone(n1).enemies do
		local v20 = Enemies.getEnemyInfo(v19)

		if v20 then
			n2 += v20.reward
			n3 += 1
		end
	end

	if n3 <= 0 then
		return 0
	end

	return n2 / n3
end
local function CoinFrame(p1) -- line: 40
	-- upvalues: getDataSource (copy), StylizedFrame (copy), ImageLabel (copy), TextLabel (copy), Abbreviate (copy), Zones (copy), getAverageEnemyCoinReward (copy), RobuxButton (copy)
	local v25 = getDataSource("maxZone")

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
			Text = function() --[[ Text ]] -- line: 57
				-- upvalues: Abbreviate (copy), v25 (copy), p1 (copy), Zones (copy), getAverageEnemyCoinReward (copy)
				local v26 = Abbreviate
				local v27 = v25() or 1
				local KillCount = p1.KillCount
				local v29 = math.clamp(math.max(v27, 1), 1, Zones.getMaxZone())

				return `${ v26((math.max(math.round(getAverageEnemyCoinReward(v29) * KillCount), 0))) } Coins`
			end,
			Size = UDim2.fromScale(0.8, 0.2),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3,
				Color = Color3.fromRGB(75, 64, 0)
			},
			Gradient = {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 245, 198)),
					ColorSequenceKeypoint.new(0.41, Color3.fromRGB(255, 202, 57)),
					ColorSequenceKeypoint.new(0.67, Color3.fromRGB(255, 252, 57)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 129, 0))
				})
			}
		}),
		TextLabel({
			ZIndex = 2,
			Text = p1.Description or "",
			TextColor3 = Color3.fromRGB(228, 228, 228),
			Size = UDim2.fromScale(0.8, 0.1),
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

return function() -- line: 94
	-- upvalues: ShopContentFrame (copy), CoinFrame (copy), Products (copy), ImageIds (copy)
	return ShopContentFrame({
		Text = "Coins",
		LayoutOrder = 350,
		Padding = 20,
		CoinFrame({
			Theme = "Yellow",
			LayoutOrder = 1,
			KillCount = 40,
			Product = Products.coinsSmall,
			Image = ImageIds.coinsSmall,
			ImageSize = UDim2.fromScale(0.84, 0.84),
			ImagePosition = UDim2.fromScale(0.5, 0.25)
		}),
		CoinFrame({
			Theme = "Yellow",
			LayoutOrder = 2,
			KillCount = 600,
			Description = "(+50% bonus)",
			Product = Products.coinsMedium,
			Image = ImageIds.coinsMedium,
			ImageSize = UDim2.fromScale(1, 1),
			ImagePosition = UDim2.fromScale(0.55, 0.275)
		}),
		CoinFrame({
			Theme = "Yellow",
			LayoutOrder = 3,
			KillCount = 1600,
			Description = "(+100% bonus)",
			Product = Products.coinsLarge,
			Image = ImageIds.coinsLarge,
			ImageSize = UDim2.fromScale(0.9, 0.9),
			ImagePosition = UDim2.fromScale(0.5, 0.25)
		})
	})
end
