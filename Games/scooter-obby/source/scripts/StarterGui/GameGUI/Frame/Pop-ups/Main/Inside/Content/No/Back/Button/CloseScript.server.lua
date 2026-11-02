local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,0,0)

script.Parent.Activated:Connect(function()
	ts:Create(script.Parent.Parent.Parent.Parent.Parent.Parent.Parent, ti, {Position = downPos}):Play()
	script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:SetAttribute("Down", false)
end)