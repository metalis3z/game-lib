local playersService = game:GetService("Players")

function createFrame(player)
	local clonedFrame = script.Frame:Clone()
	clonedFrame.LocalScript.Disabled = false
	clonedFrame.Name = player.Name
	clonedFrame.BackgroundColor3 = Color3.fromRGB(math.random(50,255), math.random(50,255), math.random(50,255))
	clonedFrame.Visible = true
	clonedFrame.Parent = script.Parent

	local content, isReady = playersService:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	repeat wait() until isReady
	clonedFrame.Thumbnail.Image = content
end

for _,player in pairs(playersService:GetPlayers()) do
	createFrame(player)
end

playersService.PlayerAdded:Connect(function(player)
	createFrame(player)
end)

playersService.PlayerRemoving:Connect(function(player)
	local playerFrame = script.Parent:FindFirstChild(player.Name)
	if not playerFrame then return end
	playerFrame:Destroy()
end)