function onTouched(part)
	local Humanoid = part.Parent:findFirstChild("Humanoid")
	if Humanoid then
		Humanoid.Health = Humanoid.Health -10
	end
end
script.Parent.Touched:Connect(onTouched)