local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)
local NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)

local BaseUpgradeController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local BaseUpgradeRemotes
local RequestUpgradeFunc
local RequestDataFunc
local UpdateEvent
local BuiltEvent

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local POP_DURATION = 0.35
local FLOOR_POP_DURATION = 0.40
local POP_START_SCALE = 0.05
-- Must match `UPGRADE_COOLDOWN_SECONDS` in BaseUpgradeService. Both throttle
-- the same operation — client guard is for snappy UX (no wasted server round
-- trip), server guard is authoritative.
local CLIENT_UPGRADE_COOLDOWN = 1.0
local lastUpgradeClickAt = 0

-- Per-model animation registry. Each entry tracks the active tween, heartbeat
-- connection, and proxy so a re-trigger on the same model cleanly cancels the
-- previous animation before starting a new one. Models go in here only while
-- they have an in-flight popModel; entries are removed on completion / cancel.
local activePopAnims = setmetatable({}, { __mode = "k" })

local mountedGui = nil
local mountedSignPart = nil
local cachedPayload = nil
local upgradeInFlight = false
local templateRef = nil
local scaleWatchdogConnected = false

local function getTemplate()
	if templateRef and templateRef.Parent then return templateRef end
	local found = StarterGui:FindFirstChild("UpgradeBase")
	if found and found:IsA("SurfaceGui") then
		templateRef = found
	end
	return templateRef
end

local function getPlayerPlot()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		if plot:GetAttribute("OwnerUserId") == player.UserId then
			return plot
		end
	end
	return nil
end

local function ensureRemotes()
	BaseUpgradeRemotes = Remotes:WaitForChild("BaseUpgradeService", 30)
	if not BaseUpgradeRemotes then return false end
	RequestUpgradeFunc = BaseUpgradeRemotes:WaitForChild("RequestUpgrade", 30)
	RequestDataFunc = BaseUpgradeRemotes:WaitForChild("RequestData", 30)
	UpdateEvent = BaseUpgradeRemotes:WaitForChild("BaseUpgradeUpdate", 30)
	BuiltEvent = BaseUpgradeRemotes:WaitForChild("BaseUpgradeBuilt", 30)
	return RequestUpgradeFunc ~= nil and UpdateEvent ~= nil
end

local function setLabelText(label, text)
	if not label then return end
	if label:IsA("TextLabel") or label:IsA("TextButton") then
		label.Text = text
	end
	for _, desc in ipairs(label:GetDescendants()) do
		if desc:IsA("TextLabel") or desc:IsA("TextButton") then
			desc.Text = text
		end
	end
end

local function applyPayloadToGui(payload)
	if not mountedGui or not payload then return end

	local level = payload.Level or 0
	local maxLevel = payload.MaxLevel or 0
	local nextCost = payload.NextCost
	local isMax = payload.IsMaxLevel == true

	local slotsLabel = mountedGui:FindFirstChild("Slots")
	if slotsLabel then
		setLabelText(slotsLabel, string.format("Slots %d/%d", level, maxLevel))
	end

	local upgradeButton = mountedGui:FindFirstChild("Upgrade")
	local buttonTitle = upgradeButton and upgradeButton:FindFirstChild("Title")
	if buttonTitle then
		if isMax then
			setLabelText(buttonTitle, "MAX")
		elseif typeof(nextCost) == "number" then
			setLabelText(buttonTitle, "$" .. FormatUtils.Abbreviate(nextCost))
		else
			setLabelText(buttonTitle, "Upgrade")
		end
	end

	if upgradeButton and (upgradeButton:IsA("TextButton") or upgradeButton:IsA("ImageButton")) then
		upgradeButton.Active = not isMax
		upgradeButton.AutoButtonColor = not isMax
	end
end

local function playUpgradeSound()
	local cfg = GameConfig.BaseUpgrades
	local id = cfg and cfg.UpgradeSound or "rbxassetid://2976773885"
	local sound = Instance.new("Sound")
	sound.SoundId = id
	sound.Volume = 0.7
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(5, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

-- Hard-snap any model that has a stale ScaleTo state back to 1.0. Called when
-- a previous popModel run on the same model is cancelled (re-trigger) and on
-- every completion path, so a model can NEVER be left at >1.0 or <1.0.
local function forceRestoreScale(model)
	if not model or not model:IsA("Model") then return end
	pcall(function()
		model:ScaleTo(1.0)
	end)
end

local function cancelPopAnim(model)
	local state = activePopAnims[model]
	if not state then return end
	activePopAnims[model] = nil
	if state.conn then
		state.conn:Disconnect()
	end
	if state.tween then
		state.tween:Cancel()
		state.tween:Destroy()
	end
	if state.proxy then
		state.proxy:Destroy()
	end
end

local function popModel(model, duration)
	if not model or not model:IsA("Model") then return end

	-- Re-trigger: cancel any prior animation on this model. Without this, two
	-- popModel calls on the same model fight via separate heartbeats writing
	-- ScaleTo every frame, which can briefly oscillate above 1.0 and (worse)
	-- leave the model at a stale scale if cleanup paths race.
	cancelPopAnim(model)

	local ok = pcall(function()
		model:ScaleTo(POP_START_SCALE)
	end)
	if not ok then
		forceRestoreScale(model)
		return
	end

	local proxy = Instance.new("NumberValue")
	proxy.Value = POP_START_SCALE

	-- Quad/Out has NO overshoot (unlike Back/Out, which peaks ~1.10 mid-tween).
	-- Hard requirement: the model must never visually exceed scale 1.0, which
	-- guarantees no "huge" frames during rapid upgrades.
	local tweenInfo = TweenInfo.new(duration or POP_DURATION, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(proxy, tweenInfo, { Value = 1.0 })

	local state = { tween = tween, proxy = proxy }
	activePopAnims[model] = state

	state.conn = RunService.Heartbeat:Connect(function()
		-- If the model was destroyed or reparented out, clean up and bail.
		if not model.Parent then
			cancelPopAnim(model)
			return
		end
		-- Safety net: clamp the scale so a runaway proxy value can never make the
		-- model larger than its authored size.
		local value = proxy.Value
		if value > 1.0 then value = 1.0 end
		if value < POP_START_SCALE then value = POP_START_SCALE end
		pcall(function()
			model:ScaleTo(value)
		end)
	end)

	tween.Completed:Once(function(playbackState)
		-- Only finalize if this is still the active animation for the model.
		-- If `cancelPopAnim` already ran (re-trigger or destroy), state is gone
		-- and we must NOT touch the model — a new animation may already own it.
		if activePopAnims[model] ~= state then return end
		activePopAnims[model] = nil
		if state.conn then state.conn:Disconnect() end
		if state.proxy then state.proxy:Destroy() end
		if playbackState == Enum.PlaybackState.Completed then
			forceRestoreScale(model)
		end
	end)
	tween:Play()
end

local function animateUpgrade(podiumIndex, floorName)
	local plot = getPlayerPlot()
	if not plot then return end

	if floorName then
		local container = plot:FindFirstChild("Upgrade")
		local floorModel = container and container:FindFirstChild(floorName)
		if floorModel then
			popModel(floorModel, FLOOR_POP_DURATION)
		end
	end

	if podiumIndex then
		local podium = plot:FindFirstChild("Podium" .. podiumIndex)
		if podium then
			-- Stagger the podium pop slightly after the floor so they don't overlap visually.
			local delay = floorName and 0.2 or 0
			if delay > 0 then
				task.delay(delay, function()
					popModel(podium, POP_DURATION)
				end)
			else
				popModel(podium, POP_DURATION)
			end
		end
	end
end

local function onUpgradeClick()
	if upgradeInFlight then return end
	if not RequestUpgradeFunc then return end
	if cachedPayload and cachedPayload.IsMaxLevel then
		NotificationsController.SendRed("Maximum upgrade reached")
		return
	end

	-- Client-side cooldown. Even if the server's throttle would catch a fast
	-- second click, dropping it here avoids the round-trip + flicker.
	local now = os.clock()
	if now - lastUpgradeClickAt < CLIENT_UPGRADE_COOLDOWN then
		return
	end
	lastUpgradeClickAt = now

	upgradeInFlight = true

	task.spawn(function()
		local ok, success = pcall(function()
			return RequestUpgradeFunc:InvokeServer()
		end)
		if ok and success then
			-- Sound only plays on a successful purchase. Failed purchases get the
			-- server-fired NotEnoughCash red toast and nothing else.
			playUpgradeSound()
			NotificationsController.SendGreen("Upgraded Base!")
		end
		-- Keep upgradeInFlight latched for the cooldown period so that even if
		-- the server replies in <1 s, no new InvokeServer can fire.
		task.wait(CLIENT_UPGRADE_COOLDOWN)
		upgradeInFlight = false
	end)
end

-- Defensive safety net: every second, walk the local plot and snap any floor
-- or podium that has no active pop animation back to scale 1.0. Idempotent —
-- when the model is already at scale 1.0 this is a no-op. Catches any edge
-- case where popModel could leave a model at the wrong scale (model destroyed
-- mid-animation, replication race, etc.).
local function startScaleWatchdog()
	if scaleWatchdogConnected then return end
	scaleWatchdogConnected = true
	task.spawn(function()
		while true do
			task.wait(1)
			local plot = getPlayerPlot()
			if plot then
				local upgradeContainer = plot:FindFirstChild("Upgrade")
				if upgradeContainer then
					for _, floor in ipairs(upgradeContainer:GetChildren()) do
						if floor:IsA("Model") and activePopAnims[floor] == nil then
							pcall(function() floor:ScaleTo(1.0) end)
						end
					end
				end
				for _, child in ipairs(plot:GetChildren()) do
					if child:IsA("Model") and child.Name:match("^Podium%d+$") and activePopAnims[child] == nil then
						pcall(function() child:ScaleTo(1.0) end)
					end
				end
			end
		end
	end)
end

local function clearMount()
	if mountedGui then
		mountedGui:Destroy()
		mountedGui = nil
	end
	mountedSignPart = nil
end

local function mountSurfaceGui()
	local plot = getPlayerPlot()
	if not plot then return end

	local baseUpgrade = plot:FindFirstChild("BaseUpgrade")
	if not baseUpgrade then return end

	local uiPart = baseUpgrade:FindFirstChild("UIPart")
	if not uiPart then return end

	if mountedGui and mountedGui.Parent and mountedSignPart == uiPart then
		return
	end

	clearMount()

	local tmpl = getTemplate()
	if not tmpl then return end

	local gui = tmpl:Clone()
	gui.ResetOnSpawn = false
	gui.Adornee = uiPart
	gui.Enabled = true
	gui.Parent = playerGui

	mountedGui = gui
	mountedSignPart = uiPart

	local upgradeButton = gui:FindFirstChild("Upgrade")
	if upgradeButton and (upgradeButton:IsA("TextButton") or upgradeButton:IsA("ImageButton")) then
		if not upgradeButton:GetAttribute("_BaseUpgradeWired") then
			upgradeButton:SetAttribute("_BaseUpgradeWired", true)
			upgradeButton.MouseButton1Click:Connect(onUpgradeClick)
		end
	end

	if cachedPayload then
		applyPayloadToGui(cachedPayload)
	end
end

local function tryMountWithRetry()
	task.spawn(function()
		for _ = 1, 60 do
			if getPlayerPlot() then
				mountSurfaceGui()
				if mountedGui and mountedGui.Parent then
					return
				end
			end
			task.wait(0.3)
		end
	end)
end

function BaseUpgradeController.Init()
	if not ensureRemotes() then
		warn("[BaseUpgradeController] Remotes not available")
		return
	end

	startScaleWatchdog()

	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
			local owner = plot:GetAttribute("OwnerUserId")
			if owner == player.UserId then
				task.defer(mountSurfaceGui)
			elseif mountedSignPart and mountedSignPart:IsDescendantOf(plot) then
				clearMount()
			end
		end)
	end

	UpdateEvent.OnClientEvent:Connect(function(payload)
		cachedPayload = payload
		applyPayloadToGui(payload)
	end)

	BuiltEvent.OnClientEvent:Connect(function(podiumIndex, floorName)
		-- Defer one frame so the cloned model has propagated into the plot.
		task.defer(function()
			animateUpgrade(podiumIndex, floorName)
		end)
	end)

	tryMountWithRetry()

	task.spawn(function()
		for _ = 1, 20 do
			local ok, payload = pcall(function()
				return RequestDataFunc:InvokeServer()
			end)
			if ok and payload then
				cachedPayload = payload
				applyPayloadToGui(payload)
				return
			end
			task.wait(0.5)
		end
	end)
end

return BaseUpgradeController