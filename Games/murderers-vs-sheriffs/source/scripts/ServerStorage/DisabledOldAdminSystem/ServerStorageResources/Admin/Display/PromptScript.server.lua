local ProximityPrompt_1 = script.Parent:WaitForChild("ProximityPrompt")
local function onTriggered()
	game.ReplicatedStorage.Remotes.Shop.GetAdmin:FireServer()
end
ProximityPrompt_1.Triggered:Connect(onTriggered)