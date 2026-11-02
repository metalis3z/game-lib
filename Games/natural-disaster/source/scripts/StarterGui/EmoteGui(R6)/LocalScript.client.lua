local Button = script.Parent["Open/Close2"]

Button.MouseEnter:Connect(function()
	local MouseHover = Button.UIHoverSound
	MouseHover:Play()
end)

Button.MouseButton1Down:Connect(function()
	local MouseClick = Button.MouseClickSound
	MouseClick:Play()
end)