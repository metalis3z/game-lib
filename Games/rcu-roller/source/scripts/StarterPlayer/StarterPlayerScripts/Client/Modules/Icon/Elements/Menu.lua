-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:17
-- Luau version 6, Types version 3
-- Time taken: 0.000853 seconds

return function(arg1) -- Line 1
	local Frame_2 = Instance.new("Frame")
	Frame_2.Name = "MenuContainer"
	Frame_2.BackgroundTransparency = 1
	Frame_2.BorderSizePixel = 0
	Frame_2.AnchorPoint = Vector2.new(1, 0)
	Frame_2.Size = UDim2.new(0, 500, 0, 50)
	Frame_2.ZIndex = -2
	Frame_2.ClipsDescendants = true
	Frame_2.Visible = true
	Frame_2.Active = false
	Frame_2.Selectable = false
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Name = "MenuFrame"
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
	ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.ZIndex = 9
	ScrollingFrame.ClipsDescendants = false
	ScrollingFrame.Visible = true
	ScrollingFrame.TopImage = ""
	ScrollingFrame.BottomImage = ""
	ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.Parent = Frame_2
	ScrollingFrame.Active = false
	ScrollingFrame.Selectable = false
	ScrollingFrame.ScrollingEnabled = false
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Name = "MenuList"
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = ScrollingFrame
	local Frame = Instance.new("Frame")
	Frame.Name = "MenuInvisBlocker"
	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.new(0, -2, 1, 0)
	Frame.Visible = true
	Frame.LayoutOrder = 999999999
	Frame.Parent = ScrollingFrame
	Frame.Active = false
	return Frame_2
end