local current = 1
script.Parent.Visible = true
script.Parent.NextButton.MouseButton1Click:Connect(function()

	if current < 5 then
		current = current+1
		if current == 0 then
			current = 1
		elseif current == 5 then
			script.Parent.Visible = false
		end
		for i,v in pairs(script.Parent.Frames:GetChildren()) do
			v.Visible = false
		end
		if current ~= 5 then
			script.Parent.Frames:FindFirstChild(current).Visible = true
		end
	end
end)

script.Parent.BackButton.MouseButton1Click:Connect(function()

	if current > 0 then
		current = current-1
		if current == 0 then
			current = 1
		elseif current == 5 then
			current = 4
		end
		for i,v in pairs(script.Parent.Frames:GetChildren()) do
			v.Visible = false
		end
		script.Parent.Frames:FindFirstChild(current).Visible = true
	end
end)