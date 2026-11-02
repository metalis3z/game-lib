-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopContentFrame, time of decompilation: Sun May  3 10:12:10 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Packages.Vide)

local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)

return function(t1: {[any]: any}) -- line: 15
	-- upvalues: Frame (copy), UIListLayout (copy), TextLabel (copy)
	local t2 = {}

	for _, v in ipairs(t1) do
		table.insert(t2, v)
	end

	return Frame({
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = t1.LayoutOrder,
		t2,
		UIListLayout({
			Wraps = true,
			Padding = UDim.new(0, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top
		}),
		if not t1.Padding then nil else Frame({
			BackgroundTransparency = 1,
			LayoutOrder = -1,
			Size = UDim2.new(1, 0, 0, t1.Padding)
		}),
		TextLabel({
			LayoutOrder = -2,
			Text = t1.Text,
			Size = UDim2.new(1, 0, 0, 40),
			Stroke = {
				Thickness = 3,
				Color = Color3.fromRGB(0, 0, 0)
			}
		})
	})
end
