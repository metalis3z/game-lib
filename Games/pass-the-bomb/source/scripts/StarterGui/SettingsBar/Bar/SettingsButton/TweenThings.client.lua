local ts = game:GetService("TweenService")
local cur = false
script.Parent.Activated:Connect(function()
	if cur == false then
		local info = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local tween = ts:Create(script.Parent.Parent.Parent:WaitForChild("MainFrame",15), info, {["Position"] = UDim2.new(0.5, 0,0.5, 0)})
		tween:Play()
	else
		local info = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		local tween = ts:Create(script.Parent.Parent.Parent:WaitForChild("MainFrame",15), info, {["Position"] = UDim2.new(0.5, 0,-1.03, 0)})
		tween:Play()
	end
	cur = not cur
end)