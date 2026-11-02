local WindowService = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"))

script.Parent.Activated:Connect(function()
	WindowService:ToggleFrame("CurrentEvent")
end)

--// Scripted By @PlayFede