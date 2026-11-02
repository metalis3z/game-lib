local rs = game:GetService("ReplicatedStorage")
wait(0.1)

if rs.Loaded.Value == true then
	for i, v in pairs(script.Parent.Frame.ColorContainer:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end

	local fullSize = 0
	fullSize = (workspace.Lobby.FirstEndPoint.Position - workspace.Lobby:WaitForChild("LastEndPoint").Position).magnitude
	script.Parent.maxSize.Value = fullSize
	for i = 1,41,1 do
		local frame = Instance.new("Frame")
		frame.Parent = script.Parent.Frame.ColorContainer
		local stageSize = rs.TopBarAssets["Stage" .. i .. "Size"].Value
		frame.Size = UDim2.new(stageSize / fullSize, 0, 1, 0)
		frame.BackgroundColor3 = rs.TopBarAssets["Stage" .. i .. "Color"].Value
		frame.BorderSizePixel = 0  
		frame.Name = "Stage" .. i .. "ColorFrame"
	end
end

rs.Loaded.Changed:Connect(function(value)
	if value == true then
		for i, v in pairs(script.Parent.Frame.ColorContainer:GetChildren()) do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end

		local fullSize = 0
		for i = 1, 41, 1 do
			fullSize += rs.TopBarAssets["Stage" .. i .. "Size"].Value
		end
		script.Parent.maxSize.Value = fullSize
		for i = 1,41,1 do
			local frame = Instance.new("Frame")
			frame.Parent = script.Parent.Frame.ColorContainer
			local stageSize = rs.TopBarAssets["Stage" .. i .. "Size"].Value
			frame.Size = UDim2.new(stageSize / fullSize, 0, 1, 0)
			frame.BackgroundColor3 = rs.TopBarAssets["Stage" .. i .. "Color"].Value
			frame.BorderSizePixel = 0  
			frame.Name = "Stage" .. i .. "ColorFrame"
		end
	end
end)