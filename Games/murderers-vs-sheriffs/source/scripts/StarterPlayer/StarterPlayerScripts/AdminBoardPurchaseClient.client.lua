local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local Constants = require(ReplicatedStorage:WaitForChild("Constants"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CheckAdmin = Remotes:WaitForChild("Extras"):WaitForChild("CheckAdmin")
local ADMIN_GAMEPASS_ID = Constants.Gamepasses.AdminMenu or 1933372241

local NORMAL_BG = Color3.fromRGB(98, 230, 10)
local NORMAL_SHADOW = Color3.fromRGB(40, 150, 12)
local HOVER_BG = Color3.fromRGB(135, 255, 35)
local HOVER_SHADOW = Color3.fromRGB(56, 185, 18)
local DOWN_BG = Color3.fromRGB(73, 190, 5)
local DOWN_SHADOW = Color3.fromRGB(26, 104, 8)
local PURCHASED_BG = Color3.fromRGB(92, 92, 92)
local PURCHASED_SHADOW = Color3.fromRGB(45, 45, 45)

local hoverTweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickTweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function waitForPath(root, path, timeout)
	local current = root
	for _, name in ipairs(path) do
		current = current:WaitForChild(name, timeout)
		if not current then
			return nil
		end
	end
	return current
end

local display = waitForPath(workspace, {"Lobby", "Gamepasses", "Boards", "AdminBoard", "Display"}, 30)
if not display then
	warn("[AdminBoardPurchase] Admin board display was not found.")
	return
end

local prompt = display:FindFirstChild("AdminGamepassPrompt")
if prompt then
	prompt:Destroy()
end

local buyFrame = waitForPath(display, {"SurfaceGui", "Frame", "Buy"}, 15)
if not buyFrame then
	warn("[AdminBoardPurchase] Admin board buy UI was not found.")
	return
end

local button = buyFrame:WaitForChild("Button", 10)
local container = buyFrame:WaitForChild("Container", 10)
local price = container and container:WaitForChild("Price", 10)
local background = container and container:WaitForChild("Background", 10)
local shadow = container and container:WaitForChild("Shadow", 10)
local scale = button and (button:FindFirstChild("ButtonUIScale") or Instance.new("UIScale"))

if not button or not container or not price or not background or not shadow or not scale then
	warn("[AdminBoardPurchase] Admin board button pieces are missing.")
	return
end

scale.Name = "ButtonUIScale"
scale.Parent = button
button.AutoButtonColor = false

local hasAccess = false
local hovering = false
local pressing = false
local pendingPrompt = false

local function tweenVisual(scaleValue, bgColor, shadowColor, tweenInfo)
	TweenService:Create(scale, tweenInfo, {Scale = scaleValue}):Play()
	TweenService:Create(background, tweenInfo, {BackgroundColor3 = bgColor}):Play()
	TweenService:Create(shadow, tweenInfo, {BackgroundColor3 = shadowColor}):Play()
end

local function setButtonInteractable(enabled)
	button.Active = enabled
	button.Selectable = enabled
	pcall(function()
		button.Interactable = enabled
	end)
end

local function checkAccess()
	local ok, result = pcall(function()
		return CheckAdmin:InvokeServer()
	end)
	return ok and result == true
end

local function renderState()
	if hasAccess then
		pendingPrompt = false
		hovering = false
		pressing = false
		price.Text = "Purchased"
		setButtonInteractable(false)
		tweenVisual(1, PURCHASED_BG, PURCHASED_SHADOW, hoverTweenInfo)
	else
		price.Text = "Purchase"
		setButtonInteractable(true)
		if pressing then
			tweenVisual(0.94, DOWN_BG, DOWN_SHADOW, clickTweenInfo)
		elseif hovering then
			tweenVisual(1.06, HOVER_BG, HOVER_SHADOW, hoverTweenInfo)
		else
			tweenVisual(1, NORMAL_BG, NORMAL_SHADOW, hoverTweenInfo)
		end
	end
end

local function refresh()
	hasAccess = checkAccess()
	renderState()
end

button.MouseEnter:Connect(function()
	if hasAccess then
		return
	end
	hovering = true
	renderState()
end)

button.MouseLeave:Connect(function()
	hovering = false
	pressing = false
	renderState()
end)

button.MouseButton1Down:Connect(function()
	if hasAccess then
		return
	end
	pressing = true
	renderState()
end)

button.MouseButton1Up:Connect(function()
	pressing = false
	renderState()
end)

button.Activated:Connect(function()
	if hasAccess or pendingPrompt then
		return
	end
	pendingPrompt = true
	MarketplaceService:PromptGamePassPurchase(player, ADMIN_GAMEPASS_ID)
	task.delay(2, function()
		pendingPrompt = false
	end)
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(finishedPlayer, gamepassId, wasPurchased)
	if finishedPlayer ~= player or gamepassId ~= ADMIN_GAMEPASS_ID then
		return
	end
	pendingPrompt = false
	if wasPurchased then
		task.delay(1, refresh)
	else
		renderState()
	end
end)

refresh()
