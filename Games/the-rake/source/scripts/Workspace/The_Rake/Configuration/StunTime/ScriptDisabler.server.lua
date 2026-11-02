script.Parent.Parent.StunTime.Changed:Connect(function()
	script.Parent.Script.Disabled = true
	wait(1)
	script.Parent.Script.Disabled = false
end)