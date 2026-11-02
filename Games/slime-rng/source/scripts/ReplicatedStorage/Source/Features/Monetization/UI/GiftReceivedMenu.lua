-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GiftReceivedMenu, time of decompilation: Sun May  3 10:12:06 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DisplayNameWithIcons = require(ReplicatedStorage.Source.Core.UI.DisplayNameWithIcons)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local MonetizationSlice = require(ReplicatedStorage.Source.Features.Monetization.MonetizationSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

local function clearGiftReceived() -- line: 14
	-- upvalues: MonetizationSlice (copy), Menu (copy)
	MonetizationSlice.giftReceivedData(nil)
	Menu.setOpenedMenu(nil, true)
end
local function GiftReceivedContent() -- line: 32
	-- upvalues: Frame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), MonetizationSlice (copy), Players (copy), DisplayNameWithIcons (copy), MonetizationServiceClient (copy), StylizedButton (copy), clearGiftReceived (copy)
	return Frame({
		Name = "GiftReceivedContent",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageLabel({
			Image = ImageIds.gift,
			Size = UDim2.fromOffset(72, 72),
			Position = UDim2.fromScale(0.5, 0.18),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			RichText = true,
			TextSize = 28,
			TextScaled = false,
			Text = function() --[[ Text ]] -- line: 47
				-- upvalues: MonetizationSlice (copy), Players (copy), DisplayNameWithIcons (copy), MonetizationServiceClient (copy)
				local v16 = MonetizationSlice.giftReceivedData()

				if not v16 then
					return "Gift received!"
				end

				local fromUserId = v16.giftData.fromUserId
				local s1

				if type(fromUserId) ~= "number" then
					s1 = "Someone"
				else
					local PlayerByUserId = Players:GetPlayerByUserId(fromUserId)

					s1 = if not PlayerByUserId then `Player { fromUserId }` else DisplayNameWithIcons(PlayerByUserId)
				end

				return `{ s1 } has gifted you:\n<font size="46">{ MonetizationServiceClient:getProductInfo(v16.product).Name or "a gift" }</font>`
			end,
			Size = UDim2.fromScale(0.84, 0.36),
			Position = UDim2.fromScale(0.5, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		}),
		StylizedButton({
			Theme = "Green",
			Text = "Claim",
			Size = UDim2.fromOffset(140, 54),
			Position = UDim2.fromScale(0.5, 0.8),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = clearGiftReceived
		})
	})
end

return {
	menuId = "GiftReceivedMenu",
	alwaysMounted = false,
	Component = function() --[[ GiftReceivedMenu ]] -- line: 79
		-- upvalues: Menu (copy), clearGiftReceived (copy), GiftReceivedContent (copy)
		return Menu.Component({
			menuId = "GiftReceivedMenu",
			Title = "Gift Received",
			Scale = 0.72,
			OnClose = clearGiftReceived,
			GiftReceivedContent()
		})
	end
}
