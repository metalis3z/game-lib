script.Parent.MouseButton1Down:Connect(function()
	script.Parent.TextColor3 = Color3.fromRGB(0, 0, 0)
	script.Parent.TextStrokeTransparency = 0.7
	script.Parent.RemoteEvent:FireServer()
	wait(0.1)
	script.Parent.TextColor3 = Color3.fromRGB(255, 255, 255)
	script.Parent.TextStrokeTransparency = 1
end)