while true do
	task.wait(1)
	script.Parent.Enabled = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value > 6
end