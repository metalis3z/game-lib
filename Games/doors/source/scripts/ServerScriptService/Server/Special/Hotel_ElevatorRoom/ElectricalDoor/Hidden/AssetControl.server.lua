script.Parent.Touched:Connect(function(hit)
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.Open:Play()
end)