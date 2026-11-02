local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)
local CashBoostHudController = require(ReplicatedStorage.Source.Controllers.CashBoostHudController)

local CashDisplayController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local DataRemotes = Remotes:WaitForChild("PlayerDataService")
local DataUpdateEvent = DataRemotes:WaitForChild("DataUpdate")
local RequestDataFunc = DataRemotes:WaitForChild("RequestData")

local RebirthRemotes = Remotes:WaitForChild("RebirthService")
local RebirthUpdateEvent = RebirthRemotes:WaitForChild("RebirthUpdate")

local PodiumRemotes = Remotes:WaitForChild("PodiumService")
local RequestPodiumDataFunc = PodiumRemotes:WaitForChild("RequestPodiumData")
local PodiumUpdateEvent = PodiumRemotes:WaitForChild("PodiumUpdate")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local cashLabel = nil
local incomeLabel = nil

local currentCash = 0
local displayedCash = 0
local totalIncome = 0
local displayedIncome = 0

local podiumData = {}

local LERP_SPEED = 10
local INCOME_LERP_SPEED = 8
local UPGRADE_CASH_MULTIPLIER = 1.5

local PULSE_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local PULSE_BACK_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local originalCashSize = nil
local originalIncomeSize = nil
local lastCashText = ""
local lastIncomeText = ""

local rebirthMultiplier = 1.0

local function getCashBoostMultiplier()
	local ok, m = pcall(CashBoostHudController.GetMultiplier)
	if ok and type(m) == "number" then
		return m
	end
	return 1
end

local CPS_BONUS_PERCENT = 0.5
local COST_MULTIPLIER = 1.5

local function pulseLabel(label, originalSize)
	if not label then return end
	local scaleUp = UDim2.new(
		originalSize.X.Scale * 1.12, originalSize.X.Offset,
		originalSize.Y.Scale * 1.12, originalSize.Y.Offset
	)
	TweenService:Create(label, PULSE_INFO, { Size = scaleUp }):Play()
	task.delay(0.15, function()
		if label and label.Parent then
			TweenService:Create(label, PULSE_BACK_INFO, { Size = originalSize }):Play()
		end
	end)
end

local function getCashPerSec(baseCashPerSec, level)
	if level <= 1 then return baseCashPerSec end

	local levelIndex = level - 1

	return baseCashPerSec + (baseCashPerSec * CPS_BONUS_PERCENT * levelIndex)
end

local function recalcTotalIncome()
	local sum = 0
	for _, data in pairs(podiumData) do
		sum = sum + (data.CashPerSec or 0)
	end
	totalIncome = sum * rebirthMultiplier * getCashBoostMultiplier()
end


local function updateDisplays(dt)
	if cashLabel then
		if displayedCash ~= currentCash then
			local diff = currentCash - displayedCash
			local step = diff * math.min(1, LERP_SPEED * dt)
			if math.abs(diff) < 1 then
				displayedCash = currentCash
			else
				displayedCash = displayedCash + step
			end
		end
			local newText = "$" .. FormatUtils.Abbreviate(math.floor(displayedCash))
		if newText ~= lastCashText then
			cashLabel.Text = newText
			if cashLabelInner then cashLabelInner.Text = newText end
			lastCashText = newText
		end
	end

	if incomeLabel then
		if displayedIncome ~= totalIncome then
			local diff = totalIncome - displayedIncome
			local step = diff * math.min(1, INCOME_LERP_SPEED * dt)
			if math.abs(diff) < 0.01 then
				displayedIncome = totalIncome
			else
				displayedIncome = displayedIncome + step
			end
		end
		local newText = "$" .. FormatUtils.Abbreviate(displayedIncome) .. "/s"
		if newText ~= lastIncomeText then
			incomeLabel.Text = newText
			lastIncomeText = newText
		end
	end
end


local function onDataUpdate(statName, value)
	if statName == "Cash" then
		currentCash = value
		if originalCashSize then
			pulseLabel(cashLabel, originalCashSize)
		end
	end
end

local function onPodiumUpdate(podiumIndex, payload, ownerUserId)
	if ownerUserId and ownerUserId ~= player.UserId then return end
	if podiumIndex == 0 then return end

	local oldIncome = totalIncome

	if not payload then
		podiumData[podiumIndex] = nil
	else
		podiumData[podiumIndex] = {
			CashPerSec = payload.CashPerSec or 0,
		}
	end

	recalcTotalIncome()

	if totalIncome ~= oldIncome and originalIncomeSize then
		pulseLabel(incomeLabel, originalIncomeSize)
	end
end

local function applyInitialData(initialData)
	currentCash = initialData.Cash
	displayedCash = currentCash
	local t = "$" .. FormatUtils.Abbreviate(math.floor(currentCash))
	cashLabel.Text = t
	if cashLabelInner then cashLabelInner.Text = t end
	lastCashText = t

	if initialData.Rebirths then
		local perRebirth = (GameConfig.Rebirth and GameConfig.Rebirth.CashMultiplierPerRebirth) or 0
		rebirthMultiplier = 1 + initialData.Rebirths * perRebirth
	end
end

function CashDisplayController.Init()
	local gui = playerGui:WaitForChild("GUI")
	local hud = gui:WaitForChild("HUD")
	local leftDown = hud:WaitForChild("LeftDownSide")

	local cashFrame = leftDown:WaitForChild("Cash")
	cashLabel = cashFrame:WaitForChild("Double")
	cashLabelInner = cashLabel:WaitForChild("Amount")

	originalCashSize = cashLabel.Size

	-- Rebirth counter (LeftDownSide.Extra): nothing ever wrote this label,
	-- so it sat at the authored "0" forever. RebirthService mirrors the
	-- count to the "Rebirths" player attribute on profile load and on every
	-- rebirth, so binding the attribute keeps it live.
	local extraFrame = leftDown:FindFirstChild("Extra")
	if extraFrame then
		local rebirthLabel = extraFrame:FindFirstChild("Double")
		local rebirthInner = rebirthLabel and rebirthLabel:FindFirstChild("Amount")
		local originalRebirthSize = rebirthLabel and rebirthLabel.Size
		local function refreshRebirths(pulse)
			if not rebirthLabel then
				return
			end
			local count = tonumber(player:GetAttribute("Rebirths")) or 0
			local text = FormatUtils.Abbreviate(count)
			rebirthLabel.Text = text
			if rebirthInner then
				rebirthInner.Text = text
			end
			if pulse and originalRebirthSize then
				pulseLabel(rebirthLabel, originalRebirthSize)
			end
		end
		player:GetAttributeChangedSignal("Rebirths"):Connect(function()
			refreshRebirths(true)
		end)
		refreshRebirths(false)
	end

	DataUpdateEvent.OnClientEvent:Connect(onDataUpdate)
	PodiumUpdateEvent.OnClientEvent:Connect(onPodiumUpdate)
	RunService.Heartbeat:Connect(updateDisplays)

	RebirthUpdateEvent.OnClientEvent:Connect(function(rebirthData)
		if rebirthData and rebirthData.CurrentMultiplier then
			local oldIncome = totalIncome
			rebirthMultiplier = rebirthData.CurrentMultiplier
			recalcTotalIncome()
			if totalIncome ~= oldIncome and originalIncomeSize then
				pulseLabel(incomeLabel, originalIncomeSize)
			end
		end
	end)

	CashBoostHudController.BoostChanged:Connect(function()
		local oldIncome = totalIncome
		recalcTotalIncome()
		if totalIncome ~= oldIncome and originalIncomeSize then
			pulseLabel(incomeLabel, originalIncomeSize)
		end
	end)

	task.spawn(function()
		local initialData = nil
		for _ = 1, 20 do
			local ok, result = pcall(function()
				return RequestDataFunc:InvokeServer()
			end)
			if ok and result and result.Cash then
				initialData = result
				break
			end
			task.wait(0.5)
		end

		if initialData then
			applyInitialData(initialData)
		else
			local leaderstats = player:FindFirstChild("leaderstats")
				or player:WaitForChild("leaderstats", 10)
			if leaderstats then
				local cashStat = leaderstats:FindFirstChild("Cash")
					or leaderstats:WaitForChild("Cash", 5)
				if cashStat then
					currentCash = cashStat.Value
					displayedCash = currentCash
					local t = "$" .. FormatUtils.Abbreviate(math.floor(currentCash))
					cashLabel.Text = t
					if cashLabelInner then cashLabelInner.Text = t end
					lastCashText = t
				end
			end
		end

		for _ = 1, 10 do
			local ok, podiumState = pcall(function()
				return RequestPodiumDataFunc:InvokeServer()
			end)
			if ok and podiumState and podiumState.Podiums then
				for i, payload in pairs(podiumState.Podiums) do
					if payload and payload.BrainrotId then
						podiumData[i] = {
							CashPerSec = payload.CashPerSec or 0,
						}
					end
				end
				break
			end
			task.wait(0.5)
		end

		recalcTotalIncome()
		displayedIncome = totalIncome

	end)
end

return CashDisplayController