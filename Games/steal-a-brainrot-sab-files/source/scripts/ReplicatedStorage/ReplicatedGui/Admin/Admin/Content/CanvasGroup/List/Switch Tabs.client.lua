
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton) 

local tabsFrame = script.Parent.Tabs.Frame.Frame
local mainFrame = script.Parent

local categories = {
	Player  = {"Announcement", "Gear", "Money", "Rebirth", "Morph", "Multi", "PlrMorph", "Steal", "Spins"},
	Machine = {"Machines", "Trader", "Craft", "Fuse", "Limited", "PercentOverride", "Cupid"},
	Event   = {"Events", "Luck", "Mutations", "Ritual", "Sammy Base", "Sammy Snap"},
	Spawn   = {"Spawn", "Base"},
	Other   = {"Bot", "Countdown", "LuckyBlock", "Poll", "Time","FakeRequest", "Code"},
}

local CurrentlyDisabled = {
}

local SELECTED_BUTTON_COLOR = Color3.fromRGB(169, 169, 169)
local SELECTED_STROKE_COLOR = Color3.fromRGB(0, 0, 0)

local originalColors = {}

local allFrames = {}
for _, list in pairs(categories) do
	for _, frameName in ipairs(list) do
		local f = mainFrame:FindFirstChild(frameName)
		if f then
			table.insert(allFrames, f)
		end
	end
end

local activeCategory = nil
local buttonMap = {}

local function isFrameDisabled(frameName)
	for _, disabledName in ipairs(CurrentlyDisabled) do
		if disabledName == frameName then
			return true
		end
	end
	return false
end

local function enforceDisabledFrames()
	for _, frameName in ipairs(CurrentlyDisabled) do
		local f = mainFrame:FindFirstChild(frameName)
		if f then
			f.Visible = false
		end
	end
end

local function setButtonSelected(button, selected)
	local originalData = originalColors[button]
	if not originalData then return end

	if selected then
		button.BackgroundColor3 = SELECTED_BUTTON_COLOR
		if originalData.stroke then
			originalData.stroke.Color = SELECTED_STROKE_COLOR
		end
	else
		button.BackgroundColor3 = originalData.color
		if originalData.stroke then
			originalData.stroke.Color = originalData.strokeColor
		end
	end
end

local function showAll()
	for _, f in ipairs(allFrames) do
		if not isFrameDisabled(f.Name) then
			f.Visible = true
		end
	end
	enforceDisabledFrames()
end

local function showOnly(categoryName)
	for _, f in ipairs(allFrames) do
		f.Visible = false
	end
	for _, frameName in ipairs(categories[categoryName]) do
		if not isFrameDisabled(frameName) then
			local f = mainFrame:FindFirstChild(frameName)
			if f then
				f.Visible = true
			end
		end
	end
	enforceDisabledFrames()
end

local function toggleCategory(categoryName)
	local clickedButton = buttonMap[categoryName]

	if activeCategory == categoryName then
		setButtonSelected(clickedButton, false)
		activeCategory = nil
		showAll()
	else
		if activeCategory then
			local prevButton = buttonMap[activeCategory]
			if prevButton then
				setButtonSelected(prevButton, false)
			end
		end

		activeCategory = categoryName
		setButtonSelected(clickedButton, true)
		showOnly(categoryName)
	end
end

for categoryName, _ in pairs(categories) do
	local button = tabsFrame:FindFirstChild(categoryName)
	if button then
		local stroke = button:FindFirstChildOfClass("UIStroke")
		originalColors[button] = {
			color       = button.BackgroundColor3,
			stroke      = stroke,
			strokeColor = stroke and stroke.Color or Color3.new(1, 1, 1),
		}

		buttonMap[categoryName] = button

		local animBtn = AnimatedButton.new(button)
		animBtn:Animate()
		animBtn.OnActivated:Connect(function()
			toggleCategory(categoryName)
		end)
	else
		warn("Button not found for category:", categoryName)
	end
end

showAll()

task.spawn(function()
	while task.wait(0.5) do
		enforceDisabledFrames()
	end
end)

for _, frameName in ipairs(CurrentlyDisabled) do
	local f = mainFrame:FindFirstChild(frameName)
	if f then
		f:GetPropertyChangedSignal("Visible"):Connect(function()
			if f.Visible then
				f.Visible = false
			end
		end)
	end
end