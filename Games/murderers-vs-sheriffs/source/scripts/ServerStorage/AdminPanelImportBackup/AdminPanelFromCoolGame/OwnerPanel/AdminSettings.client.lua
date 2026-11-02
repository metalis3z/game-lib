local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Sync = require(ReplicatedStorage.Database.Sync)

local ANNOUNCEMENT_OWNERS = {
	["promisednothing"] = true,
}
local LocalPlayer = Players.LocalPlayer
local function canUseAnnouncement()
	return ANNOUNCEMENT_OWNERS[LocalPlayer.Name] == true or ANNOUNCEMENT_OWNERS[tostring(LocalPlayer.UserId)] == true
end

local Parent = script.Parent
local Container = Parent:WaitForChild("Container")
local Header = Container:WaitForChild("Header")
local Body = Container:WaitForChild("Body")
Body.CanvasPosition = Vector2.new(0, 0)
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminRemotes = Remotes:WaitForChild("AdminSettings")

local PlayerData = Body:WaitForChild("PlayerDataSection")
local RoundTools = Body:WaitForChild("RoundSection")
local MapSection = Body:WaitForChild("MapSection")
local Broadcast = Body:WaitForChild("AnnouncementSection")

local function startRainbowStroke(guiObject)
	local stroke = guiObject:FindFirstChild("RainbowStroke")
	if not stroke then
		stroke = Instance.new("UIStroke")
		stroke.Name = "RainbowStroke"
		stroke.Parent = guiObject
	end
	stroke.Thickness = 3
	stroke.Transparency = 0
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Enabled = not UserInputService.TouchEnabled

	local gradient = stroke:FindFirstChild("RainbowGradient")
	if not gradient then
		gradient = Instance.new("UIGradient")
		gradient.Name = "RainbowGradient"
		gradient.Parent = stroke
	end
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 65, 65)),
		ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 190, 60)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(80, 230, 90)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(70, 210, 255)),
		ColorSequenceKeypoint.new(0.67, Color3.fromRGB(95, 115, 255)),
		ColorSequenceKeypoint.new(0.83, Color3.fromRGB(210, 80, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 65, 65)),
	})

	if stroke.Enabled then
		RunService.RenderStepped:Connect(function()
			gradient.Rotation = (os.clock() * 22) % 360
		end)
	end
end
startRainbowStroke(Container)
local panelRainbowStroke = Container:FindFirstChild("RainbowStroke")
local panelRainbowStrokeGradient = panelRainbowStroke and panelRainbowStroke:FindFirstChild("RainbowGradient")
if panelRainbowStrokeGradient then
	panelRainbowStrokeGradient.Enabled = false
end
if panelRainbowStroke and panelRainbowStroke.Enabled then
	RunService.RenderStepped:Connect(function()
		panelRainbowStroke.Color = Color3.fromHSV((os.clock() * 0.08) % 1, 0.95, 1)
	end)
end



local function setStatus(label, message)
	label.Text = tostring(message or "")
	if label.Text ~= "" then
		task.delay(3, function()
			if label then
				label.Text = ""
			end
		end)
	end
end

local function getPlayer(name)
	name = tostring(name or "")
	if name == "" then
		return nil
	end
	local exact = Players:FindFirstChild(name)
	if exact then
		return exact
	end
	name = string.lower(name)
	for _, player in ipairs(Players:GetPlayers()) do
		if string.sub(string.lower(player.Name), 1, #name) == name then
			return player
		end
	end
	return nil
end

local function resultMessage(result, fallback)
	if type(result) == "table" and result.message then
		return result.message
	end
	return fallback or "Done"
end

local function connectButton(button, callback)
	button.Activated:Connect(function()
		if button:GetAttribute("Locked") == true then
			return
		end
		button.Active = false
		local ok, result = pcall(callback)
		if not ok then
			warn("Admin panel command failed:", result)
		end
		task.delay(0.15, function()
			if button then
				button.Active = button:GetAttribute("Locked") ~= true
			end
		end)
	end)
end

local dataStatus = PlayerData:WaitForChild("StatusLabel")
local dataInputRow = PlayerData:WaitForChild("InputRow")
local dataPlayer = dataInputRow:WaitForChild("PlayerNameBox")
local dataAmount = dataInputRow:WaitForChild("AmountBox")
local dataItem = PlayerData:WaitForChild("ItemNameBox")
local dataButtons = PlayerData:WaitForChild("Buttons")

local function giveCurrency(currency)
	local target = getPlayer(dataPlayer.Text)
	if not target then
		return setStatus(dataStatus, "Player not found")
	end
	local amount = tonumber(dataAmount.Text) or 1
	local result = AdminRemotes.GiveCurrency:InvokeServer(target, amount, currency)
	setStatus(dataStatus, resultMessage(result, "Gave " .. currency))
end

connectButton(dataButtons.GiveCoinsButton, function()
	giveCurrency("Coins")
end)
connectButton(dataButtons.GiveGemsButton, function()
	giveCurrency("Gems")
end)
connectButton(dataButtons.GiveItemButton, function()
	local target = getPlayer(dataPlayer.Text)
	if not target then
		return setStatus(dataStatus, "Player not found")
	end
	local itemName = dataItem.Text ~= "" and dataItem.Text or "Whiteout"
	local amount = tonumber(dataAmount.Text) or 1
	local result = AdminRemotes.GiveItem:InvokeServer(target, itemName, amount)
	setStatus(dataStatus, resultMessage(result, "Gave item"))
end)

local roundStatus = RoundTools:WaitForChild("StatusLabel")
local roundPlayer = RoundTools:WaitForChild("RoundPlayerBox")
local buttons1 = RoundTools:WaitForChild("Buttons1")
local buttons2 = RoundTools:WaitForChild("Buttons2")

local function giveWeapon(weapon)
	local target = getPlayer(roundPlayer.Text)
	if not target then
		return setStatus(roundStatus, "Player not found")
	end
	local result = AdminRemotes.GiveWeapon:InvokeServer(target, weapon)
	setStatus(roundStatus, resultMessage(result, "Gave " .. weapon))
end

local function becomeRole(role)
	local target = getPlayer(roundPlayer.Text)
	if not target then
		return setStatus(roundStatus, "Player not found")
	end
	local result = AdminRemotes.BecomeARole:InvokeServer(target, role)
	setStatus(roundStatus, resultMessage(result, "Role changed"))
end

connectButton(buttons1.GiveGunButton, function()
	giveWeapon("Gun")
end)
connectButton(buttons1.GiveKnifeButton, function()
	giveWeapon("Knife")
end)
connectButton(buttons2.MurdererButton, function()
	becomeRole("Murderer")
end)
connectButton(buttons2.SheriffButton, function()
	becomeRole("Sheriff")
end)
connectButton(RoundTools.EndRoundButton, function()
	local result = AdminRemotes.GiveWeapon:InvokeServer()
	setStatus(roundStatus, resultMessage(result, "Round ended"))
end)

local mapList = MapSection:WaitForChild("MapList")
local currentMap = MapSection:WaitForChild("CurrentMapLabel")
local mapGrid = mapList:WaitForChild("UIGridLayout")
local selectedMapButton

local function styleMapButton(button)
	button.BackgroundColor3 = Color3.fromRGB(53, 60, 76)
	button.TextColor3 = Color3.fromRGB(245, 247, 252)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 13
	button.TextWrapped = true
	button.AutoButtonColor = true
	button.TextStrokeTransparency = 1
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button
end

for mapId, mapData in pairs(Sync.Maps) do
	local button = Instance.new("TextButton")
	button.Name = "Map_" .. tostring(mapId)
	button.Text = tostring(mapData.Name or mapData.MapName or mapId)
	button.Size = UDim2.new(0, 120, 0, 44)
	button.Parent = mapList
	styleMapButton(button)
	connectButton(button, function()
		local result = AdminRemotes.SetMap:InvokeServer(mapId)
		if type(result) == "table" and result.exp then
			return setStatus(currentMap, result.message or "Could not set map")
		end
		if selectedMapButton then
			selectedMapButton.BackgroundColor3 = Color3.fromRGB(53, 60, 76)
		end
		selectedMapButton = button
		button.BackgroundColor3 = Color3.fromRGB(43, 190, 129)
		currentMap.Text = "Current map: " .. tostring(type(result) == "table" and result.message or button.Text)
	end)
end

Remotes.Gameplay.LoadingMap.OnClientEvent:Connect(function()
	if selectedMapButton then
		selectedMapButton.BackgroundColor3 = Color3.fromRGB(53, 60, 76)
		selectedMapButton = nil
	end
	currentMap.Text = "Current map: ???"
end)

local messageBox = Broadcast:WaitForChild("MessageBox")
local sendAnnouncement = Broadcast:WaitForChild("SendAnnouncementButton")
local broadcastStatus = Broadcast:WaitForChild("StatusLabel")
local announcementOverlay = Container:WaitForChild("AnnouncementLockOverlay")
local hasAnnouncementAccess = canUseAnnouncement()

local function syncAnnouncementOverlay()
	announcementOverlay.Visible = not hasAnnouncementAccess
	if hasAnnouncementAccess then
		messageBox.TextEditable = true
		messageBox.Active = true
		sendAnnouncement:SetAttribute("Locked", false)
		sendAnnouncement.Active = true
		sendAnnouncement.AutoButtonColor = true
		return
	end
	messageBox.Text = ""
	messageBox.TextEditable = false
	messageBox.Active = false
	sendAnnouncement:SetAttribute("Locked", true)
	sendAnnouncement.Active = false
	sendAnnouncement.AutoButtonColor = false
	local relative = Broadcast.AbsolutePosition - Container.AbsolutePosition
	announcementOverlay.Position = UDim2.fromOffset(relative.X, relative.Y)
	announcementOverlay.Size = UDim2.fromOffset(Broadcast.AbsoluteSize.X, Broadcast.AbsoluteSize.Y)
end

connectButton(sendAnnouncement, function()
	if not hasAnnouncementAccess then
		return setStatus(broadcastStatus, "Owner only access")
	end
	local message = messageBox.Text
	if message == "" then
		return setStatus(broadcastStatus, "Type a message first")
	end
	ReplicatedStorage:WaitForChild("SendAnnouncement"):FireServer(message)
	messageBox.Text = ""
	setStatus(broadcastStatus, "Announcement sent")
end)

Header.CloseButton.Activated:Connect(function()
	Parent.Visible = false
end)

local function setRowStacked(rowFrame, stacked)
	local layout = rowFrame:FindFirstChildOfClass("UIListLayout")
	if not layout then return end
	layout.FillDirection = stacked and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal
	local children = {}
	for _, child in ipairs(rowFrame:GetChildren()) do
		if child:IsA("GuiObject") then
			table.insert(children, child)
		end
	end
	local count = #children
	rowFrame.Size = UDim2.new(1, 0, 0, stacked and (count * 46 + math.max(0, count - 1) * 8) or 46)
	for _, child in ipairs(children) do
		child.Size = stacked and UDim2.new(1, 0, 0, 46) or UDim2.new(1 / count, -6, 0, 46)
	end
end

local function updateResponsive()
	local width = Container.AbsoluteSize.X
	local compact = width < 500
	setRowStacked(dataInputRow, compact)
	setRowStacked(dataButtons, compact)
	setRowStacked(buttons1, compact)
	setRowStacked(buttons2, compact)
	mapGrid.CellSize = compact and UDim2.new(1, -4, 0, 44) or UDim2.new(0.5, -6, 0, 44)
	Header.Title.TextSize = compact and 19 or 22
	Header.Subtitle.Visible = width >= 380
	syncAnnouncementOverlay()
end

Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateResponsive)
Body:GetPropertyChangedSignal("CanvasPosition"):Connect(syncAnnouncementOverlay)
Broadcast:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncAnnouncementOverlay)
Broadcast:GetPropertyChangedSignal("AbsolutePosition"):Connect(syncAnnouncementOverlay)
Parent:GetPropertyChangedSignal("Visible"):Connect(function()
	if Parent.Visible then
		Body.CanvasPosition = Vector2.new(0, 0)
		task.defer(updateResponsive)
		task.defer(syncAnnouncementOverlay)
	end
end)

task.defer(updateResponsive)
task.defer(syncAnnouncementOverlay)

require(ReplicatedStorage.Modules.WindowService):RegisterFrame(Parent, "AdminSettings")
