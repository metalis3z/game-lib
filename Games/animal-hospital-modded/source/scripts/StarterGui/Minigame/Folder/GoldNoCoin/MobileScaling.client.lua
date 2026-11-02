if not game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled then
	return
end

local Size = script.Parent.Size

script.Parent.Size = UDim2.new(Size.X.Scale * 1.25, Size.X.Offset, Size.Y.Scale * 1.25, Size.Y.Offset)