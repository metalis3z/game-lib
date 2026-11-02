local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))
local FormatUtils = require(ReplicatedStorage.Source.Utils.FormatUtils)

local PURCHASE_SOUND_ID = "rbxassetid://100369772444661"

local UpgradeShopController = {}

-- Damage and Carry rows are hidden in the UI (user request: Storage + Speed only);
-- their configs/data stay server-side, so re-adding here re-enables them.
local STATS = { "Storage", "Walkspeed" }

local STAT_TO_ATTRIBUTE = {
	Storage = "MaxStorage",
	Damage  = "BaseDamage",
	Carry   = "MaxCarry",
	Walkspeed = "WalkSpeed",
}

local STAT_BUTTONS = {
	-- Storage matches the Walkspeed row now: one +1 cash buy + one +1 Robux
	-- buy (full-width buttons cloned from Walkspeed; +10/+20 bulk removed).
	Storage = {
		{ ButtonName = "Buy1",      Kind = "Cash1",       Amount = 1 },
		{ ButtonName = "Buy1Robux", Kind = "RobuxSingle", Amount = 1, IsRobux = true },
	},
	Damage = {
		{ ButtonName = "Buy1",  Kind = "Cash1",     Amount = 1  },
		{ ButtonName = "Buy10", Kind = "Cash10",    Amount = 10 },
		{ ButtonName = "Buy20", Kind = "RobuxBulk", Amount = 20, IsRobux = true },
	},
	Carry = {
		{ ButtonName = "Buy1",      Kind = "Cash1",       Amount = 1, CarryCash = true },
		{ ButtonName = "Buy1Robux", Kind = "RobuxSingle", Amount = 1, IsRobux = true },
	},
	Walkspeed = {
		{ ButtonName = "Buy1",      Kind = "Cash1",       Amount = 1 },
		{ ButtonName = "Buy1Robux", Kind = "RobuxSingle", Amount = 1, IsRobux = true },
	},
}

local player = nil
local playerGui = nil

local latestPayload = nil
local cachedShopFrame = nil
local pendingByKey = {}
local originalRobuxPriceText = {}

local function getHudStorageLabels()
	if not playerGui then
		return nil, nil
	end
	local gui = playerGui:FindFirstChild("GUI")
	local hud = gui and gui:FindFirstChild("HUD")
	local leftDown = hud and hud:FindFirstChild("LeftDownSide")
	local storageFrame = leftDown and leftDown:FindFirstChild("Storage")
	local double = storageFrame and storageFrame:FindFirstChild("Double")
	local amount = double and double:FindFirstChild("Amount")
	return double, amount
end

local function updateHudStorageLabel(maxStorage)
	if typeof(maxStorage) ~= "number" then
		return
	end
	local double, amount = getHudStorageLabels()
	if not double then
		return
	end
	local current = (player and player:GetAttribute("BridgeMaterial")) or 0
	if typeof(current) ~= "number" then
		current = 0
	end
	local text = string.format("%d/%d", math.floor(current), math.floor(maxStorage))
	double.Text = text
	if amount then
		amount.Text = text
	end
end

local function playPurchaseSound()
	local sound = Instance.new("Sound")
	sound.SoundId = PURCHASE_SOUND_ID
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

local function setLabelTextRecursive(label, text)
	if label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox") then
		label.Text = text
	end
	for _, desc in ipairs(label:GetDescendants()) do
		if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
			desc.Text = text
		end
	end
end

local function formatCashPrice(amount)
	return "$" .. FormatUtils.Abbreviate(amount)
end

local function getShopFrame()
	if cachedShopFrame and cachedShopFrame.Parent then
		return cachedShopFrame
	end
	if not playerGui then
		return nil
	end
	local gui = playerGui:WaitForChild("GUI", 30)
	local folder = gui and gui:WaitForChild("Folder", 30)
	cachedShopFrame = folder and folder:WaitForChild("UpgradeShop", 30)
	return cachedShopFrame
end

local function getStatFrame(statName)
	local shop = getShopFrame()
	if not shop then return nil end
	local scrolling = shop:WaitForChild("ScrollingFrame", 30)
	return scrolling and scrolling:WaitForChild(statName, 30)
end

local function getButton(statName, buttonName)
	local statFrame = getStatFrame(statName)
	if not statFrame then return nil end
	local buttons = statFrame:WaitForChild("Buttons", 30)
	return buttons and buttons:WaitForChild(buttonName, 30)
end

local function formatStatValue(statName, value)
	if statName == "Carry" then
		return tostring(value)
	end
	return FormatUtils.FormatNumber(math.floor(value))
end

local function applyStatFrame(statName, state)
	local statFrame = getStatFrame(statName)
	if not statFrame then
		return
	end

	local amountLabel = statFrame:FindFirstChild("Amount")
	if amountLabel then
		setLabelTextRecursive(amountLabel, formatStatValue(statName, state.Value or 0))
	end

	local maxLevel = state.MaxLevel or 0
	local currentLevel = state.Level or 0
	local isMaxed = currentLevel >= maxLevel

	local entries = STAT_BUTTONS[statName] or {}
	for _, entry in ipairs(entries) do
		local btn = getButton(statName, entry.ButtonName)
		if btn then
			local priceLabel = btn:FindFirstChild("Price")
			if priceLabel then
				local cacheKey = statName .. "_" .. entry.ButtonName
				if entry.IsRobux and originalRobuxPriceText[cacheKey] == nil then
					originalRobuxPriceText[cacheKey] = priceLabel.Text
				end
				if isMaxed then
					setLabelTextRecursive(priceLabel, "MAX.")
				elseif entry.Kind == "Cash1" then
					setLabelTextRecursive(priceLabel, formatCashPrice(state.NextCost1 or 0))
				elseif entry.Kind == "Cash10" then
					setLabelTextRecursive(priceLabel, formatCashPrice(state.NextCost10 or 0))
				elseif entry.Kind == "RobuxSingle" and state.RobuxPrice1 then
					-- escalating per-level Robux ladder (Storage/Walkspeed);
					-- Robux SYMBOL glyph inline (game-wide standard, U+E002 --
					-- the bare number read as "9" with no logo)
					setLabelTextRecursive(priceLabel, utf8.char(0xE002) .. tostring(state.RobuxPrice1))
				elseif entry.IsRobux then
					setLabelTextRecursive(priceLabel, originalRobuxPriceText[cacheKey] or priceLabel.Text)
				end
			end

			local rarityLabel = btn:FindFirstChild("Rarity")
			if rarityLabel then
				setLabelTextRecursive(rarityLabel, "+" .. tostring(entry.Amount))
			end

			btn.Active = not isMaxed
			btn.AutoButtonColor = not isMaxed
		end
	end
end

local function applyPayload(payload)
	if type(payload) ~= "table" then
		return
	end
	local levelIncreased = false
	if latestPayload then
		for _, statName in ipairs(STATS) do
			local prev = latestPayload[statName]
			local curr = payload[statName]
			if prev and curr and (curr.Level or 0) > (prev.Level or 0) then
				levelIncreased = true
				break
			end
		end
	end
	latestPayload = payload
	for _, statName in ipairs(STATS) do
		local state = payload[statName]
		if state then
			applyStatFrame(statName, state)
			local attrName = STAT_TO_ATTRIBUTE[statName]
			if attrName and player and typeof(state.Value) == "number" then
				player:SetAttribute(attrName, state.Value)
			end
			if statName == "Storage" and typeof(state.Value) == "number" then
				-- instant local echo; the server sets the replicated value right after.
				-- RarityLootClient listens to this attribute and repaints the
				-- backpack (Loot) HUD counter.
				if player then
					player:SetAttribute("MaxLootStorage", state.Value)
				end
				updateHudStorageLabel(state.Value)
			end
		end
	end
	if levelIncreased then
		playPurchaseSound()
	end
end

local BuyUpgradeFunc
local RequestUpgradeDataFunc
local UpgradeUpdateEvent

local function ensureRemotes()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local folder = Remotes:WaitForChild("UpgradeShopService", 30)
	if not folder then
		return false
	end
	BuyUpgradeFunc = folder:WaitForChild("BuyUpgrade", 30)
	RequestUpgradeDataFunc = folder:WaitForChild("RequestUpgradeData", 30)
	UpgradeUpdateEvent = folder:WaitForChild("UpgradeUpdate", 30)
	return BuyUpgradeFunc ~= nil and RequestUpgradeDataFunc ~= nil and UpgradeUpdateEvent ~= nil
end

local function onButtonClicked(statName, entry)
	local cfg = GameConfig.Upgrades and GameConfig.Upgrades[statName]
	if not cfg then
		warn(string.format("[UpgradeShopController] No GameConfig.Upgrades for %s", statName))
		return
	end
	local state = latestPayload and latestPayload[statName]
	if state and (state.Level or 0) >= (state.MaxLevel or 0) then
		return
	end
	local key = statName .. "_" .. entry.ButtonName
	if pendingByKey[key] then
		return
	end
	pendingByKey[key] = true
	task.spawn(function()
		if not BuyUpgradeFunc then
			warn("[UpgradeShopController] BuyUpgrade remote not ready")
			pendingByKey[key] = nil
			return
		end
		local success, result = pcall(function()
			return BuyUpgradeFunc:InvokeServer(statName, entry.Kind)
		end)
		if not success then
			warn(string.format("[UpgradeShopController] BuyUpgrade(%s, %s) errored: %s", statName, entry.Kind, tostring(result)))
		end
		pendingByKey[key] = nil
	end)
end

local function wireButtons()
	for _, statName in ipairs(STATS) do
		for _, entry in ipairs(STAT_BUTTONS[statName] or {}) do
			local btn = getButton(statName, entry.ButtonName)
			if not btn then
				warn(string.format("[UpgradeShopController] Button missing: %s.%s", statName, entry.ButtonName))
				continue
			end
			if not btn:IsA("GuiButton") then
				warn(string.format("[UpgradeShopController] Not a GuiButton: %s.%s (%s)", statName, entry.ButtonName, btn.ClassName))
				continue
			end
			if btn:GetAttribute("_UpgradeWired") then
				continue
			end
			btn:SetAttribute("_UpgradeWired", true)
			btn.MouseButton1Click:Connect(function()
				onButtonClicked(statName, entry)
			end)
		end
	end
end

function UpgradeShopController.Init()
	player = Players.LocalPlayer
	if not player then
		return
	end
	playerGui = player:WaitForChild("PlayerGui")

	task.spawn(function()
		if not ensureRemotes() then
			return
		end

		wireButtons()

		UpgradeUpdateEvent.OnClientEvent:Connect(applyPayload)

		for attempt = 1, 20 do
			local ok, payload = pcall(function()
				return RequestUpgradeDataFunc:InvokeServer()
			end)
			if ok and payload then
				applyPayload(payload)
				break
			end
			task.wait(0.5)
		end
	end)
end

return UpgradeShopController
