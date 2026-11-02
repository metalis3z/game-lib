-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexRewardsFrame, time of decompilation: Sun May  3 10:12:35 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local NotificationBadge = require(ReplicatedStorage.Source.Features.App.Components.NotificationBadge)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local IndexRewardUtils = require(ReplicatedStorage.Source.Features.Index.IndexRewardUtils)
local IndexServiceClient = require(ReplicatedStorage.Source.Features.Index.IndexServiceClient)
local IndexSlice = require(ReplicatedStorage.Source.Features.Index.IndexSlice)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local rect = Rect.new(62, 52, 62, 52)

local function RewardIcon(p1, n1: number) -- line: 22
	-- upvalues: Vide (copy), IndexRewardUtils (copy), Button (copy), ImageIds (copy), rect (copy), IndexSlice (copy), ImageLabel (copy), TextLabel (copy)
	local v20 = Vide.derive(function() -- line: 23
		-- upvalues: IndexRewardUtils (copy), p1 (copy)
		return IndexRewardUtils.getDisplayData(p1())
	end)

	return Button({
		Name = "RewardIcon" .. tostring(n1),
		Image = ImageIds.blackCheckeredButton,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromScale(1, 1),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		SliceScale = 0.5,
		LayoutOrder = n1,
		HoverScale = 0.9,
		Activated = function() --[[ Activated ]] -- line: 37
		end,
		OnEnter = function() --[[ OnEnter ]] -- line: 38
			-- upvalues: IndexSlice (copy), v20 (copy)
			IndexSlice.hoveredReward(v20())
		end,
		OnLeave = function() --[[ OnLeave ]] -- line: 41
			-- upvalues: IndexSlice (copy), v20 (copy)
			if IndexSlice.hoveredReward() == v20() then
				IndexSlice.hoveredReward(nil)
			end
		end,
		ImageLabel({
			Image = function() --[[ Image ]] -- line: 48
				-- upvalues: v20 (copy)
				return v20().icon
			end,
			Size = UDim2.fromScale(0.65, 0.65),
			Position = UDim2.fromScale(0.5, 0.42),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			ZIndex = 2,
			Text = function() --[[ Text ]] -- line: 58
				-- upvalues: v20 (copy)
				return v20().amountText or ""
			end,
			Size = UDim2.fromScale(0.8, 0.33),
			Position = UDim2.fromScale(0.5, 0.8),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextXAlignment = Enum.TextXAlignment.Right,
			Stroke = {}
		})
	})
end
local function ToolTip() -- line: 76
	-- upvalues: StylizedFrame (copy), IndexSlice (copy), TextLabel (copy)
	return StylizedFrame({
		Theme = "Orange",
		Name = "Tooltip",
		Visible = function() --[[ Visible ]] -- line: 81
			-- upvalues: IndexSlice (copy)
			return IndexSlice.hoveredReward() ~= nil
		end,
		SliceScale = 0.5,
		Size = UDim2.fromOffset(222, 100),
		Position = UDim2.fromScale(0.5, 0.2),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundTransparency = 1,
		ZIndex = 9,
		TextLabel({
			TextSize = 24,
			Text = function() --[[ Text ]] -- line: 94
				-- upvalues: IndexSlice (copy)
				local v24 = IndexSlice.hoveredReward()

				if v24 then
					return v24.title
				end

				return ""
			end,
			Size = UDim2.new(0.9, 0, 0, 16),
			Position = UDim2.fromOffset(0, 6),
			Stroke = {},
			DropShadow = {}
		}),
		TextLabel({
			TextWrapped = true,
			TextSize = 16,
			Text = function() --[[ Text ]] -- line: 106
				-- upvalues: IndexSlice (copy)
				local v25 = IndexSlice.hoveredReward()

				if v25 then
					return v25.description
				end

				return ""
			end,
			Size = UDim2.new(0.9, 0, 0, 60),
			Position = UDim2.new(0.5, 0, 0, 26),
			AnchorPoint = Vector2.new(0.5, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextColor3 = Color3.fromRGB(221, 221, 221),
			Stroke = {}
		})
	})
end

return function(t1: {[any]: any}) -- line: 123
	-- upvalues: Vide (copy), IndexRewardUtils (copy), ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy), ToolTip (copy), Frame (copy), UIListLayout (copy), RewardIcon (copy), StylizedButton (copy), IndexServiceClient (copy), IndexSlice (copy), NotificationBadge (copy)
	local v22 = Vide.derive(function() -- line: 124
		-- upvalues: IndexRewardUtils (copy), t1 (copy)
		return IndexRewardUtils.getNextRewardEntryFromData(t1.IndexData(), t1.CategoryId())
	end)
	local v23 = Vide.derive(function() -- line: 128
		-- upvalues: v22 (copy)
		local v26 = v22()

		if v26 and v26.rewards then
			return v26.rewards
		end

		return {}
	end)

	return ImageLabel({
		Name = "IndexRewardsFrame",
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.new(0.31, 0, 0.395, -8),
		Position = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		TextLabel({
			Text = "Rewards:",
			TextSize = 20,
			ZIndex = 2,
			Size = UDim2.new(1, -20, 0, 22),
			Position = UDim2.fromOffset(20, 7),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {},
			DropShadow = {}
		}),
		ToolTip(),
		Frame({
			Size = UDim2.fromScale(0.8, 0.4),
			Position = UDim2.fromScale(0.5, 0.36),
			AnchorPoint = Vector2.new(0.5, 0.5),
			UIListLayout({
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 0)
			}),
			TextLabel({
				Text = "all rewards claimed",
				TextTransparency = 0.5,
				Size = UDim2.fromScale(0.8, 0.5),
				TextColor3 = Color3.fromRGB(189, 193, 201),
				Visible = function() --[[ Visible ]] -- line: 174
					-- upvalues: v22 (copy)
					return not v22()
				end
			}),
			Vide.indexes(v23, function(p2, n2: number) -- line: 181
				-- upvalues: RewardIcon (copy)
				return RewardIcon(p2, n2)
			end)
		}),
		StylizedButton({
			Name = "ClaimButton",
			Theme = function() --[[ Theme ]] -- line: 189
				-- upvalues: IndexRewardUtils (copy), t1 (copy)
				if IndexRewardUtils.isCategoryClaimableFromData(t1.IndexData(), t1.CategoryId()) then
					return "Green"
				end

				return "Grey"
			end,
			Text = "CLAIM",
			HoverScale = 1.05,
			Size = UDim2.fromOffset(180, 60),
			Position = UDim2.fromScale(0.5, 0.7),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = function() --[[ Activated ]] -- line: 201
				-- upvalues: IndexRewardUtils (copy), t1 (copy), IndexServiceClient (copy), IndexSlice (copy)
				if not IndexRewardUtils.isCategoryClaimableFromData(t1.IndexData(), t1.CategoryId()) then
					return
				end

				IndexServiceClient:requestClaimReward(t1.CategoryId())
				IndexSlice.hoveredReward(nil)
			end,
			NotificationBadge({
				Text = "!",
				ZIndex = 6,
				Count = function() --[[ Count ]] -- line: 211
					-- upvalues: IndexRewardUtils (copy), t1 (copy)
					if IndexRewardUtils.isCategoryClaimableFromData(t1.IndexData(), t1.CategoryId()) then
						return 1
					end

					return 0
				end,
				Size = UDim2.fromOffset(26, 26),
				Position = UDim2.fromScale(0.95, 0.14),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
		})
	})
end
