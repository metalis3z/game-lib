-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local u1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local v4 = game:GetService("SoundService")
game:GetService("Debris")
local v5 = v2:WaitForChild("AdminMessageToAll")
local u6 = script.Parent
local u7 = v4:WaitForChild("AnnouncementSound")
v5.OnClientEvent:Connect(function(p8, p9)
	-- upvalues: (copy) u6, (copy) u1, (copy) u3, (copy) u7
	local u10 = Instance.new("Frame")
	u10.Name = "AdminMsgFrame"
	u10.Parent = u6
	u10.Size = UDim2.new(0.6, 0, 0.06, 0)
	u10.AnchorPoint = Vector2.new(0.5, 0)
	u10.Position = UDim2.new(0.5, 0, -0.1, 0)
	u10.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	u10.BackgroundTransparency = 0.15
	u10.BorderSizePixel = 0
	u10.ZIndex = 10
	local v11 = Instance.new("UICorner")
	v11.CornerRadius = UDim.new(0.5, 0)
	v11.Parent = u10
	local v12 = Instance.new("UIStroke")
	v12.Parent = u10
	v12.Thickness = 2
	v12.Transparency = 0.8
	v12.Color = Color3.fromRGB(255, 255, 255)
	local v13 = Instance.new("UIListLayout")
	v13.Parent = u10
	v13.FillDirection = Enum.FillDirection.Horizontal
	v13.VerticalAlignment = Enum.VerticalAlignment.Center
	v13.Padding = UDim.new(0, 12)
	local v14 = Instance.new("UIPadding")
	v14.Parent = u10
	v14.PaddingLeft = UDim.new(0, 8)
	v14.PaddingRight = UDim.new(0, 8)
	v14.PaddingTop = UDim.new(0, 4)
	v14.PaddingBottom = UDim.new(0, 4)
	local v15 = Instance.new("ImageLabel")
	v15.Parent = u10
	v15.Size = UDim2.new(0.8, 0, 0.8, 0)
	v15.SizeConstraint = Enum.SizeConstraint.RelativeYY
	v15.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	v15.BackgroundTransparency = 0
	local v16, _ = u1:GetUserThumbnailAsync(p8.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
	v15.Image = v16
	v15.ZIndex = 11
	local v17 = Instance.new("UICorner")
	v17.CornerRadius = UDim.new(1, 0)
	v17.Parent = v15
	local v18 = Instance.new("UIStroke")
	v18.Parent = v15
	v18.Thickness = 1
	v18.Color = Color3.fromRGB(150, 150, 150)
	v18.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	local v19 = Instance.new("TextLabel")
	v19.Parent = u10
	v19.Text = p8.Name .. " :"
	v19.TextColor3 = Color3.fromRGB(255, 80, 80)
	v19.Font = Enum.Font.GothamBold
	v19.BackgroundTransparency = 1
	v19.TextScaled = true
	local v20 = Instance.new("UITextSizeConstraint")
	v20.MaxTextSize = 24
	v20.MinTextSize = 12
	v20.Parent = v19
	v19.AutomaticSize = Enum.AutomaticSize.X
	v19.Size = UDim2.new(0, 0, 1, 0)
	v19.TextXAlignment = Enum.TextXAlignment.Left
	v19.ZIndex = 11
	v19.TextStrokeColor3 = Color3.new(0, 0, 0)
	v19.TextStrokeTransparency = 0
	local v21 = Instance.new("TextLabel")
	v21.Parent = u10
	v21.Text = p9
	v21.TextColor3 = Color3.fromRGB(255, 255, 255)
	v21.Font = Enum.Font.GothamSemibold
	v21.BackgroundTransparency = 1
	v21.TextScaled = true
	local v22 = Instance.new("UITextSizeConstraint")
	v22.MaxTextSize = 24
	v22.MinTextSize = 12
	v22.Parent = v21
	v21.Size = UDim2.new(1, 0, 1, 0)
	v21.TextXAlignment = Enum.TextXAlignment.Left
	v21.TextTruncate = Enum.TextTruncate.AtEnd
	v21.ZIndex = 11
	v21.TextStrokeColor3 = Color3.new(0, 0, 0)
	v21.TextStrokeTransparency = 0
	local v23 = UDim2.new(0.5, 0, 0.08, 0)
	local v24 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	u3:Create(u10, v24, {
		["Position"] = v23
	}):Play()
	local u25 = u7:Clone()
	u25.Parent = u6
	u25:Play()
	task.wait(8)
	local v26 = u3:Create(u10, v24, {
		["Position"] = UDim2.new(0.5, 0, -0.15, 0)
	})
	v26:Play()
	v26.Completed:Connect(function()
		-- upvalues: (copy) u10, (copy) u25
		u10:Destroy()
		u25:Destroy()
	end)
end)