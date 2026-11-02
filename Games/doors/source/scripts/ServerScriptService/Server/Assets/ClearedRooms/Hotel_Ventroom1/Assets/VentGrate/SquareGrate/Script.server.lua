script.Parent.Parent.AwesomePrompt.Triggered:Connect(function()
	script.Parent.Anchored = false
	script.Parent.InteractSound:Play()
	--script.Parent:ApplyImpulse(Vector3.new(-60,0,0))
	script.Parent.AssemblyLinearVelocity = Vector3.new(0, 0, -30)
	script.Parent.Parent.AwesomePrompt:Destroy()
end)