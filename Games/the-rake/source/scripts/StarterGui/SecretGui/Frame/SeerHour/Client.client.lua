script.Parent.MouseButton1Down:Connect(function()
	script.Parent.TextColor3 = Color3.fromRGB(0, 0, 0)
	script.Parent.TextStrokeTransparency = 0.5
script.Parent.Font = Enum.Font.Garamond
	script.Parent.RemoteEvent:FireServer()
	wait(0.1)
	script.Parent.TextColor3 = Color3.fromRGB(255, 255, 255)
	script.Parent.TextStrokeTransparency = 1
	script.Parent.Font = Enum.Font.SourceSans
end)