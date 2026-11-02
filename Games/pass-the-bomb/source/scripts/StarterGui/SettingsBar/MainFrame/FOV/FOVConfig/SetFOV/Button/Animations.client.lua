local TweenService = game:GetService("TweenService")
local TweenSpeed = 0.1
local Info = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0)

local frame = script.Parent.Parent

-- Button --

script.Parent.MouseEnter:Connect(function()
	local Color = Color3.fromRGB(255, 255, 255)
	TweenService:Create(frame, Info, {BackgroundColor3 = Color}):Play()
end)

script.Parent.MouseLeave:Connect(function()
	local ColorColor = Color3.fromRGB(42, 42, 42)
	TweenService:Create(frame, Info, {BackgroundColor3 = ColorColor}):Play()
end)

-- Text --

script.Parent.MouseEnter:Connect(function()
	local Color = Color3.fromRGB(38, 38, 38)
	TweenService:Create(script.Parent.Parent.Text, Info, {TextColor3 = Color}):Play()
end)

script.Parent.MouseLeave:Connect(function()
	local ColorColor = Color3.fromRGB(255, 255, 255)
	TweenService:Create(script.Parent.Parent.Text, Info, {TextColor3 = ColorColor}):Play()
end)