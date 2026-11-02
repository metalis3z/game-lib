--credit to quartz games studio
--[[
	RainbowShovel (LocalScript dentro del ScreenGui StarterGui."Rainbow Shovel".RainbowShovel)
	------------------------------------------------------------------------------------------
	- El ScreenGui arranca oculto. Se ABRE cuando el jugador toca la zona
	  Workspace.ShovelRainbow."Shovel Rainbow".GuiEnabled (el pedestal). Se cierra
	  solo al alejarse.
	- Al abrir, los botones hacen un GIRO de entrada y tienen un degradado RAINBOW animado.
	- RobuxButton  -> abre el gamepass (1875843847). Su Frame.TextLabel muestra el PRECIO.
	- MoneyButton  -> compra con 50M sheckles (RemoteEvent RainbowShovelBuyMoney).
	                  OJO: esa compra NO persiste (se pierde al salir del server).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local GAMEPASS_ID = 1875843847
local MONEY_COST_TEXT = "50M"      -- texto del costo en sheckles
local CLOSE_DISTANCE = 30          -- studs desde el pedestal para cerrar

local player = Players.LocalPlayer
local screenGui = script.Parent
local robuxButton = screenGui:WaitForChild("RobuxButton")
local moneyButton = screenGui:WaitForChild("MoneyButton")
local buyMoney = ReplicatedStorage:WaitForChild("RainbowShovelBuyMoney")
local MessagePrompt = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("MessagePrompt"))

screenGui.Enabled = false

----------------------------------------------------------------------
-- Precio del gamepass en el TextLabel del RobuxButton
----------------------------------------------------------------------
task.spawn(function()
	local frame = robuxButton:WaitForChild("Frame")
	local label = frame:WaitForChild("TextLabel")
	local ok, info = pcall(function()
		return MarketplaceService:GetProductInfo(GAMEPASS_ID, Enum.InfoType.GamePass)
	end)
	if ok and info and info.PriceInRobux then
		label.Text = tostring(info.PriceInRobux)
	end
end)

-- Texto del costo en sheckles del MoneyButton
task.spawn(function()
	local frame = moneyButton:FindFirstChild("Frame")
	local label = frame and frame:FindFirstChild("TextLabel")
	if label then
		label.Text = MONEY_COST_TEXT
	end
end)

----------------------------------------------------------------------
-- Rainbow: degradado animado sobre los botones
----------------------------------------------------------------------
local RAINBOW = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 150, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
	ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 150, 255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(150, 0, 255)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
})

local function ensureRainbowGradient(button: GuiObject): UIGradient
	local grad = button:FindFirstChild("RainbowGradient")
	if not grad then
		grad = Instance.new("UIGradient")
		grad.Name = "RainbowGradient"
		grad.Color = RAINBOW
		grad.Parent = button
	end
	return grad
end

local gradients = { ensureRainbowGradient(robuxButton), ensureRainbowGradient(moneyButton) }

RunService.RenderStepped:Connect(function()
	if not screenGui.Enabled then
		return
	end
	local offset = (os.clock() * 0.4) % 1
	for _, g in gradients do
		g.Offset = Vector2.new(offset, 0)
	end
end)

----------------------------------------------------------------------
-- Giro de entrada al abrir
----------------------------------------------------------------------
local function spinIn()
	for _, b in { robuxButton, moneyButton } do
		b.Rotation = -360
		TweenService:Create(
			b,
			TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{ Rotation = 0 }
		):Play()
	end
end

----------------------------------------------------------------------
-- Botones de compra
----------------------------------------------------------------------
robuxButton.Activated:Connect(function()
	MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
end)

moneyButton.Activated:Connect(function()
	buyMoney:FireServer()
end)

buyMoney.OnClientEvent:Connect(function(kind)
	if kind == "granted" then
		screenGui.Enabled = false -- compra OK: cerrar
	elseif kind == "no-sheckles" then
		MessagePrompt.Prompt({
			titleOverride = "Rainbow Shovel",
			message = "No tienes suficientes <b>sheckles</b> (cuesta " .. MONEY_COST_TEXT .. ").",
			duration = 2,
			hideClose = true,
		})
	end
end)

----------------------------------------------------------------------
-- Abrir/cerrar según la zona GuiEnabled del pedestal
----------------------------------------------------------------------
local function getGuiPart(): BasePart?
	local sr = workspace:FindFirstChild("ShovelRainbow")
	local model = sr and sr:FindFirstChild("Shovel Rainbow")
	local part = model and model:FindFirstChild("GuiEnabled")
	if part and part:IsA("BasePart") then
		return part
	end
	return nil
end

local opened = false
local function open()
	if opened then
		return
	end
	opened = true
	screenGui.Enabled = true
	spinIn()
end
local function close()
	opened = false
	screenGui.Enabled = false
end

task.spawn(function()
	local part = getGuiPart()
	while not part do
		task.wait(1)
		part = getGuiPart()
	end

	part.Touched:Connect(function(hit)
		local character = player.Character
		if character and hit:IsDescendantOf(character) then
			open()
		end
	end)

	-- cerrar al alejarse del pedestal
	RunService.Heartbeat:Connect(function()
		if not opened then
			return
		end
		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end
		if (hrp.Position - part.Position).Magnitude > CLOSE_DISTANCE then
			close()
		end
	end)
end)
