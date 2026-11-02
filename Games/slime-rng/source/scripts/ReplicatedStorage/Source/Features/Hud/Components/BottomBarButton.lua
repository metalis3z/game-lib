-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BottomBarButton, time of decompilation: Sun May  3 10:11:24 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local ConsoleHint = require(ReplicatedStorage.Source.Core.UI.Components.ConsoleHint)

require(ReplicatedStorage.Source.Core.UI.UITypes)

local DropShadow = require(ReplicatedStorage.Source.Features.App.Components.DropShadow)
local NotificationBadge = require(ReplicatedStorage.Source.Features.App.Components.NotificationBadge)

return function(t1: {[any]: any}) -- line: 36
	-- upvalues: Frame (copy), Vide (copy), Button (copy), TextLabel (copy), NotificationBadge (copy), ConsoleHint (copy), DropShadow (copy)
	return Frame({
		Name = t1.Name or "BottomBarButton",
		Size = t1.Size,
		LayoutOrder = t1.LayoutOrder,
		Visible = t1.Visible,
		if not t1.Scale then nil else Vide.create("UIScale")({
			Scale = t1.Scale
		}),
		Button({
			Name = "IconButton",
			Image = t1.Image,
			ImageColor3 = t1.ImageColor3,
			Size = UDim2.fromScale(1, 1),
			Position = t1.IconPosition or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Activated = t1.Activated,
			TextLabel({
				Name = "Label",
				Size = t1.TextSize or UDim2.fromScale(1.4, 0.25),
				Position = t1.TextPosition,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = t1.Label,
				TextColor3 = t1.TextColor3,
				Stroke = {
					Thickness = 3
				},
				DropShadow = {
					Offset = UDim2.fromScale(0, 0.16)
				}
			}),
			if not t1.NotificationCount then nil else NotificationBadge({
				ZIndex = 6,
				Count = t1.NotificationCount,
				Text = t1.NotificationBadgeText,
				Size = t1.NotificationBadgeSize or UDim2.fromOffset(30, 30),
				Position = t1.NotificationBadgePosition or UDim2.fromScale(1, 0.02),
				AnchorPoint = t1.NotificationBadgeAnchorPoint or Vector2.new(1, 0)
			}),
			if not t1.HintKeyCode then nil else ConsoleHint({
				ZIndex = 7,
				KeyCode = t1.HintKeyCode,
				Position = UDim2.fromScale(0.17, 0.12),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(34, 34)
			}),
			t1.Children
		}),
		DropShadow({
			ZIndex = 0,
			ImageTransparency = 0.33,
			Size = UDim2.fromScale(1.4, 0.6),
			Position = t1.ShadowPosition or UDim2.fromScale(0.5, 0.92),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ImageColor3 = Color3.fromRGB(28, 25, 36)
		})
	})
end
