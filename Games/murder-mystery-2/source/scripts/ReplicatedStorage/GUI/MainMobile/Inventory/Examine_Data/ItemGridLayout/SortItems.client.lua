local frame = script.Parent.Parent.Parent
local layout = frame.Container:FindFirstChildWhichIsA("UIGridStyleLayout")
local absoluteContentSize = layout.AbsoluteContentSize
frame.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSize.Y + 10)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	local absoluteContentSize = layout.AbsoluteContentSize
	frame.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSize.Y + 10)
end)