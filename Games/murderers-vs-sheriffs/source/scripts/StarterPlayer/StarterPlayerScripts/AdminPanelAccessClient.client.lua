local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))
local WindowService = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WindowService"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CheckAdmin = Remotes:WaitForChild("Extras"):WaitForChild("CheckAdmin")
local ADMIN_GAMEPASS_ID = Constants.Gamepasses.AdminMenu or 1933372241
local ADMIN_OWNER_IDS = {
	[24029404] = true,
}
local ADMIN_ICON = "rbxassetid://18386899616"

local playerGui = player:WaitForChild("PlayerGui")
local oldFloatingButton = playerGui:FindFirstChild("AdminPanelAccess")
if oldFloatingButton then
	oldFloatingButton:Destroy()
end

local hasAccess = false

local function checkAccess()
	if ADMIN_OWNER_IDS[player.UserId] then
		return true
	end

	local ok, result = pcall(function()
		return CheckAdmin:InvokeServer()
	end)
	if ok and result == true then
		return true
	end

	local ownsPass = false
	local ownsOk = pcall(function()
		ownsPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, ADMIN_GAMEPASS_ID)
	end)
	return ownsOk and ownsPass == true
end

local function openAdminPanel()
	pcall(function()
		WindowService:ToggleFrame("AdminSettings")
	end)

	local crossPlatform = playerGui:FindFirstChild("CrossPlatform")
	local ownerPanel = crossPlatform and crossPlatform:FindFirstChild("OwnerPanel")
	if ownerPanel and ownerPanel:IsA("GuiObject") then
		ownerPanel.Visible = true
		local container = ownerPanel:FindFirstChild("Container")
		if container and container:IsA("GuiObject") then
			container.Visible = true
		end
	else
		warn("[AdminPanelAccess] Admin panel frame was not found.")
	end
end

local function handleAdminButtonClick()
	hasAccess = checkAccess()
	if hasAccess then
		openAdminPanel()
	else
		MarketplaceService:PromptGamePassPurchase(player, ADMIN_GAMEPASS_ID)
	end
end

local function findFirstGuiButton(root)
	if not root then
		return nil
	end
	if root:IsA("GuiButton") then
		return root
	end
	for _, descendant in ipairs(root:GetDescendants()) do
		if descendant:IsA("GuiButton") then
			return descendant
		end
	end
	return nil
end

local function findDescendantByName(root, name)
	if not root then
		return nil
	end
	for _, descendant in ipairs(root:GetDescendants()) do
		if descendant.Name == name then
			return descendant
		end
	end
	return nil
end

local function hideFloatingEventBars()
	for _, descendant in ipairs(playerGui:GetDescendants()) do
		if descendant.Name == "EventBar" and descendant:IsA("GuiObject") then
			descendant.Visible = false
		end
	end
end

local function ensureMobileEventButton(topbarContainer, admin, settingsButton)
	local event = topbarContainer:FindFirstChild("Event")
	if not event then
		local template = ReplicatedStorage:WaitForChild("GUI"):WaitForChild("MainMobile"):WaitForChild("Lobby"):WaitForChild("EventBar"):WaitForChild("Main"):WaitForChild("Event")
		event = template:Clone()
		event.Name = "Event"
		event.Parent = topbarContainer
	end

	event.LayoutOrder = admin.LayoutOrder + 1
	event.Visible = UserInputService.TouchEnabled
	event.AnchorPoint = Vector2.new(0, 0)
	event.Position = UDim2.new(0, 0, 0, 0)
	local topbarButtonHeight = settingsButton.AbsoluteSize.Y > 0 and settingsButton.AbsoluteSize.Y or 44
	event.Size = UDim2.new(0, 78, 0, topbarButtonHeight)
	event.BackgroundTransparency = 1
	event.ScaleType = Enum.ScaleType.Fit
	event.ZIndex = math.max(admin.ZIndex, settingsButton.ZIndex)

	local aspect = event:FindFirstChildOfClass("UIAspectRatioConstraint")
	if aspect then
		aspect:Destroy()
	end

	local label = event:FindFirstChild("TextLabel")
	if label and label:IsA("TextLabel") then
		label.Visible = false
	end

	local background = event:FindFirstChild("Background")
	if background and background:IsA("GuiObject") then
		background.AnchorPoint = Vector2.new(0.5, 1)
		background.Position = UDim2.fromScale(0.5, 1.08)
		background.Size = UDim2.new(1, 0, 0, 18)
		background.ZIndex = event.ZIndex + 2

		local backgroundLabel = background:FindFirstChild("TextLabel")
		if backgroundLabel and backgroundLabel:IsA("TextLabel") then
			backgroundLabel.Text = "EVENT"
			backgroundLabel.Visible = true
			backgroundLabel.Size = UDim2.fromScale(1, 0.8)
			backgroundLabel.Position = UDim2.fromScale(0, 0.5)
			backgroundLabel.AnchorPoint = Vector2.new(0, 0.5)
			backgroundLabel.TextSize = 15
			backgroundLabel.ZIndex = background.ZIndex + 1
		end
	end

	local oldScript = event:FindFirstChild("EventOpen")
	if oldScript and oldScript:IsA("LocalScript") then
		oldScript.Disabled = true
	end

	if event:GetAttribute("AdminAlignedEventConnected") ~= true then
		event:SetAttribute("AdminAlignedEventConnected", true)
		event.Activated:Connect(function()
			WindowService:ToggleFrame("CurrentEvent")
		end)
	end

	hideFloatingEventBars()
	return event
end

local function ensureMobileAdminButton()
	local gameTopbar = playerGui:FindFirstChild("GameTopbar") or playerGui:WaitForChild("GameTopbar", 30)
	local topbarContainer = gameTopbar and (gameTopbar:FindFirstChild("Container") or gameTopbar:WaitForChild("Container", 15))
	if not topbarContainer then
		warn("[AdminPanelAccess] Mobile topbar did not load in time.")
		return nil
	end

	local settingsButton = topbarContainer:FindFirstChild("Settings")
	if not settingsButton then
		warn("[AdminPanelAccess] Mobile settings button was not found.")
		return nil
	end

	local admin = topbarContainer:FindFirstChild("Admin")
	if not admin then
		admin = settingsButton:Clone()
		admin.Name = "Admin"
		admin.Parent = topbarContainer
	end

	admin.LayoutOrder = (settingsButton.LayoutOrder or 10) + 1
	admin.Size = settingsButton.Size
	admin.Visible = UserInputService.TouchEnabled
	admin.BackgroundTransparency = settingsButton.BackgroundTransparency

	local innerContainer = admin:FindFirstChild("Container")
	local iconFrame = innerContainer and innerContainer:FindFirstChild("Icon")
	if iconFrame then
		for _, icon in ipairs(iconFrame:GetDescendants()) do
			if icon:IsA("ImageLabel") or icon:IsA("ImageButton") then
				icon.Image = ADMIN_ICON
				icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
				icon.AnchorPoint = Vector2.new(0.5, 0.5)
				icon.Position = UDim2.fromScale(0.5, 0.5)
				icon.Size = UDim2.fromScale(0.62, 0.62)
				icon.Visible = true
			end
		end
	end

	local background = innerContainer and innerContainer:FindFirstChild("Background")
	local mobileStroke = background and (background:FindFirstChild("AdminRainbowStroke") or background:FindFirstChildOfClass("UIStroke"))
	if background and not mobileStroke then
		mobileStroke = Instance.new("UIStroke")
		mobileStroke.Parent = background
	end
	if mobileStroke then
		mobileStroke.Name = "AdminRainbowStroke"
		mobileStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		mobileStroke.Thickness = 2
		mobileStroke.Transparency = 0
		mobileStroke.Enabled = true
	end

	local mobileButton = findFirstGuiButton(admin)
	if mobileButton and mobileButton:GetAttribute("AdminPanelConnected") ~= true then
		mobileButton:SetAttribute("AdminPanelConnected", true)
		mobileButton.Activated:Connect(handleAdminButtonClick)
	end

	ensureMobileEventButton(topbarContainer, admin, settingsButton)

	return admin, mobileStroke
end

local function ensureAdminButton(settingsFrame)
	local admin = settingsFrame:FindFirstChild("Admin")
	if not admin then
		local mode = settingsFrame:FindFirstChild("Mode")
		if not mode then
			return nil
		end
		admin = mode:Clone()
		admin.Name = "Admin"
		admin.Parent = settingsFrame
	end

	admin.LayoutOrder = 3
	admin.Visible = true
	admin.Size = UDim2.new(0, 45, 1, 0)
	admin.Position = UDim2.new(0, 0, 0, 0)
	admin.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	admin.BackgroundTransparency = 0.7
	admin.BorderSizePixel = 0

	local title = admin:FindFirstChild("Title")
	if title and title:IsA("TextLabel") then
		title.Text = "Admin"
		title.TextSize = 14
		title.TextStrokeTransparency = 0.45
		title.ZIndex = 3
	end

	local icon = admin:FindFirstChild("Icon")
	if icon and icon:IsA("ImageLabel") then
		icon.Image = ADMIN_ICON
		icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		icon.Size = UDim2.new(0.75, 0, 0.75, 0)
		icon.Position = UDim2.new(0.5, 0, 0.47, 0)
		icon.ZIndex = 2
	end

	local button = admin:FindFirstChild("Button")
	if button and button:IsA("ImageButton") then
		button.Image = ""
		button.BackgroundTransparency = 1
		button.ZIndex = 5
	end

	local corner = admin:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 3)
	corner.Parent = admin

	local stroke = admin:FindFirstChild("RainbowStroke") or admin:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
	stroke.Name = "RainbowStroke"
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Thickness = 2.5
	stroke.Transparency = 0
	stroke.Enabled = true
	stroke.Parent = admin

	local eventButton = settingsFrame:FindFirstChild("Event")
	if eventButton then
		eventButton.LayoutOrder = 4
		eventButton.Visible = true
		eventButton.Position = UDim2.new(0, 0, -1, -10)
	end

	return admin, button, stroke
end

local adminFrame
local stroke
local mobileAdminFrame
local mobileStroke
local setupQueued = false
local refreshQueued = false

local function connectAdminGuiButton(guiButton)
	if not guiButton or not guiButton:IsA("GuiButton") then
		return
	end
	if guiButton:GetAttribute("AdminPanelConnected") == true then
		return
	end
	guiButton:SetAttribute("AdminPanelConnected", true)
	guiButton.Activated:Connect(handleAdminButtonClick)
end

local function applyAdminVisibility()
	if adminFrame and adminFrame.Parent then
		adminFrame.Visible = true
	end
	if mobileAdminFrame and mobileAdminFrame.Parent then
		mobileAdminFrame.Visible = UserInputService.TouchEnabled
	end
end

local function refreshAccess()
	if refreshQueued then
		return
	end
	refreshQueued = true
	task.spawn(function()
		hasAccess = checkAccess()
		refreshQueued = false
		applyAdminVisibility()
	end)
end

local function setupAdminAccess()
	setupQueued = false

	local nextMobileFrame, nextMobileStroke = ensureMobileAdminButton()
	if nextMobileFrame then
		mobileAdminFrame = nextMobileFrame
		mobileStroke = nextMobileStroke
	end

	local mainGui = playerGui:FindFirstChild("MainGUI")
	local gameFrame = mainGui and mainGui:FindFirstChild("Game")
	local settingsFrame = gameFrame and gameFrame:FindFirstChild("Settings")
	if settingsFrame then
		local nextAdminFrame, button, nextStroke = ensureAdminButton(settingsFrame)
		if nextAdminFrame and button then
			adminFrame = nextAdminFrame
			stroke = nextStroke
			connectAdminGuiButton(button)
		end
	end

	applyAdminVisibility()
	refreshAccess()
end

local function queueSetup(delaySeconds)
	if setupQueued then
		return
	end
	setupQueued = true
	task.delay(delaySeconds or 0, setupAdminAccess)
end

playerGui.ChildAdded:Connect(function(child)
	if child.Name == "MainGUI" or child.Name == "GameTopbar" or child.Name == "CrossPlatform" then
		queueSetup(0.1)
	end
end)

playerGui.DescendantAdded:Connect(function(descendant)
	if descendant.Name == "Settings"
		or descendant.Name == "Admin"
		or descendant.Name == "EventBar"
		or descendant.Name == "GameTopbar"
		or descendant.Name == "MainGUI"
	then
		queueSetup(0.1)
	end
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(finishedPlayer, gamepassId, wasPurchased)
	if finishedPlayer == player and gamepassId == ADMIN_GAMEPASS_ID and wasPurchased then
		hasAccess = true
		applyAdminVisibility()
		openAdminPanel()
		task.delay(1, refreshAccess)
	end
end)

RunService.RenderStepped:Connect(function()
	local color = Color3.fromHSV((os.clock() * 0.18) % 1, 1, 1)
	local needsSetup = false

	if stroke and stroke.Parent then
		stroke.Color = color
	else
		stroke = nil
		needsSetup = true
	end

	if mobileStroke and mobileStroke.Parent then
		mobileStroke.Color = color
	elseif UserInputService.TouchEnabled then
		mobileStroke = nil
		needsSetup = true
	end

	if needsSetup then
		queueSetup(0.35)
	end
end)

queueSetup(0)
