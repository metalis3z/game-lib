local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local parentFrame = script.Parent.Parent.Parent.Parent.Parent

script.Parent.Activated:Connect(function()
	print("activated")
	if parentFrame.WheelSpin:GetAttribute("Up") then
		print("closed")
		script.Parent.Parent.Parent.Parent.Parent.WheelSpin:SetAttribute("Up", false)
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.WheelSpin, ti, {Position = downPos}):Play()
	else
		print("Opened")
		ts:Create(script.Parent.Parent.Parent.Parent.Parent.WheelSpin, ti, {Position = upPos}):Play()
		for i, v in pairs(parentFrame:GetChildren()) do
			if v:GetAttribute("Up") then
				v:SetAttribute("Up", false)
				ts:Create(v, ti, {Position = downPos}):Play()
			end
		end
		script.Parent.Parent.Parent.Parent.Parent.WheelSpin:SetAttribute("Up", true)
	end
end)