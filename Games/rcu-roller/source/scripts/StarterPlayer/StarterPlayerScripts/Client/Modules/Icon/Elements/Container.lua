-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:14
-- Luau version 6, Types version 3
-- Time taken: 0.001804 seconds

return function() -- Line 1
	local module = {}
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "TopbarStandard"
	ScreenGui.Enabled = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.DisplayOrder = 10
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	module[ScreenGui.Name] = ScreenGui
	local Frame = Instance.new("Frame")
	Frame.Name = "Holders"
	Frame.BackgroundTransparency = 1
	Frame.Position = UDim2.new(0, 0, 0, 0)
	Frame.Size = UDim2.new(1, 0, 1, -1)
	Frame.Visible = true
	Frame.ZIndex = 1
	Frame.Active = false
	Frame.Parent = ScreenGui
	local clone_2 = ScreenGui:Clone()
	local Holders_upvr = clone_2.Holders
	local GuiService_upvr = game:GetService("GuiService")
	clone_2.Name = "TopbarCentered"
	clone_2.ScreenInsets = Enum.ScreenInsets.None
	module[clone_2.Name] = clone_2
	GuiService_upvr:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line 28, Named "updateCenteredHoldersHeight"
		--[[ Upvalues[2]:
			[1]: Holders_upvr (readonly)
			[2]: GuiService_upvr (readonly)
		]]
		Holders_upvr.Size = UDim2.new(1, 0, 0, GuiService_upvr.TopbarInset.Height - 1)
	end)
	Holders_upvr.Size = UDim2.new(1, 0, 0, GuiService_upvr.TopbarInset.Height - 1)
	local clone = Frame:Clone()
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Padding = UDim.new(0, game:GetService("GuiService"):GetGuiInset().Y - 46)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.Parent = clone
	clone.Name = "Left"
	clone.Position = UDim2.fromOffset(12, 0)
	clone.Size = UDim2.new(1, -24, 1, 0)
	clone.Parent = Frame
	local clone_4 = clone:Clone()
	clone_4.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	clone_4.Name = "Center"
	clone_4.Parent = Holders_upvr
	local clone_3 = clone:Clone()
	clone_3.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	clone_3.Name = "Right"
	clone_3.Parent = Frame
	return module
end