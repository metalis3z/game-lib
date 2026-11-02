local SGui = script.Parent
local Frame = SGui:WaitForChild("Frame")
local Button = SGui:WaitForChild("TextButton")

Button.MouseButton1Up:Connect(function()
	Frame.Visible = not Frame.Visible
end)
