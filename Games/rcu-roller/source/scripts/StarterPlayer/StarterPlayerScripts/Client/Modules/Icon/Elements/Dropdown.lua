-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:16
-- Luau version 6, Types version 3
-- Time taken: 0.001034 seconds

return function(arg1) -- Line 1
	local Frame = Instance.new("Frame")
	Frame.Name = "Dropdown"
	Frame.AutomaticSize = Enum.AutomaticSize.XY
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.AnchorPoint = Vector2.new(0.5, 0)
	Frame.Position = UDim2.new(0.5, 0, 1, 8)
	Frame.ZIndex = -2
	Frame.ClipsDescendants = true
	Frame.Visible = true
	Frame.Selectable = false
	Frame.Active = false
	local UICorner = Instance.new("UICorner")
	UICorner.Name = "DropdownCorner"
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Frame
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Name = "DropdownHolder"
	ScrollingFrame.AutomaticSize = Enum.AutomaticSize.XY
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
	ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.ZIndex = -1
	ScrollingFrame.ClipsDescendants = false
	ScrollingFrame.Visible = true
	ScrollingFrame.TopImage = ScrollingFrame.MidImage
	ScrollingFrame.BottomImage = ScrollingFrame.MidImage
	ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
	ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	ScrollingFrame.Parent = Frame
	ScrollingFrame.Active = false
	ScrollingFrame.Selectable = false
	ScrollingFrame.ScrollingEnabled = false
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "DropdownList"
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
	UIListLayout.Parent = ScrollingFrame
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Name = "DropdownPadding"
	UIPadding.PaddingTop = UDim.new(0, 8)
	UIPadding.PaddingBottom = UDim.new(0, 8)
	UIPadding.Parent = ScrollingFrame
	arg1.dropdownJanitor:add(arg1.widget:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line 56, Named "updatePosition"
	end))
	return Frame
end