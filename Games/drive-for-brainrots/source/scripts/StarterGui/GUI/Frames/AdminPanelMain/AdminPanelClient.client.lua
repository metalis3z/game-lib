--!strict
-- Admin Panel Client Handler
-- Wires all admin panel buttons to the appropriate RemoteEvents

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local adminPanel = gui:WaitForChild("Frames"):WaitForChild("AdminPanelMain")
local Events = ReplicatedStorage:WaitForChild("Events")

-- Helper to safely get a RemoteEvent
local function getRemote(name: string): RemoteEvent?
	return Events:FindFirstChild(name) :: RemoteEvent?
end

-- Helper to find a button by name inside a parent
local function getButton(parent: Instance, name: string): ImageButton?
	local btn = parent:FindFirstChild(name)
	if btn and btn:IsA("ImageButton") then
		return btn
	end
	return nil
end

-- Helper to find a TextBox by name inside a parent
local function getTextBox(parent: Instance, name: string): TextBox?
	local tb = parent:FindFirstChild(name)
	if tb and tb:IsA("TextBox") then
		return tb
	end
	return nil
end

-- Helper to find a TextLabel by name inside a parent
local function getLabel(parent: Instance, name: string): TextLabel?
	local lbl = parent:FindFirstChild(name)
	if lbl and lbl:IsA("TextLabel") then
		return lbl
	end
	return nil
end

-- ── Close Button ──────────────────────────────────────────────────────────
local header = adminPanel:FindFirstChild("Header")
if header then
	local closeBtn = header:FindFirstChild("CloseButton")
	if closeBtn and closeBtn:IsA("ImageButton") then
		closeBtn.MouseButton1Click:Connect(function()
			adminPanel.Visible = false
		end)
	end
end

-- ── Get Scrolling Frame Sections ─────────────────────────────────────────
local scrollingFrame = adminPanel:FindFirstChild("InsiderFrame")
	and adminPanel.InsiderFrame:FindFirstChild("ScrollingFrame")
if not scrollingFrame then
	warn("[AdminPanel] ScrollingFrame not found")
	return
end

-- ── Events Section ──────────────────────────────────────────────────────
local eventsSection = scrollingFrame:FindFirstChild("Events")
if eventsSection then
	local eventNameBox = getTextBox(eventsSection, "EventName")
	local eventDurationBox = getTextBox(eventsSection, "Event Duration")

	local startBtn = getButton(eventsSection, "StartEvent")
	if startBtn then
		startBtn.MouseButton1Click:Connect(function()
			local eventName = eventNameBox and eventNameBox.Text or ""
			if eventName ~= "" then
				local remote = getRemote("AdminRunEvent")
				if remote then remote:FireServer(eventName) end
			end
		end)
	end

	local stopBtn = getButton(eventsSection, "StopEvent")
	if stopBtn then
		stopBtn.MouseButton1Click:Connect(function()
			local remote = getRemote("AdminStopEvent")
			if remote then remote:FireServer() end
		end)
	end

	local addEventBtn = getButton(eventsSection, "AddEvent")
	if addEventBtn then
		addEventBtn.MouseButton1Click:Connect(function()
			local eventName = eventNameBox and eventNameBox.Text or ""
			if eventName ~= "" then
				local remote = getRemote("AdminRunEvent")
				if remote then remote:FireServer(eventName) end
			end
		end)
	end

	local globalBtn = getButton(eventsSection, "Global")
	if globalBtn then
		globalBtn.MouseButton1Click:Connect(function()
			local remote = getRemote("AdminRunEvent")
			if remote then remote:FireServer("Global") end
		end)
	end
end

-- ── PlayerManagement Section ────────────────────────────────────────────
local pmSection = scrollingFrame:FindFirstChild("PlayerManagement")
if pmSection then
	local playerNameBox = getTextBox(pmSection, "PlayerName")

	local function onPmButton(btnName: string, remoteName: string)
		local btn = getButton(pmSection, btnName)
		if btn then
			btn.MouseButton1Click:Connect(function()
				local targetName = playerNameBox and playerNameBox.Text or ""
				if targetName ~= "" then
					local remote = getRemote(remoteName)
					if remote then remote:FireServer(targetName) end
				end
			end)
		end
	end

	onPmButton("Kick", "KickRemote")
	onPmButton("Ban", "BanRemote")
	onPmButton("Unban", "UnbanRemote")
	onPmButton("Warn", "WarnRemote")
	onPmButton("Mute", "MuteRemote")

	-- Temp-Ban sends duration too (default 300 seconds / 5 minutes)
	local tempBanBtn = getButton(pmSection, "Temp-Ban")
	if tempBanBtn then
		tempBanBtn.MouseButton1Click:Connect(function()
			local targetName = playerNameBox and playerNameBox.Text or ""
			if targetName ~= "" then
				local remote = getRemote("TempBanRemote")
				if remote then remote:FireServer(targetName, 300) end
			end
		end)
	end

	-- Teleport button (teleport admin to the target player)
	local tpBtn = getButton(pmSection, "Teleport")
	if tpBtn then
		tpBtn.MouseButton1Click:Connect(function()
			local targetName = playerNameBox and playerNameBox.Text or ""
			if targetName ~= "" then
				local remote = getRemote("TeleportToPlayerRemote")
				if remote then remote:FireServer(targetName) end
			end
		end)
	end

	-- AddPlayer and GiveAdmin are placeholder buttons
	local addPlayerBtn = getButton(pmSection, "AddPlayer")
	if addPlayerBtn then
		addPlayerBtn.MouseButton1Click:Connect(function()
			-- Future: Add player to a selection list
		end)
	end

	local giveAdminBtn = getButton(pmSection, "GiveAdmin")
	if giveAdminBtn then
		giveAdminBtn.MouseButton1Click:Connect(function()
			-- Future: Grant admin to a player
		end)
	end
end

-- ── Gifting and Spawning Section ────────────────────────────────────────
local giftSection = scrollingFrame:FindFirstChild("Gifting and Spawning")
if giftSection then
	local brainrotNameBox = getTextBox(giftSection, "BrainrotName")
	local brainrotBox = getTextBox(giftSection, "Brainrot")
	local playerNameBox = getTextBox(giftSection, "Playername")
	local zoneSelectBox = getTextBox(giftSection, "ZoneSelect")

	-- Give button: give a brainrot item to the specified player
	local giveBtn = getButton(giftSection, "Give")
	if giveBtn then
		giveBtn.MouseButton1Click:Connect(function()
			local itemName = brainrotNameBox and brainrotNameBox.Text or ""
			local targetName = playerNameBox and playerNameBox.Text or player.Name
			if itemName ~= "" then
				local remote = getRemote("GiveBrainrotRemote")
				if remote then remote:FireServer(itemName, "None", 1) end
			end
		end)
	end

	-- AddBrainrot button: give brainrot to yourself
	local addBrainrotBtn = getButton(giftSection, "AddBrainrot")
	if addBrainrotBtn then
		addBrainrotBtn.MouseButton1Click:Connect(function()
			local itemName = brainrotNameBox and brainrotNameBox.Text or ""
			if itemName ~= "" then
				local remote = getRemote("GiveBrainrotRemote")
				if remote then remote:FireServer(itemName, "None", 1) end
			end
		end)
	end

	-- AddBrainrotSpawn, SpawnGlobal, SendServeronly, AddPlayer, ZoneSelect
	-- These are placeholder buttons for future functionality
	local addBrainrotSpawnBtn = getButton(giftSection, "AddBrainrotSpawn")
	if addBrainrotSpawnBtn then
		addBrainrotSpawnBtn.MouseButton1Click:Connect(function()
			local itemName = brainrotNameBox and brainrotNameBox.Text or ""
			if itemName ~= "" then
				local remote = getRemote("GiveBrainrotRemote")
				if remote then remote:FireServer(itemName, "None", 1) end
			end
		end)
	end

	local spawnGlobalBtn = getButton(giftSection, "SpawnGlobal")
	if spawnGlobalBtn then
		spawnGlobalBtn.MouseButton1Click:Connect(function()
			local itemName = brainrotNameBox and brainrotNameBox.Text or ""
			if itemName ~= "" then
				local remote = getRemote("GiveBrainrotRemote")
				if remote then remote:FireServer(itemName, "None", 1) end
			end
		end)
	end

	local sendServerBtn = getButton(giftSection, "SendServeronly")
	if sendServerBtn then
		sendServerBtn.MouseButton1Click:Connect(function()
			local itemName = brainrotNameBox and brainrotNameBox.Text or ""
			if itemName ~= "" then
				local remote = getRemote("GiveBrainrotRemote")
				if remote then remote:FireServer(itemName, "None", 1) end
			end
		end)
	end

	local addPlayerBtn = getButton(giftSection, "AddPlayer")
	if addPlayerBtn then
		addPlayerBtn.MouseButton1Click:Connect(function()
			-- Future: Add player to gifting list
		end)
	end

	local zoneSelectBtn = getButton(giftSection, "ZoneSelect")
	if zoneSelectBtn then
		zoneSelectBtn.MouseButton1Click:Connect(function()
			-- Future: Select zone for spawning
		end)
	end
end

-- ── PlayerInfo Section ──────────────────────────────────────────────────
local piSection = scrollingFrame:FindFirstChild("PlayerInfo")
if piSection then
	local playerNameBox = getTextBox(piSection, "Playername")
	local bansLabel = getLabel(piSection, "Bans")
	local kicksLabel = getLabel(piSection, "Kicks")
	local tempBansLabel = getLabel(piSection, "TempBans")
	local warnsLabel = getLabel(piSection, "Warns")

	local checkBtn = getButton(piSection, "Check")
	if checkBtn then
		checkBtn.MouseButton1Click:Connect(function()
			local targetName = playerNameBox and playerNameBox.Text or ""
			if targetName ~= "" then
				local remote = getRemote("PlayerInfoRemote")
				if remote then remote:FireServer(targetName) end
			end
		end)
	end
end

-- ── Messaging Section ───────────────────────────────────────────────────
local msgSection = scrollingFrame:FindFirstChild("Messaging")
if msgSection then
	local messageBox = getTextBox(msgSection, "Message")

	local sendGlobalBtn = getButton(msgSection, "SendGlobal")
	if sendGlobalBtn then
		sendGlobalBtn.MouseButton1Click:Connect(function()
			local message = messageBox and messageBox.Text or ""
			if message ~= "" then
				local remote = getRemote("SendGlobalMessageRemote")
				if remote then remote:FireServer(message) end
			end
		end)
	end

	local sendServerBtn = getButton(msgSection, "SendServeronly")
	if sendServerBtn then
		sendServerBtn.MouseButton1Click:Connect(function()
			local message = messageBox and messageBox.Text or ""
			if message ~= "" then
				local remote = getRemote("SendServerMessageRemote")
				if remote then remote:FireServer(message) end
			end
		end)
	end
end

-- ── PlayerTracking Section ──────────────────────────────────────────────
local ptSection = scrollingFrame:FindFirstChild("PlayerTracking")
if ptSection then
	local playerNameBox = getTextBox(ptSection, "Playername")

	local tpToBtn = getButton(ptSection, "TptoPlayer")
	if tpToBtn then
		tpToBtn.MouseButton1Click:Connect(function()
			local targetName = playerNameBox and playerNameBox.Text or ""
			if targetName ~= "" then
				local remote = getRemote("TeleportToPlayerRemote")
				if remote then remote:FireServer(targetName) end
			end
		end)
	end

	local tpHereBtn = getButton(ptSection, "TpHere")
	if tpHereBtn then
		tpHereBtn.MouseButton1Click:Connect(function()
			local targetName = playerNameBox and playerNameBox.Text or ""
			if targetName ~= "" then
				local remote = getRemote("TeleportHereRemote")
				if remote then remote:FireServer(targetName) end
			end
		end)
	end
end

-- ── BrainrotInfo Section ────────────────────────────────────────────────
local biSection = scrollingFrame:FindFirstChild("BrainrotInfo")
if biSection then
	local checkBtn = getButton(biSection, "Check")
	if checkBtn then
		checkBtn.MouseButton1Click:Connect(function()
			-- Check own brainrot info
			local remote = getRemote("BrainrotInfoRemote")
			if remote then remote:FireServer(player.Name) end
		end)
	end
end

print("[AdminPanel] Client handler loaded")