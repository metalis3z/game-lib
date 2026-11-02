wait(0.2)
script.Parent.Parent.Head.BreathSound.Volume=0
script.Parent.PlaySound.Changed:Connect(function()
	if script.Parent.PlaySound.Value == true then
		script.Parent.Parent.Head.BreathSoundClient:Play()
	elseif script.Parent.PlaySound.Value == false then
		script.Parent.Parent.Head.BreathSoundClient:Stop()
	end
end)