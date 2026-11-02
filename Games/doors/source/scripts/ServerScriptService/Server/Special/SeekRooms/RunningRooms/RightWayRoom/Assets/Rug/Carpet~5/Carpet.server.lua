local d = false
script.Parent.Parent.Parent.Parent.RoomStart.Touched:Connect(function()
	if d == false then
		d = true
		for i = 1,1 do
			if script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("Carpet") then
				script.Parent.Color = script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("Carpet").Value
			end
		end
	end
end)