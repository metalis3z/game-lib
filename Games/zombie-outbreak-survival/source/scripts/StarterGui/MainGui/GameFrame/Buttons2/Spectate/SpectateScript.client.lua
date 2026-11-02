local cam = workspace.CurrentCamera
local btn = script.Parent
local plr = game.Players.LocalPlayer

-- UI References
local toggleFrame = btn.Parent.Parent:WaitForChild("Toggle")
local nameLabel = toggleFrame:WaitForChild("Player")

-- Variables
local isVisible = false -- Track toggle state
local plrNum = 1
local playingTeam = "Alive"

-- Setup Sound
local click = Instance.new("Sound")
click.Name = "ClickSound"
click.SoundId = "rbxassetid://452267918"
click.Volume = 0.5
click.Parent = btn

-- Helper: Get players currently in the "Alive" team
local function getPlaying()
	local pInRound = {}
	for _, p in ipairs(game.Players:GetPlayers()) do
		if p.Team and p.Team.Name == playingTeam then 
			table.insert(pInRound, p) 
		end
	end
	return pInRound
end

-- Function to Switch Subject
local function switch(dir)
	local list = getPlaying()

	if #list == 0 then 
		nameLabel.Text = "No players to spectate"
		if plr.Character then cam.CameraSubject = plr.Character:FindFirstChild("Humanoid") end
		return 
	end

	plrNum = (plrNum + dir - 1) % #list + 1
	local target = list[plrNum]

	if target and target.Character then
		local hum = target.Character:FindFirstChild("Humanoid")
		if hum then
			cam.CameraSubject = hum
			nameLabel.Text = target.DisplayName
		end
	end
end

-- Function to Toggle UI
local function toggle()
	isVisible = not isVisible -- Switch the true/false state

	if isVisible then
		-- MAKE VISIBLE
		toggleFrame.Visible = true
		local list = getPlaying()

		-- Position Tween (Slide Up)
		toggleFrame:TweenPosition(UDim2.new(0.5, 0, 0.9, 0), "Out", "Sine", 0.3, true)

		if #list == 0 then
			nameLabel.Text = "No players to spectate"
		else
			switch(0) -- Start spectating first person
		end
	else
		-- HIDE
		-- Position Tween (Slide Down)
		toggleFrame:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "In", "Sine", 0.3, true)

		-- Wait for tween to finish before setting Visible to false
		task.delay(0.3, function()
			if not isVisible then toggleFrame.Visible = false end
		end)

		-- Reset camera to self
		if plr.Character then
			cam.CameraSubject = plr.Character:FindFirstChild("Humanoid")
		end
	end
end

-- Main Button Click
btn.MouseButton1Click:Connect(function()
	click:Play()
	toggle()
end)

-- Next/Previous Buttons
toggleFrame.Next.MouseButton1Click:Connect(function() 
	click:Play()
	switch(1) 
end)

toggleFrame.Previous.MouseButton1Click:Connect(function() 
	click:Play()
	switch(-1) 
end)

-- Continuous Check: If the person you watch dies
game:GetService("RunService").Heartbeat:Connect(function()
	if isVisible then
		local list = getPlaying()
		if #list == 0 and nameLabel.Text ~= "No players to spectate" then
			nameLabel.Text = "No players to spectate"
			if plr.Character then cam.CameraSubject = plr.Character:FindFirstChild("Humanoid") end
		end
	end
end)