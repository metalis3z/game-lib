local players = game.Players
local runservice = game:GetService("RunService")
local minX = 136

runservice.RenderStepped:Connect(function(dt)
	for i, v in pairs(script.Parent.Frame.PlayerContainer:GetChildren()) do
		if v:IsA("ImageLabel") then
			if not players:FindFirstChild(v.Name) then
				v:Destroy()	
			end
		end
	end
	if game:GetService("ReplicatedStorage").Loaded.Value then
		for i, v in pairs(players:GetChildren()) do
			if v.Character == nil then
				return
			end
			if not v.Character:FindFirstChild("HumanoidRootPart") then
				return
			end
			local posX = v.Character.HumanoidRootPart.Position.X
			local uiPos = (posX - minX) / script.Parent.maxSize.Value
			if posX >= minX then
				if not script.Parent.Frame.PlayerContainer:FindFirstChild(v.Name) then
					local ThumbnailType = Enum.ThumbnailType.HeadShot
					local ThumbnailSize = Enum.ThumbnailSize.Size48x48
					local headshot = Instance.new("ImageLabel", script.Parent.Frame.PlayerContainer)
					headshot.Name = v.Name
					headshot.BackgroundTransparency = 1
					headshot.Image = players:GetUserThumbnailAsync(v.userId, ThumbnailType, ThumbnailSize)
					local uiaspect = Instance.new("UIAspectRatioConstraint", headshot)
					headshot.Size = UDim2.new(1,0,1,0)
				end
				if script.Parent.Frame.PlayerContainer:FindFirstChild(v.Name) then
					script.Parent.Frame.PlayerContainer:FindFirstChild(v.Name).Position = UDim2.new(uiPos,0,0,0)
				end
			end
		end
	else
		for i,v in pairs(script.Parent.Frame.PlayerContainer:GetChildren()) do
			if game.Players:FindFirstChild(v.Name) then
				v:Destroy()
			end
		end
	end
end)