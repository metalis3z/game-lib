local textfocused = false
local uis = game:GetService("UserInputService")
uis.TextBoxFocused:Connect(function()
	textfocused = true
end)
uis.TextBoxFocusReleased:Connect(function()
	textfocused = false
end)
uis.InputBegan:Connect(function(input)
	if textfocused == true then
		script.Parent.Typing:FireServer("typing")
	end
	if textfocused == false then
		script.Parent.Typing:FireServer("nottyping")
	end
end)