-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthStatRow, time of decompilation: Sun May  3 10:11:41 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local rect = Rect.new(22, 52, 112, 52)

local function CounterFrame(t1: {[any]: any}) -- line: 31
	-- upvalues: ImageLabel (copy), ImageIds (copy), rect (copy), TextLabel (copy)
	return ImageLabel({
		Image = ImageIds.blackFrame,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = rect,
		Size = UDim2.fromScale(0.25, 1),
		LayoutOrder = t1.LayoutOrder,
		ImageLabel({
			Name = "Icon",
			Image = t1.Icon,
			Size = t1.IconSize,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = t1.IconPosition,
			ScaleType = Enum.ScaleType.Fit
		}),
		TextLabel({
			Text = t1.Value,
			TextColor3 = t1.TextColor3,
			Size = UDim2.fromScale(0.8, 0.66),
			Position = UDim2.fromScale(0.25, 0.4),
			AnchorPoint = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {},
			DropShadow = {}
		})
	})
end

return function(t2: {[any]: any}) -- line: 61
	-- upvalues: Frame (copy), UIListLayout (copy), CounterFrame (copy), TextLabel (copy)
	return Frame({
		Size = UDim2.new(1, 0, 0, 78),
		LayoutOrder = t2.LayoutOrder,
		UIListLayout({
			Padding = UDim.new(0, 0),
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		CounterFrame({
			LayoutOrder = 1,
			Icon = t2.Icon,
			IconPosition = t2.IconPosition,
			IconSize = t2.IconSize,
			Value = t2.LeftValue
		}),
		TextLabel({
			Text = "->",
			LayoutOrder = 2,
			Size = UDim2.fromScale(0.125, 1),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Stroke = {},
			DropShadow = {}
		}),
		Frame({
			LayoutOrder = 3,
			Size = UDim2.fromScale(0.1, 1)
		}),
		CounterFrame({
			LayoutOrder = 4,
			Icon = t2.Icon,
			IconPosition = t2.IconPosition,
			IconSize = t2.IconSize,
			Value = t2.RightValue,
			TextColor3 = t2.RightValueColor
		})
	})
end
