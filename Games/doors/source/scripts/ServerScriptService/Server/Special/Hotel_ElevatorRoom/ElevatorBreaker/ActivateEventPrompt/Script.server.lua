script.Parent.Triggered:Connect(function()
	script.Parent.Parent.Event:Fire()
	script.Parent.Parent.DoorHinge.TargetAngle = 90
	script.Parent:Destroy()
end)