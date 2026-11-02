script.Parent.Touched:Connect(function()
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.Parent.Door1.Anchored = false
	script.Parent.Parent.Door1.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.Open:Play()
end)
