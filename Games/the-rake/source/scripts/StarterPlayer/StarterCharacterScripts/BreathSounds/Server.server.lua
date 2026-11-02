wait(0.1)
script.Parent.PlaySound.Changed:Connect(function()
	if script.Parent.PlaySound.Value == true then
		script.Parent.Parent.Head.BreathSound:Play()
	elseif script.Parent.PlaySound.Value == false then
		script.Parent.Parent.Head.BreathSound:Stop()
	end
end)