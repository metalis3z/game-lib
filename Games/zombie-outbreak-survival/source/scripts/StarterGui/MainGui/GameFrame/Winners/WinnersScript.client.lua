local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GUI References
local winnersFrame = script.Parent
local winnersBox = winnersFrame:WaitForChild("WinnersBox")
local template = winnersBox:WaitForChild("Template")
local title = winnersFrame:WaitForChild("Title")

-- Remote Events
local RoundWinners = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RoundWinners")

-- Hide template
template.Visible = false

-- Function to create winner entry with profile image
local function createWinnerEntry(userId, playerName, isSurvivor)
	local entry = template:Clone()
	entry.Visible = true
	entry.Parent = winnersBox
	
	local imageLabel = entry:WaitForChild("Image")
	local textLabel = entry:WaitForChild("Text")
	
	-- Set profile image
	local success, result = pcall(function()
		return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
	end)
	
	if success and result then
		imageLabel.Image = result
	else
		-- Fallback to default image if profile image fails
		imageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end

	-- Set text and colors in TextLabel only
	if isSurvivor then
		textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
		textLabel.Text = playerName .. "\nSURVIVED"
	else
		textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		textLabel.Text = playerName .. "\nDEFEATED"
	end
	
	return entry
end

-- Function to get player info from userId
local function getPlayerInfo(userId)
	local player = Players:GetPlayerByUserId(userId)
	if player then
		return player.DisplayName, player.UserId
	end
	return "Player " .. userId, userId
end

-- Function to show winners
local function showWinners(winners, statsSummary)
	-- Clear existing entries
	for _, child in winnersBox:GetChildren() do
		if child ~= template and child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	-- Update title
	if #winners > 0 then
		title.Text = "🏆 VICTORY! " .. #winners .. " Survivors!"
		title.TextColor3 = Color3.fromRGB(255, 215, 0)
	else
		title.Text = "💀 DEFEAT!"
		title.TextColor3 = Color3.fromRGB(255, 0, 0)
	end
	
	-- Process player statistics
	if statsSummary and statsSummary.PlayerStats then
		local survivors = {}
		local defeated = {}
		
		-- Collect player data
		for userId, playerStats in pairs(statsSummary.PlayerStats) do
			local playerName, playerUserId = getPlayerInfo(userId)
			
			if playerStats.Survived then
				table.insert(survivors, {Name = playerName, UserId = playerUserId})
			else
				table.insert(defeated, {Name = playerName, UserId = playerUserId})
			end
		end
		
		-- Create survivor entries
		for _, survivor in ipairs(survivors) do
			createWinnerEntry(survivor.UserId, survivor.Name, true)
		end
		
		-- Create defeated entries
		for _, defeatedPlayer in ipairs(defeated) do
			createWinnerEntry(defeatedPlayer.UserId, defeatedPlayer.Name, false)
		end
		
		-- Update canvas size
		winnersBox.CanvasSize = UDim2.new(0, 0, 0, (#survivors + #defeated) * 50)
	end
	
	-- Show frame immediately
	winnersFrame.Visible = true
	winnersFrame.Size = UDim2.new(0.675886989, 0, 0.524553776, 0)
	winnersFrame.Position = UDim2.new(0.161421686, 0, 0.237314776, 0)
	
	-- Auto-hide after 10 seconds
	task.wait(10)
	winnersFrame.Visible = false
end

-- Connect to remote event
RoundWinners.OnClientEvent:Connect(showWinners)