local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local runs = game:GetService("RunService")
local camera = workspace.CurrentCamera
local isRunning = false
player:WaitForChild("PlayerGui"):WaitForChild("Confirmation", 60)
local confirmation = player.PlayerGui.Confirmation

script.Parent.Activated:Connect(function()
	if script:FindFirstChild("Debounce") then
		return
	end
	if player.PlayerGui.NewScooter.Black.BackgroundTransparency == 1 then
		confirmation.Enabled = true
		confirmation.BoxConfirmation.Main.Inside.Content.Label.Text = "Are you sure you want to purchase Neon Box #1?"
		confirmation.Decision.Value = ""
		local decisionMade = false
		confirmation.Decision.Changed:Connect(function()
			decisionMade = true
		end)
		repeat
			wait(0.01)
		until decisionMade
		local debounce = Instance.new("BoolValue", script)
		debounce.Name = "Debounce"
		game:GetService("Debris"):AddItem(debounce, 1)
		if confirmation.Decision.Value == "Yes" then
			confirmation.Enabled = false
			if #workspace.Boxes:GetChildren() == 0 then
				isRunning = false
			end
			if player:WaitForChild("leaderstats").Coins.Value >= 3500 and not isRunning then
				player.PlayerGui.GameGUI.Enabled = false
				rs.RemoteEvents.neonCrateRequest:FireServer()
			end
		else
			confirmation.Enabled = false
		end
	end
end)
