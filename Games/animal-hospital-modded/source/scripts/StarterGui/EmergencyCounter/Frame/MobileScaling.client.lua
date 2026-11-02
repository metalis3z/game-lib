if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled then
	local Size = script.Parent.Size

	script.Parent.Size = UDim2.new(Size.X.Scale * 1.25, Size.X.Offset, Size.Y.Scale * 1.25, Size.Y.Offset)
	script.Parent.Position = UDim2.new(1, 0, 0.385, 0)
else
	script.Parent.UISizeConstraint:Destroy()
end