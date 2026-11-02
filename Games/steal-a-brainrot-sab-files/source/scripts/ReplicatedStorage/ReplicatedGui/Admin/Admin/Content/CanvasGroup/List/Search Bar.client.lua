local Players = game:GetService("Players")
local player = Players.LocalPlayer

local CONTENT_LABEL_NAME = "Text"

local mainFrame = script.Parent
local searchBarFrame = script.Parent.Parent.Parent.Parent.Header.Frame
local searchBox = searchBarFrame:FindFirstChildWhichIsA("TextBox")

local cachedFrames = {}

local function buildCache()
	for _, child in ipairs(mainFrame:GetChildren()) do
		if child:IsA("Frame") and child ~= searchBarFrame then
			local innerFrame = child:FindFirstChild("Frame")
			local textLabel = innerFrame and innerFrame:FindFirstChild(CONTENT_LABEL_NAME)

			if textLabel and textLabel:IsA("TextLabel") then
				cachedFrames[child] = textLabel
			end
		end
	end
end

local function filterFrames(searchText)
	local trimmed = searchText:match("^%s*(.-)%s*$")
	local isBlank = trimmed == ""

	if isBlank then
		for frame in next, cachedFrames do
			frame.Visible = true
		end
		return
	end

	local lowerSearch = trimmed:lower()

	for frame, textLabel in next, cachedFrames do
		frame.Visible = textLabel.Text:lower():find(lowerSearch, 1, true) ~= nil
	end
end

local debounceDelay = 0.01
local lastCall = 0

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local currentTime = tick()
	lastCall = currentTime

	task.delay(debounceDelay, function()
		if lastCall == currentTime then
			filterFrames(searchBox.Text)
		end
	end)
end)

buildCache()