local Sound = script.Parent.Parent.Parent.Sound

script.Parent.MouseButton1Click:Connect(function()
	if Sound then Sound:Play() end
end)