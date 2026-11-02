local button = script.Parent

button.Activated:Connect(function()
	local baseFrame = game.StarterGui.News:FindFirstChild("News")
	if baseFrame then
		baseFrame.Visible = true
	end
end)