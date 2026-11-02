-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopLuckLadder, time of decompilation: Sun May  3 10:12:15 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local LuckLadderServiceUtils = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceUtils)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local RobuxButton = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.RobuxButton)
local ShopContentFrame = require(ReplicatedStorage.Source.Features.Monetization.UI.Components.ShopContentFrame)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

local function getTimerText() -- line: 17
	-- upvalues: LuckLadderServiceClient (copy), FormatTime (copy)
	local v18 = LuckLadderServiceClient:getTimeRemaining()

	if v18 > 0 then
		return `Ends: { FormatTime(v18) }`
	end

	return ""
end
local function MaxTierBadge() -- line: 26
	-- upvalues: StylizedFrame (copy), LuckLadderServiceClient (copy), TextLabel (copy)
	return StylizedFrame({
		Theme = "Black",
		Size = UDim2.fromOffset(180, 64),
		Position = UDim2.fromScale(0.5, 0.9),
		AnchorPoint = Vector2.new(0.5, 1),
		LayoutOrder = 100,
		ZIndex = 3,
		Visible = function() --[[ Visible ]] -- line: 34
			-- upvalues: LuckLadderServiceClient (copy)
			return LuckLadderServiceClient:getNextMultiplier() == nil
		end,
		TextLabel({
			Text = "MAX TIER",
			ZIndex = 4,
			Size = UDim2.fromScale(0.9, 0.6),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		})
	})
end
local function LuckLadderFrame() -- line: 50
	-- upvalues: Vide (copy), LuckLadderServiceClient (copy), Products (copy), LuckLadderServiceUtils (copy), StylizedFrame (copy), ImageLabel (copy), ImageIds (copy), TextLabel (copy), Frame (copy), UIListLayout (copy), getTimerText (copy), RobuxButton (copy), MaxTierBadge (copy)
	local v19 = Vide.derive(function() -- line: 51
		-- upvalues: LuckLadderServiceClient (copy), Products (copy), LuckLadderServiceUtils (copy)
		local v20 = LuckLadderServiceClient:getNextMultiplier()

		if v20 then
			return Products[LuckLadderServiceUtils.getProductKey(v20)]
		end

		return Products.luckLadder2048
	end)

	return StylizedFrame({
		Theme = "Green",
		Size = UDim2.new(1, 0, 0, 200),
		LayoutOrder = 1,
		ImageLabel({
			ZIndex = 2,
			Image = ImageIds.luckIcons[1],
			Size = UDim2.fromOffset(150, 150),
			Position = UDim2.fromScale(0.13, 0.48),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			Text = "<font size=\"100\"><font color=\"rgb(80,255,130)\">BOOST</font> </font><font size=\"80\">Server Luck!</font>",
			RichText = true,
			TextScaled = false,
			ZIndex = 2,
			Size = UDim2.fromScale(0.62, 0.3),
			Position = UDim2.fromScale(0.5, 0.02),
			AnchorPoint = Vector2.new(0.5, 0),
			Stroke = {
				Thickness = 4
			}
		}),
		Frame({
			Size = UDim2.fromScale(0.5, 0.66),
			Position = UDim2.fromScale(0.5, 0.85),
			AnchorPoint = Vector2.new(0.5, 1),
			UIListLayout({
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 0)
			}),
			TextLabel({
				LayoutOrder = 1,
				Text = function() --[[ Text ]] -- line: 99
					-- upvalues: LuckLadderServiceUtils (copy), LuckLadderServiceClient (copy)
					return LuckLadderServiceUtils.formatMultiplier(LuckLadderServiceClient:getCurrentMultiplier())
				end,
				Size = UDim2.fromScale(0.33, 0.5),
				TextXAlignment = Enum.TextXAlignment.Right,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {
					Thickness = 4
				}
			}),
			TextLabel({
				Text = "->",
				LayoutOrder = 2,
				Size = UDim2.fromScale(0.2, 0.5),
				Stroke = {
					Thickness = 4
				},
				TextYAlignment = Enum.TextYAlignment.Bottom
			}),
			TextLabel({
				RichText = true,
				LayoutOrder = 3,
				Text = function() --[[ Text ]] -- line: 118
					-- upvalues: LuckLadderServiceClient (copy), LuckLadderServiceUtils (copy)
					local v21 = LuckLadderServiceClient:getNextMultiplier()

					if not v21 then
						return "x2048"
					end

					return LuckLadderServiceUtils.formatMultiplier(v21)
				end,
				Size = UDim2.fromScale(0.33, 0.7),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Stroke = {
					Thickness = 6,
					Color = Color3.fromRGB(26, 26, 26)
				},
				Gradient = {
					Rotation = 70,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
					})
				}
			})
		}),
		TextLabel({
			ZIndex = 2,
			Text = getTimerText,
			Size = UDim2.fromScale(0.2, 0.12),
			Position = UDim2.fromScale(0.872, 0.45),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = Color3.fromRGB(255, 79, 117),
			Stroke = {
				Thickness = 2
			}
		}),
		RobuxButton({
			HideGift = true,
			LayoutOrder = 1,
			ZIndex = 3,
			Product = v19,
			Position = UDim2.fromScale(0.97, 0.85),
			Size = UDim2.fromOffset(180, 65),
			AnchorPoint = Vector2.new(1, 1),
			Visible = function() --[[ Visible ]] -- line: 159
				-- upvalues: LuckLadderServiceClient (copy)
				return LuckLadderServiceClient:getNextMultiplier() ~= nil
			end
		}),
		MaxTierBadge()
	})
end

return function() -- line: 168
	-- upvalues: ShopContentFrame (copy), LuckLadderFrame (copy)
	return ShopContentFrame({
		Text = "",
		LayoutOrder = 0,
		LuckLadderFrame()
	})
end
