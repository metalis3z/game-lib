local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local CashBoostHudController = require(ReplicatedStorage.Source.Controllers.CashBoostHudController)

local PlotController = {}
local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local plotUiCache = {}
local plotRetryVersion = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local RebirthRemotes = Remotes:WaitForChild("RebirthService")
local RebirthUpdateEvent = RebirthRemotes:WaitForChild("RebirthUpdate")

local rebirthMultiplier = 1.0

local function getCashBoostMultiplier()
	local ok, m = pcall(CashBoostHudController.GetMultiplier)
	if ok and type(m) == "number" then
		return m
	end
	return 1
end

local function getPlayerName(userId)
	local player = Players:GetPlayerByUserId(userId)
	if player then return player.Name end

	local success, name = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	return success and name or "Unknown"
end

local function cachePlotUI(plot)
	local sign = plot:FindFirstChild("Sign")
	if not sign then return nil end

	local surfaceModel = sign:FindFirstChild("SurfaceModel")
	if not surfaceModel then return nil end

	local surfacePart = surfaceModel:FindFirstChild("SurfacePart")
	if not surfacePart then return nil end

	local backGui = surfacePart:FindFirstChild("Back")
	local frontGui = surfacePart:FindFirstChild("Front")
	if not backGui or not frontGui then return nil end

	local backFrame = backGui:FindFirstChild("Frame")
	local frontFrame = frontGui:FindFirstChild("Frame")
	if not backFrame or not frontFrame then return nil end

	local counterFrame = backFrame:FindFirstChild("CounterFrame")
	local labelFrame = frontFrame:FindFirstChild("LabelFrame")
	local profileImage = frontFrame:FindFirstChild("ProfileImage")
	if not counterFrame or not labelFrame or not profileImage then return nil end

	local epic = counterFrame:FindFirstChild("Epic")
	local legendary = counterFrame:FindFirstChild("Legendary")
	local mythic = counterFrame:FindFirstChild("Mythic")
	local nameLabel = labelFrame:FindFirstChild("NameLabel")
	local moneyLabel = labelFrame:FindFirstChild("MoneyLabel")
	if not epic or not legendary or not mythic or not nameLabel or not moneyLabel then return nil end

	local epicText = epic:FindFirstChild("TextLabel")
	local legendaryText = legendary:FindFirstChild("TextLabel")
	local mythicText = mythic:FindFirstChild("TextLabel")
	local nameText = nameLabel:FindFirstChild("TextLabel")
	if not epicText or not legendaryText or not mythicText or not nameText then return nil end

	return {
		Epic = epicText,
		Legendary = legendaryText,
		Mythic = mythicText,
		NameLabel = nameText,
		MoneyLabel = moneyLabel,
		ProfileImage = profileImage
	}
end

local function updateMoneyLabel(plot, ui)
	if not plot or not ui or not ui.MoneyLabel then return end

	local ownerId = plot:GetAttribute("OwnerUserId")
	if not ownerId or ownerId == 0 then
		ui.MoneyLabel.Text = "$0.00/s"
		return
	end

	local baseCps = plot:GetAttribute("TotalCashPerSec") or 0
	local totalCps = baseCps * rebirthMultiplier * getCashBoostMultiplier()
	ui.MoneyLabel.Text = "$" .. FormatUtils.Abbreviate(totalCps) .. "/s"
end

local function refreshAllMoneyLabels()
	for plot, ui in pairs(plotUiCache) do
		updateMoneyLabel(plot, ui)
	end
end

local function applyInitialData(initialData)
	if initialData.Rebirths then
		local mult = GameConfig.BaseCashMultiplier or 1.0
		for i = 1, initialData.Rebirths do
			local cfg = GameConfig.Rebirths[i]
			if cfg and cfg.Unlocks then
				mult = mult + (cfg.Unlocks.CashMultiplierBonus or 0)
			end
		end
		rebirthMultiplier = mult
	end
end

local function updateFrontSign(plot, ui)
	local ownerId = plot:GetAttribute("OwnerUserId")

	if not ui.NameLabel or not ui.ProfileImage then return end

	if ownerId and ownerId > 0 then
		task.spawn(function()
			ui.NameLabel.Text = getPlayerName(ownerId) .. "'s Plot"
			local content = Players:GetUserThumbnailAsync(ownerId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			ui.ProfileImage.Image = content
			ui.ProfileImage.Visible = true
		end)
	else
		ui.NameLabel.Text = "Unclaimed Plot"
		ui.ProfileImage.Image = ""
		ui.ProfileImage.Visible = false
	end

	updateMoneyLabel(plot, ui)
end

local function updatePityTimers()
	local now = os.time()

	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		local ui = plotUiCache[plot]

		if ui and (plot:GetAttribute("OwnerUserId") or 0) > 0 then
			if ui.Epic then
				local target = plot:GetAttribute("PityTarget_Epic") or (now + 300)
				local remaining = math.max(0, target - now)
				ui.Epic.Text = "Epic Block In: " .. FormatUtils.FormatTime(remaining)
			end

			if ui.Legendary then
				local target = plot:GetAttribute("PityTarget_Legendary") or (now + 900)
				local remaining = math.max(0, target - now)
				ui.Legendary.Text = "Legendary Block In: " .. FormatUtils.FormatTime(remaining)
			end

			if ui.Mythic then
				local target = plot:GetAttribute("PityTarget_Mythic") or (now + 1800)
				local remaining = math.max(0, target - now)
				ui.Mythic.Text = "Mythic Block In: " .. FormatUtils.FormatTime(remaining)
			end
		end
	end
end

local function bindPlot(plot)
	local function refreshUi()
		local ui = cachePlotUI(plot)
		plotUiCache[plot] = ui
		if ui then
			updateFrontSign(plot, ui)
			return true
		end
		return false
	end

	local function retryRefresh()
		local version = (plotRetryVersion[plot] or 0) + 1
		plotRetryVersion[plot] = version

		task.spawn(function()
			for _ = 1, 20 do
				if plot.Parent == nil then
					return
				end

				if plotRetryVersion[plot] ~= version then
					return
				end

				if refreshUi() then
					return
				end

				task.wait(0.25)
			end
		end)
	end

	if not refreshUi() then
		retryRefresh()
	end

	plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
		if not refreshUi() then
			retryRefresh()
		end
	end)

	plot:GetAttributeChangedSignal("TotalCashPerSec"):Connect(function()
		local ui = plotUiCache[plot]
		if ui then
			updateMoneyLabel(plot, ui)
		end
	end)

	plot.DescendantAdded:Connect(function()
		if not plotUiCache[plot] then
			refreshUi()
		end
	end)
end

function PlotController.Init()
	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		bindPlot(plot)
	end
	
	RebirthUpdateEvent.OnClientEvent:Connect(function(rebirthData)
		if rebirthData and rebirthData.CurrentMultiplier then
			rebirthMultiplier = rebirthData.CurrentMultiplier
			refreshAllMoneyLabels()
		end
	end)

	CashBoostHudController.BoostChanged:Connect(function()
		refreshAllMoneyLabels()
	end)

	PLOTS_FOLDER.ChildAdded:Connect(function(plot)
		bindPlot(plot)
	end)

	PLOTS_FOLDER.ChildRemoved:Connect(function(plot)
		plotUiCache[plot] = nil
		plotRetryVersion[plot] = nil
	end)

	local _lastPityTick = 0
	RunService.Heartbeat:Connect(function()
		local t = os.clock()
		if t - _lastPityTick < 1 then return end
		_lastPityTick = t
		updatePityTimers()
	end)
end

return PlotController