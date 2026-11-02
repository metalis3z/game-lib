script.Parent.Parent.ChildAdded:Connect(function(Child)
	script.Parent.Parent.Parent.Parent.EventLayout.Padding = UDim.new(0, script.Parent.AbsoluteContentSize.Y + Child.Size.Y.Offset + script.Parent.CellPadding.Y.Offset)
end)