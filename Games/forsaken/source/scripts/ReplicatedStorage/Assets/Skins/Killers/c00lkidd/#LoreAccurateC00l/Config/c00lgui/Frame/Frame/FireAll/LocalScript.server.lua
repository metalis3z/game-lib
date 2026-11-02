local button = script.Parent

button.MouseButton1Click:Connect(function()
	for i, v in ipairs(workspace.Map.Ingame:GetDescendants()) do
		if v:IsA("BasePart") then
			Instance.new("Fire", v).Size = 25
		end
	end
end)
