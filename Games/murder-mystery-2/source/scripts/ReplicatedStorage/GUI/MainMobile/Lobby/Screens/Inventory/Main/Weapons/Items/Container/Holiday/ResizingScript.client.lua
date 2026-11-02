-- Decompiled with the Synapse X Luau decompiler.

while wait(0.01) do
	script.Parent.CanvasSize = UDim2.new(0, 0, 0, script.Parent.UIListLayout.AbsoluteContentSize.Y);
	script.Parent.ChildAdded:Connect(function()
		script.Parent.CanvasSize = UDim2.new(0, 0, 0, script.Parent.UIListLayout.AbsoluteContentSize.Y + script.Parent.Frame.Size.Y.Offset + script.Parent.UIListLayout.CellPadding.Y.Offset);
	end);
end;
