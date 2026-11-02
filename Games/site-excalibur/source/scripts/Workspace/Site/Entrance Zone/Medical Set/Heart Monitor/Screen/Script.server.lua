script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	if Player.Backpack:FindFirstChild("Wrench") then
		script.Parent.Crank:Play()
		script.Parent.Parent.Parent.MedicalBed.Seat.Manager.Broken.Value = false
	end
end)

script.Parent.Parent.Parent.MedicalBed.Seat.Manager.Broken.Changed:Connect(function()
	if script.Parent.Parent.Parent.MedicalBed.Seat.Manager.Broken.Value then
		script.Parent.Broke:Play()
		script.Parent.Sparkles.Enabled = true
	else
		script.Parent.Broke:Stop()
		script.Parent.Sparkles.Enabled = false
	end
end)