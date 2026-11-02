local ChocolateKeycapManager = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")

local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
local Config = require(ReplicatedStorage:WaitForChild("Config"))
local WinsMultiplierManager = require(ServerScriptService:WaitForChild("WinsMultiplierManager"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")
local ShowWin = Remotes:WaitForChild("ShowWin")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

-- ============================
-- CONFIGURATION
-- ============================
local INTERVAL = 2            -- Every 2 seconds
local KEYCAPS_PER_TICK = 1    -- One keycap turns chocolate each interval
local DEBOUNCE_TIME = 3       -- Debounce per player (seconds)
local BONUS_MULTIPLIER = 2    -- x2 the last win amount
local CHOCOLATE_COLOR = Color3.fromRGB(75, 42, 20)
local CHOCOLATE_MATERIAL = Enum.Material.Sand

local TOPIC = "ChocolateKeycapEvent"

-- ============================
-- STATE
-- ============================
local isActive = false
local loopThread = nil
local chocolateKeycaps = {}   -- [part] = {color, material}
local touchConnections = {}   -- [part] = connection
local playerDebounce = {}     -- [player] = lastTouchTime

-- ============================
-- HELPERS
-- ============================
local function getKeycapParts()
	local keycaps = {}
	local descendants = workspace:GetDescendants()
	for _, v in ipairs(descendants) do
		if v:IsA("BasePart") and string.find(string.lower(v.Name), "keycap") then
			table.insert(keycaps, v)
		end
	end
	return keycaps
end

local function revertKeycap(part)
	if chocolateKeycaps[part] then
		part.Color = chocolateKeycaps[part].color
		part.Material = chocolateKeycaps[part].material
		part.CanTouch = chocolateKeycaps[part].canTouch
		chocolateKeycaps[part] = nil
	end
	if touchConnections[part] then
		touchConnections[part]:Disconnect()
		touchConnections[part] = nil
	end
end

local function cleanupAll()
	for part, _ in pairs(chocolateKeycaps) do
		revertKeycap(part)
	end
end

local function giveChocolateBonus(player, part)
	local data = DataHandler.Get(player)
	if not data then return end

	local lastTouch = playerDebounce[player] or 0
	if os.clock() - lastTouch < DEBOUNCE_TIME then return end

	local lastWinAmount = data.LastWinAmount or 0
	if lastWinAmount <= 0 then return end -- No previous win collected yet

	local bonus = math.floor(lastWinAmount * BONUS_MULTIPLIER)

	data.Wins = data.Wins + bonus
	playerDebounce[player] = os.clock()

	-- Auto-upgrade StepBonus
	local newStepBonus = Config.GetBestStepBonus(data.Wins)
	if newStepBonus ~= data.StepBonus then
		data.StepBonus = newStepBonus
	end

	-- Update leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats and leaderstats:FindFirstChild("Wins") then
		leaderstats.Wins.Value = data.Wins
	end

	-- Update client UI
	pcall(function()
		UpdateUI:FireClient(player, {Wins = data.Wins, StepBonus = data.StepBonus})
	end)
	pcall(function()
		ShowWin:FireClient(player, bonus)
	end)

	-- Revert the keycap after touch
	revertKeycap(part)
end

local function makeChocolate(part)
	if chocolateKeycaps[part] then return end
	if not part or not part.Parent then return end

	chocolateKeycaps[part] = {
		color = part.Color,
		material = part.Material,
		canTouch = part.CanTouch,
	}
	part.Color = CHOCOLATE_COLOR
	part.Material = CHOCOLATE_MATERIAL
	part.CanTouch = true -- Ensure touch events fire reliably

	-- Touch handler
	touchConnections[part] = part.Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			giveChocolateBonus(player, part)
		end
	end)

	-- Chocolate keycaps stay until a player steps on them (no auto-revert)
end

local function runLoop()
	while isActive do
		local allKeycaps = getKeycapParts()

		-- Filter out already chocolate ones
		local available = {}
		for _, k in ipairs(allKeycaps) do
			if not chocolateKeycaps[k] then
				table.insert(available, k)
			end
		end

		-- Pick random keycaps
		local count = math.min(KEYCAPS_PER_TICK, #available)
		for i = 1, count do
			if #available > 0 then
				local idx = math.random(1, #available)
				local part = available[idx]
				makeChocolate(part)
				table.remove(available, idx)

				-- Announce which keycap turned chocolate
				pcall(function()
					AdminAnnounce:FireAllClients({
						text = string.format("🍫 A chocolate keycap has spawned! Find it and step on it for x2 wins!"),
						senderName = "Event",
						senderUserId = 0,
						isOwner = false,
					})
				end)
			end
		end

		task.wait(INTERVAL)
	end
end

-- ============================
-- NOTIFY
-- ============================
local function notifyClients(active, duration)
	pcall(function()
		AdminAnnounce:FireAllClients({
			text = active and "🍫 RAIN OF CHOCOLATE ACTIVATED! Step on chocolate keycaps to earn x2 your last win amount!" or "🍫 RAIN OF CHOCOLATE has ended!",
			senderName = "Event",
			senderUserId = 0,
			isOwner = false,
		})
	end)
end

-- ============================
-- INTERNAL (no publish)
-- ============================
local function _startInternal(duration)
	isActive = true
	loopThread = task.spawn(runLoop)

	if duration and duration > 0 then
		task.delay(duration, function()
			if isActive then
				ChocolateKeycapManager.Stop()
			end
		end)
	end
end

local function _stopInternal()
	isActive = false
	if loopThread then
		pcall(function() task.cancel(loopThread) end)
		loopThread = nil
	end
	cleanupAll()
	playerDebounce = {}
end

-- ============================
-- PUBLIC API
-- ============================
function ChocolateKeycapManager.Start(duration)
	if isActive then
		return false, "Event is already active!"
	end

	_startInternal(duration)
	notifyClients(true, duration)

	pcall(function()
		MessagingService:PublishAsync(TOPIC, {action = "start", duration = duration})
	end)

	return true
end

function ChocolateKeycapManager.Stop()
	if not isActive then
		return false, "Event is not active!"
	end

	_stopInternal()
	notifyClients(false)

	pcall(function()
		MessagingService:PublishAsync(TOPIC, {action = "stop"})
	end)

	return true
end

function ChocolateKeycapManager.GetStatus()
	return {
		active = isActive,
	}
end

-- ============================
-- CROSS-SERVER SYNC
-- ============================
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) ~= "table" then return end

		if data.action == "start" then
			if not isActive then
				_startInternal(data.duration)
				notifyClients(true, data.duration)
			end
		elseif data.action == "stop" then
			if isActive then
				_stopInternal()
				notifyClients(false)
			end
		end
	end)
end)

-- ============================
-- CLEANUP ON PLAYER LEAVE
-- ============================
Players.PlayerRemoving:Connect(function(player)
	playerDebounce[player] = nil
end)

return ChocolateKeycapManager