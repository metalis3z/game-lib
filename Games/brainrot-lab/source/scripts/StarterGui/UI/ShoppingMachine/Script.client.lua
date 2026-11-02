local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- [ SAFE LOADING: with timeout + warn so failures are visible in F9 console instead of freezing silently ]
local function safeWait(parent, childName, timeout)
	local inst = parent:WaitForChild(childName, timeout or 15)
	if not inst then
		warn(string.format("[ShoppingMachine] TIMEOUT waiting for '%s' inside '%s' - the shop UI will NOT work until this exists.", childName, parent:GetFullName()))
	end
	return inst
end

local frame = script.Parent
frame.Visible = false

-- PurchaseMachine ProximityPrompt handling: connected FIRST, independent of everything below,
-- so the door opens/closes even if a data module is missing or slow to load.
-- IMPORTANT: With StreamingEnabled, the machine model may not be loaded when the script
-- starts, and can be streamed out/in as the player moves. We use a persistent watcher
-- that keeps trying to find and connect to the ProximityPrompt.
local machineMainPart
local currentPromptConnection = nil

local function tryConnectPrompt()
	local folder = Workspace:FindFirstChild("Maquinas/Interação")
	if not folder then return false end
	local assets = folder:FindFirstChild("Assets")
	if not assets then return false end
	local machine = assets:FindFirstChild("PurchaseMachine")
	if not machine then return false end
	machineMainPart = machine:FindFirstChild("Main")
	if not machineMainPart then return false end

	local prompt = machineMainPart:FindFirstChild("ShoppingOpenPrompt")
	if prompt and prompt:IsA("ProximityPrompt") then
		-- Disconnect any previous connection (handles stream out/in re-connection)
		if currentPromptConnection then
			currentPromptConnection:Disconnect()
			currentPromptConnection = nil
		end
		currentPromptConnection = prompt.Triggered:Connect(function()
			frame.Visible = not frame.Visible
		end)
		return true
	end
	return false
end

-- Try once immediately (works in Studio where everything is loaded)
if not tryConnectPrompt() then
	-- If not found, keep retrying every 2 seconds until the machine is streamed in
	task.spawn(function()
		while not tryConnectPrompt() do
			task.wait(2)
		end
		print("[ShoppingMachine] ProximityPrompt connected after retry")
	end)
end

-- Handle the machine being streamed out and back in (StreamingEnabled)
Workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("ProximityPrompt") and descendant.Name == "ShoppingOpenPrompt" then
		task.wait(0.1) -- small delay to ensure parent hierarchy is ready
		tryConnectPrompt()
	end
end)

local PlayerGui = player and player:WaitForChild("PlayerGui")
local SharedFolder = safeWait(ReplicatedStorage, "Shared")
local Brainrots = SharedFolder and safeWait(SharedFolder, "Brainrots")
Brainrots = Brainrots and require(Brainrots)
local RarityColorModule = SharedFolder and safeWait(SharedFolder, "RarityColor")
local RarityColor = RarityColorModule and require(RarityColorModule)
local ItemsFolder = safeWait(ReplicatedStorage, "Items")
local Brainrots_2 = ItemsFolder and safeWait(ItemsFolder, "Normal")
local BrainrotRemotes = safeWait(ReplicatedStorage, "BrainrotRemotes")
local SetAutoPurchase = BrainrotRemotes and safeWait(BrainrotRemotes, "SetAutoPurchase")
local GetAutoPurchaseData = BrainrotRemotes and safeWait(BrainrotRemotes, "GetAutoPurchaseData")
local AutoPurchaseNotification = BrainrotRemotes and safeWait(BrainrotRemotes, "AutoPurchaseNotification")

if not (Brainrots and RarityColor and Brainrots_2 and SetAutoPurchase and GetAutoPurchaseData and AutoPurchaseNotification) then
	warn("[ShoppingMachine] Missing dependencies above - aborting setup of shop logic, but the open/close prompt will still be connected so the frame isn't completely dead.")
	-- Guard: if any remote is nil, don't try to connect to its events below
	if not SetAutoPurchase then SetAutoPurchase = { OnClientEvent = nil } end
	if not AutoPurchaseNotification then AutoPurchaseNotification = { OnClientEvent = nil } end
	if not GetAutoPurchaseData then GetAutoPurchaseData = { InvokeServer = function() return nil end } end
end

local List = frame:WaitForChild("Frame"):WaitForChild("List")
local Template = List:WaitForChild("Template")
local Warning = frame:FindFirstChild("Warning")

local selections = {}
local cooldown = 0
local cameras = {}
Template.Visible = false

local function getAnimator(model)
	local Brainrot = model:FindFirstChild("Brainrot", true)
	if Brainrot then
		local ac = Brainrot:FindFirstChildOfClass("AnimationController")
		if ac then
			local anim = ac:FindFirstChildOfClass("Animator")
			if not anim then
				anim = Instance.new("Animator")
				anim.Parent = ac
			end
			return anim
		end
	end
	local ac2 = model:FindFirstChildOfClass("AnimationController", true)
	if ac2 then
		local anim = ac2:FindFirstChildOfClass("Animator")
		if not anim then
			anim = Instance.new("Animator")
			anim.Parent = ac2
		end
		return anim
	else
		local hum = model:FindFirstChildWhichIsA("Humanoid")
		if not hum then return nil end
		local anim = hum:FindFirstChildOfClass("Animator")
		if not anim then
			anim = Instance.new("Animator")
			anim.Parent = hum
		end
		return anim
	end
end

local function createViewportFrame(parent, brainrotType)
	local brainrotFolder = Brainrots_2:FindFirstChild(brainrotType)
	if not brainrotFolder then return nil end
	local Model = brainrotFolder:FindFirstChild("Model")
	if not Model then return nil end

	local vf = Instance.new("ViewportFrame")
	vf.Name = "ViewportFrame"
	vf.Size = UDim2.new(1, 0, 1, 0)
	vf.BackgroundTransparency = 1
	vf.Parent = parent

	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = vf

	local clone = Model:Clone()
	clone.Name = brainrotType
	clone.Parent = worldModel

	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
			d.CanCollide = false
		end
	end

	local cam = Instance.new("Camera")
	cam.FieldOfView = 45
	vf.CurrentCamera = cam
	cam.Parent = vf

	local cf, size = clone:GetBoundingBox()
	clone:PivotTo(CFrame.new(cf.Position) * CFrame.Angles(0, 2.530727415391778, 0))
	local cf2 = clone:GetBoundingBox()
	cam.CFrame = CFrame.new(cf2.Position + Vector3.new(0, size.Y * 0.1, size.Magnitude * 1.2), cf2.Position)
	cameras[brainrotType] = cam

	local Animations = brainrotFolder:FindFirstChild("Animations")
	if Animations then
		local Idle = Animations:FindFirstChild("Idle")
		if Idle then
			local animator = getAnimator(clone)
			if animator then
				local ok, track = pcall(function()
					return animator:LoadAnimation(Idle)
				end)
				if ok and track then
					track.Looped = true
					track:Play()
				end
			end
		end
	end

	return clone
end

local function updateCooldownDisplay(card)
	local Waiting = card:FindFirstChild("Waiting")
	if not Waiting then return end
	local Title = Waiting:FindFirstChild("Title")
	if not Title then return end
	if cooldown > 0 then
		Waiting.Visible = true
		Title.Text = string.format("%d:%02d", math.floor(cooldown / 60), math.floor(cooldown % 60))
	else
		Waiting.Visible = false
	end
end

local function isSelected(brainrotType)
	for _, v in ipairs(selections) do
		if v == brainrotType then
			return true
		end
	end
	return false
end

local function createBrainrotCard(brainrotType)
	local data = Brainrots[brainrotType]
	if not data then return nil end

	local card = Template:Clone()
	card.Name = brainrotType
	card.Visible = true

	local rarity = data.Rarity or "Common"
	card.LayoutOrder = RarityColor.RARITY_ORDER[rarity] or 1

	local btn = card:FindFirstChild("Frame")
	if btn then
		local brainrotName = btn:FindFirstChild("BrainrotName")
		if brainrotName then
			brainrotName.Text = data.Name or brainrotType
		end

		local brainrotRarity = btn:FindFirstChild("BrainrotRarity")
		if brainrotRarity then
			brainrotRarity.Text = rarity
			brainrotRarity.TextColor3 = RarityColor.GetRarityColor(rarity)
			RarityColor.ApplyStroke(brainrotRarity, rarity)
		end

		local existingVF = btn:FindFirstChild("ViewportFrame")
		if existingVF then
			existingVF:Destroy()
		end
		createViewportFrame(btn, brainrotType)

		local Equipped = btn:FindFirstChild("Equipped")
		btn.MouseButton1Click:Connect(function()
			if isSelected(brainrotType) then
				SetAutoPurchase:FireServer("remove", brainrotType)
				return
			end
			if #selections < 8 then
				SetAutoPurchase:FireServer("add", brainrotType)
			end
		end)

		if Equipped then
			Equipped.Visible = isSelected(brainrotType)
		end
	end

	return card
end

local function refreshUI()
	for _, v in ipairs(List:GetChildren()) do
		if v:IsA("Frame") and v ~= Template then
			v:Destroy()
		end
	end

	local byRarity = {}
	for _, v in ipairs(Brainrots_2:GetChildren()) do
		local data = Brainrots[v.Name]
		if data and data.Admin ~= "True" then
			local r = data.Rarity or "Common"
			if not byRarity[r] then
				byRarity[r] = {}
			end
			table.insert(byRarity[r], v.Name)
		end
	end

	for _, rarity in ipairs({"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}) do
		local list = byRarity[rarity]
		if list then
			for _, brainrotType in ipairs(list) do
				local card = createBrainrotCard(brainrotType)
				if card then
					card.Parent = List
				end
			end
		end
	end
end

-- Cooldown countdown loop
task.spawn(function()
	while true do
		task.wait(1)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
		for _, v in ipairs(List:GetChildren()) do
			if v:IsA("Frame") and v ~= Template then
				updateCooldownDisplay(v)
			end
		end
	end
end)

-- Handle server responses
if SetAutoPurchase and SetAutoPurchase.OnClientEvent then
SetAutoPurchase.OnClientEvent:Connect(function(action, brainrotType, success)
	if action == "addResult" and success then
		table.insert(selections, brainrotType)
	elseif action == "removeResult" and success then
		for i, v in ipairs(selections) do
			if v == brainrotType then
				table.remove(selections, i)
				break
			end
		end
	else
		return
	end
	refreshUI()
end)
end

-- Handle auto-purchase notification (visual feedback only, no cooldown)
if AutoPurchaseNotification and AutoPurchaseNotification.OnClientEvent then
AutoPurchaseNotification.OnClientEvent:Connect(function(itemName)
	refreshUI()
end)
end

-- Initialize: load selections and cooldown from server
task.spawn(function()
	local ok, data = pcall(function()
		return GetAutoPurchaseData:InvokeServer()
	end)
	if ok and data then
		selections = data.selections or {}
		cooldown = 0
	end
	refreshUI()
end)

-- Close button
local topFrame = frame:FindFirstChild("Top")
if topFrame then
	local mainFrame = topFrame:FindFirstChild("Main")
	if mainFrame then
		local closeButton = mainFrame:FindFirstChild("Close")
		if closeButton and closeButton:IsA("TextButton") then
			closeButton.MouseButton1Click:Connect(function()
				frame.Visible = false
			end)
		end
	end
end

-- Close frame when player walks away from machine
task.spawn(function()
	while true do
		task.wait(0.5)
		if frame.Visible and machineMainPart and player.Character then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local dist = (hrp.Position - machineMainPart.Position).Magnitude
				if dist > 15 then
					frame.Visible = false
				end
			end
		end
	end
end)