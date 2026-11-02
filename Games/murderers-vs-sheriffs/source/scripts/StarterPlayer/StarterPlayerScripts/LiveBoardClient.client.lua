local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local getLiveBoardData = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Extras"):WaitForChild("GetLiveBoardData")
local board = workspace:WaitForChild("LiveBoard")
local ui = board:WaitForChild("Leaderboard"):WaitForChild("UI")
local buttonsFrame = ui:WaitForChild("Buttons")
local leaderboards = ui:WaitForChild("Leaderboards")
local title = ui:WaitForChild("Title")
local totalTitle = title:FindFirstChild("TotalTitle")

local categories = {"Murderer", "Sheriff", "Innocent"}
local activeCategory = "Murderer"
local rowTemplate

local function formatCount(value)
	value = tostring(math.floor(tonumber(value) or 0))
	while true do
		local nextValue, replacements = value:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		value = nextValue
		if replacements == 0 then break end
	end
	return value
end

local function getTemplate()
	if rowTemplate then return rowTemplate end
	local valueBoard = leaderboards:FindFirstChild("Value")
	if valueBoard then
		for _, child in ipairs(valueBoard:GetChildren()) do
			if child:IsA("GuiObject") and child.Name == "LeaderboardTemplate" then
				rowTemplate = child:Clone()
				break
			end
		end
	end
	if not rowTemplate then
		rowTemplate = Instance.new("ImageLabel")
		rowTemplate.Name = "LeaderboardTemplate"
		rowTemplate.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
		rowTemplate.BackgroundTransparency = 0
		rowTemplate.Size = UDim2.new(0.95, 0, 0.1, 0)
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = rowTemplate
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Parent = rowTemplate
	end
	rowTemplate.Visible = true
	return rowTemplate
end

local function clearBoard(scroller)
	for _, child in ipairs(scroller:GetChildren()) do
		if child:IsA("GuiObject") and child.Name ~= "LeaderboardTemplate" then
			child:Destroy()
		elseif child:IsA("GuiObject") and child.Name == "LeaderboardTemplate" then
			child.Visible = false
		end
	end
end

local function ensureScroller(category)
	for _, child in ipairs(leaderboards:GetChildren()) do
		if child:IsA("ScrollingFrame") then
			child.Visible = child.Name == category
		end
	end
	local scroller = leaderboards:FindFirstChild(category)
	if not scroller then
		scroller = leaderboards:FindFirstChild("Value") and leaderboards.Value:Clone() or Instance.new("ScrollingFrame")
		scroller.Name = category
		scroller.Parent = leaderboards
	end
	scroller.Visible = true
	scroller.Active = true
	scroller.ScrollingEnabled = true
	scroller.ScrollingDirection = Enum.ScrollingDirection.Y
	scroller.ScrollBarThickness = 6
	scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroller.CanvasSize = UDim2.fromOffset(0, 0)
	if not scroller:FindFirstChildOfClass("UIListLayout") then
		local list = Instance.new("UIListLayout")
		list.SortOrder = Enum.SortOrder.LayoutOrder
		list.Padding = UDim.new(0, 3)
		list.Parent = scroller
	end
	return scroller
end

local function setText(parent, name, text)
	local obj = parent:FindFirstChild(name, true)
	if obj and obj:IsA("TextLabel") then
		obj.Text = text
	end
end

local function setImage(parent, name, image)
	local obj = parent:FindFirstChild(name, true)
	if obj and obj:IsA("ImageLabel") then
		obj.Image = image
	end
end

local function makeEmptyRow(scroller, text)
	local row = getTemplate():Clone()
	row.Name = "RowEmpty"
	row.LayoutOrder = 1
	row.Visible = true
	row.Parent = scroller
	setText(row, "Rank", "-")
	setText(row, "PlayerName", text)
	setText(row, "Stats", "0")
	setImage(row, "PlayerIcon", "")
end

local function render(category, payload)
	local scroller = ensureScroller(category)
	clearBoard(scroller)
	local rows = payload and payload.Rows or {}
	if totalTitle then
		totalTitle.Text = "WINS"
	end
	local playerTitle = title:FindFirstChild("PlayerTitle")
	if playerTitle then
		playerTitle.Text = (payload and payload.Title) or (string.upper(category) .. " WINS")
	end
	if #rows == 0 then
		makeEmptyRow(scroller, "NO DATA YET")
		return
	end
	for index, rowData in ipairs(rows) do
		local row = getTemplate():Clone()
		row.Name = "Row" .. index
		row.LayoutOrder = index
		row.Visible = true
		row.Parent = scroller
		setText(row, "Rank", "#" .. tostring(rowData.Rank or index))
		setText(row, "PlayerName", rowData.Name or "Player")
		setText(row, "Stats", rowData.WinsText or formatCount(rowData.Wins))
		if rowData.UserId then
			setImage(row, "PlayerIcon", "rbxthumb://type=AvatarHeadShot&id=" .. tostring(rowData.UserId) .. "&w=420&h=420")
		end
	end
end

local function styleButton(buttonFrame, selected)
	local main = buttonFrame:FindFirstChild("Main")
	if not main then return end
	local scale = main:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
	scale.Scale = selected and 1.05 or 1
	scale.Parent = main
	local stroke = main:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Thickness = selected and 4 or 2
	end
end

local function loadCategory(category)
	activeCategory = category
	for _, name in ipairs(categories) do
		local buttonFrame = buttonsFrame:FindFirstChild(name)
		if buttonFrame then styleButton(buttonFrame, name == category) end
	end
	local ok, payload = pcall(function()
		return getLiveBoardData:InvokeServer(category)
	end)
	if ok then
		render(category, payload)
	else
		render(category, {Title = string.upper(category) .. " WINS", Rows = {}})
	end
end

local function wireButton(category)
	local buttonFrame = buttonsFrame:FindFirstChild(category)
	local main = buttonFrame and buttonFrame:FindFirstChild("Main")
	local button = main and main:FindFirstChild("Button")
	if not (buttonFrame and main and button and button:IsA("GuiButton")) then return end
	button.Active = true
	button.Selectable = true
	button.AutoButtonColor = false
	local scale = main:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
	scale.Parent = main
	button.MouseEnter:Connect(function()
		TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = category == activeCategory and 1.07 or 1.04}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(scale, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = category == activeCategory and 1.05 or 1}):Play()
	end)
	button.Activated:Connect(function()
		TweenService:Create(scale, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.94}):Play()
		task.delay(0.06, function()
			loadCategory(category)
		end)
	end)
end

for _, category in ipairs(categories) do
	wireButton(category)
end

loadCategory(activeCategory)
while task.wait(60) do
	loadCategory(activeCategory)
end
