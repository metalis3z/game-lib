--!strict
-- Location: StarterPlayer/StarterPlayerScripts/EventUIController
-- Atualiza as imagens dos eventos ativos no HUD, mostrando o tempo restante
-- com texto branco e borda preta. Suporta varios eventos simultaneos (lado a lado).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local EventConfig = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("EventConfig"))

-- Wait for the Events frame
local eventsFrame = playerGui:WaitForChild("UI"):WaitForChild("Events")

-- Remote references
local eventRemotes = ReplicatedStorage:WaitForChild("EventRemotes")
local startRemote = eventRemotes:WaitForChild("StartEvent")
local endRemote = eventRemotes:WaitForChild("EndEvent")
local getActiveRemote = eventRemotes:WaitForChild("GetActiveEvents")

-- State: activeEvents[key] = endTime (os.clock)
local activeEvents = {}

-- Template used to create labels for events that have no pre-made image
local templateLabel = eventsFrame:FindFirstChild("Love")

-- Helper: format seconds as MM:SS
local function formatTime(seconds: number): string
	seconds = math.max(0, math.floor(seconds))
	local mins = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", mins, secs)
end

-- Helper: get (or create) an ImageLabel for an event key
local function getEventLabel(eventKey: string)
	local label = eventsFrame:FindFirstChild(eventKey)
	if label and label:IsA("ImageLabel") then
		return label
	end

	-- ServerLuck variants (2x/4x/8x) share the pre-made "ServerLuck" template
	local templateName = "ServerLuck"
	if eventKey:sub(1, #"ServerLuck") ~= "ServerLuck" then
		templateName = eventKey
	end

	local template = eventsFrame:FindFirstChild(templateName)
	if not template or not template:IsA("ImageLabel") then
		template = templateLabel
	end
	if not template then return nil end

	-- Create a new label from the template
	local newLabel = template:Clone()
	newLabel.Name = eventKey
	newLabel.LayoutOrder = 100
	local config = EventConfig.Events[eventKey]
	if config and config.Image then
		newLabel.Image = config.Image
	end
	newLabel.Parent = eventsFrame
	return newLabel
end

-- Helper: update the UI based on active events
local function updateUI()
	-- os.time() (relogio real) em vez de os.clock() (tempo de processo local do cliente,
	-- que nao bate com o endTime calculado pelo servidor)
	local now = os.time()

	-- Hide all event labels first
	for _, child in ipairs(eventsFrame:GetChildren()) do
		if child:IsA("ImageLabel") then
			child.Visible = false
		end
	end

	-- Show active events with their countdown
	local visibleCount = 0
	for key, endTime in pairs(activeEvents) do
		local remaining = endTime - now
		if remaining <= 0 then
			activeEvents[key] = nil
		else
			local label = getEventLabel(key)
			if label then
				label.Visible = true
				visibleCount += 1
				local value = label:FindFirstChild("Value")
				if value and value:IsA("TextLabel") then
					-- For ServerLuck events, show the multiplier (2x/4x/8x) instead of the countdown
					local config = EventConfig.Events[key]
					if config and config.ShowMultiplier then
						value.Text = tostring(config.Multiplier) .. "x"
					else
						value.Text = formatTime(remaining)
					end
					-- Ensure white text and black border
					value.TextColor3 = Color3.new(1, 1, 1)
					local stroke = value:FindFirstChildOfClass("UIStroke")
					if stroke then
						stroke.Color = Color3.new(0, 0, 0)
						stroke.Thickness = 3
					end
				end
			end
		end
	end

	-- Size the frame to fit the visible images side by side (90px each + 8px padding)
	local width = visibleCount > 0 and (visibleCount * 90 + (visibleCount - 1) * 8) or 0
	eventsFrame.Size = UDim2.fromOffset(width, 90)
end

-- Listen to event start/end
startRemote.OnClientEvent:Connect(function(eventKey, endTime)
	activeEvents[eventKey] = endTime
	updateUI()
end)

endRemote.OnClientEvent:Connect(function(eventKey)
	activeEvents[eventKey] = nil
	updateUI()
end)

-- Initial sync for late joiners
local ok, result = pcall(function()
	return getActiveRemote:InvokeServer()
end)
if ok and type(result) == "table" then
	for key, endTime in pairs(result) do
		activeEvents[key] = endTime
	end
end

-- Main loop: update countdown every 0.5s
updateUI()
task.spawn(function()
	while true do
		updateUI()
		task.wait(0.5)
	end
end)
