local d = false
script.Parent.Parent.Parent.Parent.RoomStart.Touched:Connect(function()
	if d == false then
		d = true
		for i = 1,1 do
			if script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("CarpetLight") then
				script.Parent.Color = script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("CarpetLight").Value
				if script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("Texture") then
					script.Parent.Parent.Parent.Parent.Colors.Carpet:FindFirstChild("Texture").Parent = script.Parent
				end
			end
		end
	end
end)