local music = game.Workspace.Sounds:WaitForChild("patience")
local button = script.Parent
playing = true

script.Parent.MouseButton1Click:Connect(function()
	if playing == true then
		music.Playing = false
		button.Text = "On"
		playing = false
	else
		music.Playing = true
		button.Text = "Off"
		playing = true

	end
end)