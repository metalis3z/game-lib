local TweenService = game:GetService("TweenService")

for i,v in pairs(game.Workspace.Interactions:GetChildren()) do
	if not v:FindFirstChild("DoorLeft") then
		return
	end
	if v.Configuration.IsOpened.Value == false then
		v.HingeLeft.CFrame = v.HingeLeftClosed.CFrame
		v.HingeRight.CFrame = v.HingeRightClosed.CFrame
	elseif v.Configuration.IsOpened.Value == true then
		v.HingeLeft.CFrame = v.HingeLeftOpened.CFrame
		v.HingeRight.CFrame = v.HingeRightOpened.CFrame
	end
	v.Configuration.IsOpened.Changed:Connect(function()
		if v.Configuration.IsOpened.Value == false then
			TweenService:Create(v.HingeLeft, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = v.HingeLeftClosed.CFrame}):Play()
			TweenService:Create(v.HingeRight, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = v.HingeRightClosed.CFrame}):Play()
			v.PrimaryPart.denied:Play()
		elseif v.Configuration.IsOpened.Value == true then
			TweenService:Create(v.HingeLeft, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = v.HingeLeftOpened.CFrame}):Play()
			TweenService:Create(v.HingeRight, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = v.HingeRightOpened.CFrame}):Play()
			v.PrimaryPart.granted:Play()
		end
	end)
end