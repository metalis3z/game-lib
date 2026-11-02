local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local parentFrame = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent

script.Parent.Activated:Connect(function()
	if parentFrame.GigaBundleFrame:GetAttribute("Up") then
		parentFrame.GigaBundleFrame:SetAttribute("Up", false)
		ts:Create(parentFrame.GigaBundleFrame, ti, {Position = downPos}):Play()
	else
		ts:Create(parentFrame.GigaBundleFrame, ti, {Position = upPos}):Play()
		for i, v in pairs(parentFrame:GetChildren()) do
			if v:GetAttribute("Up") then
				v:SetAttribute("Up", false)
				ts:Create(v, ti, {Position = downPos}):Play()
			end
		end
		parentFrame.GigaBundleFrame:SetAttribute("Up", true)
	end
end)