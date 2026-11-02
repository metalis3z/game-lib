local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local PodiumController = nil
local function getPodiumController()
	if not PodiumController then
		PodiumController = require(ReplicatedStorage.Source.Controllers.PodiumController)
	end
	return PodiumController
end

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PodiumRemotes = Remotes:WaitForChild("PodiumService")
local UpgradeBrainrotFunc = PodiumRemotes:WaitForChild("UpgradeBrainrot")
local PodiumUpdateEvent = PodiumRemotes:WaitForChild("PodiumUpdate")
local RequestPodiumDataFunc = PodiumRemotes:WaitForChild("RequestPodiumData")

-- Upgrade SFX is now owned by PodiumController.TriggerUpgradeFX so the sound
-- and the brainrot VFX stay co-located + cloned per click (the shared
-- SoundService.Sounds.UpgradeSound used to cut itself off on rapid clicks).

local PLOTS_FOLDER = Workspace:WaitForChild("Assets"):WaitForChild("Plots")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local UpgradeController = {}

local upgradeGuis = {}
local latestData = {}
local upgradingPodiums = {}
local templateRef = nil

local function getTemplate()
	if templateRef and templateRef.Parent then return templateRef end
	local found = StarterGui:FindFirstChild("UpgradeUI")
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

local function getPodiumsContainer(plot)
	local nested = plot:FindFirstChild("Podiums")
	if nested then return nested end
	return plot
end

local function setNestedLabelText(label, text)
	if not label then return end
	if label:IsA("TextLabel") or label:IsA("TextButton") then
		label.Text = text
	end
	for _, child in ipairs(label:GetChildren()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") then
			child.Text = text
		end
	end
end

local function clearGui(podiumIndex)
	local entry = upgradeGuis[podiumIndex]
	if not entry then return end
	if entry.Gui then
		entry.Gui:Destroy()
	end
	upgradeGuis[podiumIndex] = nil
end

local function setLabels(entry, data)
	if not entry or not data then return end
	local level = data.Level or 1
	local maxLevel = data.MaxLevel
	if maxLevel and level >= maxLevel then
		-- Fully upgraded: keep the button visible per user request, just swap
		-- the price text to "MAX" and lock the level line so it doesn't preview
		-- a non-existent next level.
		setNestedLabelText(entry.PriceLabel, "MAX")
		setNestedLabelText(entry.LevelLabel, "Lvl " .. level)
		return
	end
	local cost = data.UpgradeCost or 0
	setNestedLabelText(entry.PriceLabel, "$" .. FormatUtils.FormatNumber(cost))
	setNestedLabelText(entry.LevelLabel, "Lvl " .. level .. " -> Lvl " .. (level + 1))
end

local function onUpgradeClick(podiumIndex)
	-- Server rejects non-number indices (`type(podiumIndex) ~= "number"`).
	-- `podiumIndex` arrives here as a STRING when refreshPodium was called from
	-- `PodiumUpdate` (server keys state.Podiums by string). Normalize to number.
	podiumIndex = tonumber(podiumIndex) or podiumIndex

	-- MAX-level guard: button stays visible (per user request) but a click
	-- shouldn't even round-trip the server -- the server would just reject it.
	local cached = latestData[podiumIndex]
	if cached and cached.MaxLevel and (cached.Level or 1) >= cached.MaxLevel then
		return
	end

	if upgradingPodiums[podiumIndex] then return end
	upgradingPodiums[podiumIndex] = true

	local ok, success = pcall(function()
		return UpgradeBrainrotFunc:InvokeServer(podiumIndex)
	end)

	if ok and success then
		local pc = getPodiumController()
		if pc and pc.TriggerUpgradeFX then
			pc.TriggerUpgradeFX(podiumIndex)
		end
	end

	upgradingPodiums[podiumIndex] = nil
end

local function ensureGui(podiumIndex, podiumModel, data)
	local cfg = data and GameConfig.Items[data.BrainrotId]
	if cfg and cfg.IsPercentBrainrot then
		clearGui(podiumIndex)
		return
	end

	local upgradePart = podiumModel:FindFirstChild("UpgradeUIpart")
	if not upgradePart then return end

	local entry = upgradeGuis[podiumIndex]
	if entry and entry.Gui and entry.Gui.Parent then
		setLabels(entry, data)
		return
	end

	-- Defensive cleanup: PlayerGui may contain orphan UpgradeUI SurfaceGuis from
	-- (a) the StarterGui auto-clone with Adornee=nil and (b) older mounts that
	-- we lost track of in upgradeGuis. Destroy any UpgradeUI whose Adornee is nil
	-- or matches this upgradePart so we don't end up with duplicates stacked on
	-- the same UpgradeUIpart blocking each other's input.
	for _, child in ipairs(playerGui:GetChildren()) do
		if child.Name == "UpgradeUI" and child:IsA("SurfaceGui") then
			if child.Adornee == nil or child.Adornee == upgradePart then
				child:Destroy()
			end
		end
	end

	local tmpl = getTemplate()
	if not tmpl then return end

	local gui = tmpl:Clone()
	-- Disable AutoLocalize: the price + level labels are auto-formatted strings
	-- ("$1.5K", "Lvl 3 -> Lvl 4") that don't need translation. With 8 podiums per
	-- plot × multiple players' plots, all these SurfaceGuis adding text labels
	-- to Roblox's per-frame translation pass added up on camera movement.
	gui.AutoLocalize = false
	for _, desc in ipairs(gui:GetDescendants()) do
		if desc:IsA("GuiBase2d") then
			desc.AutoLocalize = false
		end
	end
	gui.ResetOnSpawn = false
	gui.Adornee = upgradePart
	gui.Parent = playerGui
	gui.Enabled = true

	local button = gui:FindFirstChild("KickButton")
	local numbers = button and button:FindFirstChild("Numbers")
	local priceLabel = numbers and numbers:FindFirstChild("Price")
	local levelLabel = numbers and numbers:FindFirstChild("Level")

	entry = {
		Gui = gui,
		Button = button,
		PriceLabel = priceLabel,
		LevelLabel = levelLabel,
	}
	upgradeGuis[podiumIndex] = entry

	if button and (button:IsA("TextButton") or button:IsA("ImageButton")) then
		button.MouseButton1Click:Connect(function()
			onUpgradeClick(podiumIndex)
		end)
	end

	setLabels(entry, data)
end

local function refreshPodium(podiumIndex, data)
	-- Normalize to number. PodiumUpdate fires during the rejoin profile-load blast
	-- carry STRING keys (server's state.Podiums is keyed by tostring(i) to avoid
	-- sparse-array serialization). Later sendPodiumUpdate calls (Place/Remove/
	-- Upgrade) pass NUMBER keys. Without normalization, upgradeGuis ends up with
	-- mixed string/number keys, so clearGui(6) misses an entry stored at
	-- upgradeGuis["6"] and the upgrade UI lingers on a now-empty podium.
	podiumIndex = tonumber(podiumIndex) or podiumIndex

	latestData[podiumIndex] = data

	local plot = getPlayerPlot()
	if not plot then return end
	local podiumsFolder = getPodiumsContainer(plot)
	local podiumModel = podiumsFolder:FindFirstChild("Podium" .. podiumIndex)
	if not podiumModel then return end

	-- Mid-unbox reveal: server has already committed the rolled brainrot to
	-- PlacedBrainrot[idx] (so the PodiumUpdate landed here with brainrot data),
	-- but PodiumController is still playing the roulette at the pad and hasn't
	-- swapped to the real model yet. Showing the upgrade button now lets the
	-- player kick before the reveal even finishes. Keep the GUI hidden until
	-- PodiumController.RevealCompleted fires for this podium; we re-call
	-- refreshPodium from the listener in Init using the cached latestData.
	local pc = getPodiumController()
	if pc and pc.IsRevealing and pc.IsRevealing(podiumIndex) then
		clearGui(podiumIndex)
		return
	end

	-- Lucky blocks have no level/CPS, so never show the upgrade button on them.
	if not data or data.ItemType == "LuckyBlock" or data.LuckyBlockId then
		clearGui(podiumIndex)
		return
	end

	-- MaxLevel is handled inside setLabels (text swaps to "MAX"); the button
	-- stays mounted so the player can see they've fully upgraded the slot.
	ensureGui(podiumIndex, podiumModel, data)
end

local function rebuildFromCache()
	for podiumIndex, data in pairs(latestData) do
		local entry = upgradeGuis[podiumIndex]
		if not entry or not entry.Gui or not entry.Gui.Parent then
			upgradeGuis[podiumIndex] = nil
			refreshPodium(podiumIndex, data)
		end
	end
end

local function parsePodiumIndex(podiumModel)
	return tonumber(podiumModel.Name:match("Podium(%d+)"))
end

function UpgradeController.Init()
	player.CharacterAdded:Connect(function()
		task.defer(rebuildFromCache)
	end)

	-- When PodiumController finishes the at-the-pad unbox reveal, re-evaluate
	-- this podium's upgrade GUI -- it was being skipped by refreshPodium while
	-- IsRevealing was true. latestData was kept up to date during the reveal so
	-- a single rerun applies the brainrot's level + cost without another
	-- server round-trip.
	task.defer(function()
		local pc = getPodiumController()
		if pc and pc.RevealCompleted then
			pc.RevealCompleted.Event:Connect(function(podiumIndex)
				podiumIndex = tonumber(podiumIndex) or podiumIndex
				local cached = latestData[podiumIndex]
				if cached then
					refreshPodium(podiumIndex, cached)
				end
			end)
		end
	end)

	for _, plot in ipairs(PLOTS_FOLDER:GetChildren()) do
		plot:GetAttributeChangedSignal("OwnerUserId"):Connect(function()
			local owner = plot:GetAttribute("OwnerUserId")
			if owner == player.UserId then
				task.defer(function()
					task.wait(0.3)
					rebuildFromCache()
				end)
			end
		end)
	end

	-- Rejoin burst: server fires N PodiumUpdate events back-to-back on ProfileLoaded
	-- (plus a 2s re-fire). Each one synchronously clones a SurfaceGui + wires up a
	-- button — fine for one podium, brutal for 10. Queue and drain one per frame so
	-- the burst doesn't crush the join frame. Map-coalesced FIFO matches the same
	-- pattern in PodiumController.
	local pendingUpgradeUpdates = {}
	local pendingUpgradeOrder = {}
	local upgradeWorkerActive = false

	local function processUpgradeQueue()
		if upgradeWorkerActive then return end
		upgradeWorkerActive = true
		task.spawn(function()
			while #pendingUpgradeOrder > 0 do
				local podiumIndex = table.remove(pendingUpgradeOrder, 1)
				local entry = pendingUpgradeUpdates[podiumIndex]
				if entry then
					pendingUpgradeUpdates[podiumIndex] = nil
					local ok, err = pcall(function()
						refreshPodium(podiumIndex, entry.data)
					end)
					if not ok then
						warn(string.format("[UpgradeController] queued refreshPodium error: %s", tostring(err)))
					end
					task.wait()
				end
			end
			upgradeWorkerActive = false
		end)
	end

	PodiumUpdateEvent.OnClientEvent:Connect(function(podiumIndex, data, ownerUserId)
		if not ownerUserId then
			ownerUserId = player.UserId
		end
		if ownerUserId ~= player.UserId then return end
		if podiumIndex == 0 then
			-- Drop any pending updates so we don't render stale data after cleanup.
			pendingUpgradeUpdates = {}
			pendingUpgradeOrder = {}
			for idx in pairs(upgradeGuis) do
				clearGui(idx)
			end
			latestData = {}
			return
		end

		local key = tonumber(podiumIndex) or podiumIndex
		local existing = pendingUpgradeUpdates[key]
		if existing then
			existing.data = data
		else
			pendingUpgradeUpdates[key] = { data = data }
			table.insert(pendingUpgradeOrder, key)
		end
		processUpgradeQueue()
	end)

	task.spawn(function()
		local plot = nil
		for _ = 1, 150 do
			plot = getPlayerPlot()
			if plot then break end
			task.wait(0.2)
		end
		if not plot then return end

		for _ = 1, 60 do
			local ok, state = pcall(function()
				return RequestPodiumDataFunc:InvokeServer()
			end)
			if ok and state then
				local podiums = state.Podiums or {}
				local podiumsFolder = getPodiumsContainer(plot)
				for _, child in ipairs(podiumsFolder:GetChildren()) do
					local idx = parsePodiumIndex(child)
					if idx then
						refreshPodium(idx, podiums[idx] or podiums[tostring(idx)])
						task.wait()
					end
				end
				break
			end
			task.wait(0.5)
		end
	end)
end

return UpgradeController
