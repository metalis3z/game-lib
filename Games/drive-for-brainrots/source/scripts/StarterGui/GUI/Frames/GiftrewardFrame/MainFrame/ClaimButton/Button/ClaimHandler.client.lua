local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local button = script.Parent
local CheckInGroup = ReplicatedStorage:WaitForChild("CheckInGroup")
local Events = ReplicatedStorage:WaitForChild("Events")
local GiftClaimResult = Events:WaitForChild("GiftClaimResult")

local hasClaimed = false

button.MouseButton1Click:Connect(function()
	if hasClaimed then return end
	
	-- Fire the CheckInGroup remote to verify group membership
	CheckInGroup:FireServer()
end)

GiftClaimResult.OnClientEvent:Connect(function(success: boolean, message: string)
	if success then
		hasClaimed = true
		-- Update button to show claimed
		button.TextLabel.Text = "CLAIMED!"
		button.AutoButtonColor = false
		button.Interactable = false
		
		-- Change button appearance to show it's claimed
		local uiStroke = button.TextLabel:FindFirstChild("UIStroke")
		if uiStroke then
			uiStroke.Color = Color3.fromRGB(0, 255, 0)
		end
	else
		-- Show error feedback briefly
		local originalText = button.TextLabel.Text
		button.TextLabel.Text = message
		task.wait(2)
		if not hasClaimed then
			button.TextLabel.Text = originalText
		end
	end
end)
