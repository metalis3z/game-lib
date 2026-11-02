local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)

-- Find all ScrollingFrames with attribute Key="Money" in the Workspace
local function findLeaderboardFrames()
	local frames = {}
	for _, descendant in ipairs(game.Workspace:GetDescendants()) do
		if descendant:IsA("ScrollingFrame") and descendant:GetAttribute("Key") == "Money" then
			table.insert(frames, descendant)
		end
	end
	return frames
end

-- Get entry frames from a ScrollingFrame (frames whose name starts with "Player_")
local function getEntryFrames(scrollingFrame)
	local frames = {}
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if child:IsA("Frame") and string.sub(child.Name, 1, 7) == "Player_" then
			table.insert(frames, child)
		end
	end
	table.sort(frames, function(a, b)
		return a.LayoutOrder < b.LayoutOrder
	end)
	return frames
end

-- Populate an entry frame with player data
local function populateEntry(entryFrame, player, money)
	-- Set thumbnail
	local holderThumb = entryFrame:FindFirstChild("Holder_Thumbnail")
	if holderThumb then
		local imageLabel = holderThumb:FindFirstChild("ImageLabel_PlayerThumb")
		if imageLabel and imageLabel:IsA("ImageLabel") then
			imageLabel.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", player.UserId)
		end
	end

	-- Set player name
	local holderName = entryFrame:FindFirstChild("Holder_PlayerName")
	if holderName then
		local display = holderName:FindFirstChild("Display")
		if display then
			local textLabel = display:FindFirstChild("TextLabel_PlayerName")
			if textLabel and textLabel:IsA("TextLabel") then
				textLabel.Text = player.Name
			end
		end
	end

	-- Set money value
	local holderValue = entryFrame:FindFirstChild("Holder_Value")
	if holderValue then
		local holder = holderValue:FindFirstChild("Holder")
		if holder then
			local textLabel = holder:FindFirstChild("TextLabel_Value")
			if textLabel and textLabel:IsA("TextLabel") then
				textLabel.Text = Simple.FormatCompact(money, ".##")
			end
		end
	end

	entryFrame.Visible = true
end

-- Update a single leaderboard ScrollingFrame
local function updateLeaderboard(scrollingFrame, entryFrames)
	-- Collect players with Money leaderstats
	local playerData = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local money = leaderstats:FindFirstChild("Money")
			if money and money:IsA("NumberValue") then
				table.insert(playerData, {player = player, money = money.Value})
			end
		end
	end

	-- Sort by money descending
	table.sort(playerData, function(a, b)
		return a.money > b.money
	end)

	-- Populate entry frames
	for i, entryFrame in ipairs(entryFrames) do
		if i <= #playerData then
			local data = playerData[i]
			populateEntry(entryFrame, data.player, data.money)
			entryFrame.LayoutOrder = i
		else
			entryFrame.Visible = false
		end
	end
end

-- Main update loop
task.spawn(function()
	while task.wait(2) do
		local scrollingFrames = findLeaderboardFrames()
		for _, sf in ipairs(scrollingFrames) do
			local entryFrames = getEntryFrames(sf)
			updateLeaderboard(sf, entryFrames)
		end
	end
end)