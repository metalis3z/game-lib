script.Parent.PromptButtonHoldBegan:Connect(function()
	script.Parent.Parent.Sound:Play()
end)

script.Parent.PromptButtonHoldEnded:Connect(function()
	script.Parent.Parent.Sound:Stop()
end)

local used = false

script.Parent.Triggered:Connect(function(p)
	if used then return end
	used = true
	script.Parent.Parent.Transparency = 1
	script.Parent.Enabled = false
	task.delay(1,function()
		script.Parent.Parent:Destroy()
	end)
	p.Character.Humanoid.Health += 75
end)