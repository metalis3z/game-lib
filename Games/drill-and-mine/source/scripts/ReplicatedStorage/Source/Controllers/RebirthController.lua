local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local RedNotificationController = require(ReplicatedStorage.Source.Controllers.RedNotificationController)
local FireworkModule = require(ReplicatedStorage.Source.Modules.FireworkModule)
local AnimatedText = require(ReplicatedStorage.Source.Modules.AnimatedText)

local RebirthController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RebirthRemotes = Remotes:WaitForChild("RebirthService")
local RequestRebirthFunc = RebirthRemotes:WaitForChild("RequestRebirth")
local RequestSkipRebirthFunc = RebirthRemotes:WaitForChild("RequestSkipRebirth")
local RequestRebirthDataFunc = RebirthRemotes:WaitForChild("RequestRebirthData")
local RebirthUpdateEvent = RebirthRemotes:WaitForChild("RebirthUpdate")

local REBIRTH_SOUND_ID = (GameConfig.Rebirth and GameConfig.Rebirth.Sound) or "rbxassetid://112283037672337"

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local cachedPayload = nil
local isRebirthing = false
local cashGamepassMult = 1

local rebirthFrame = nil
local rebirthButton = nil
local skipRebirthButton = nil
local skipPriceLabel = nil
local skipPricePrefix = ""
local cashOldLabel = nil
local cashNewLabel = nil
local itemOldLabel = nil
local itemNewLabel = nil
local currentRebirthLabel = nil
local newRebirthLabel = nil
local completionLabel = nil
local progressFill = nil

local function formatMultiplier(mult)
	if typeof(mult) ~= "number" then
		return "x1"
	end
	if math.abs(mult - math.floor(mult + 0.5)) < 0.001 then
		return string.format("x%d", math.floor(mult + 0.5))
	end
	local text = string.format("%.2f", mult)
	text = text:gsub("0+$", ""):gsub("%.$", "")
	return "x" .. text
end

local function setLabelText(label, text)
	if not label then return end
	label.Text = text
	local double = label:FindFirstChild("Double")
	if double then
		double.Text = text
	end
end

-- AnimatedText churn guard (same pattern as the Drill shop damage labels):
-- updateUI runs on every Level change and server payload push -- also while
-- the frame is CLOSED -- and on open it always finds stale text (Level
-- moved), so AnimatedText built hundreds of per-char CanvasGroups in one
-- frame right as the open animation played. While closed the labels stay
-- UNBOUND (plain Text writes are near-free); re-binding on open keeps the
-- per-char animation for changes that happen while the frame is visible
-- (e.g. the values rolling over when you actually rebirth).
local function setRebirthLabelsBound(bound)
	local function apply(label)
		if not label then return end
		local targets = { label }
		local double = label:FindFirstChild("Double")
		if double then
			table.insert(targets, double)
		end
		for _, t in ipairs(targets) do
			if bound then
				AnimatedText.Bind(t)
			else
				AnimatedText.Unbind(t)
			end
		end
	end
	apply(cashOldLabel)
	apply(cashNewLabel)
	apply(itemOldLabel)
	apply(itemNewLabel)
	apply(currentRebirthLabel)
	apply(newRebirthLabel)
	apply(completionLabel)
	apply(skipPriceLabel)
end

local function playRebirthSound()
	local sound = Instance.new("Sound")
	sound.SoundId = REBIRTH_SOUND_ID
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(8, function()
		if sound and sound.Parent then
			sound:Destroy()
		end
	end)
end

local function updateUI()
	if not cachedPayload then return end
	if not rebirthFrame then return end

	setLabelText(cashOldLabel, formatMultiplier(cachedPayload.CurrentCashMultiplier or 1) .. " Cash")
	setLabelText(cashNewLabel, formatMultiplier(cachedPayload.NextCashMultiplier or 1) .. " Cash")
	setLabelText(itemOldLabel, formatMultiplier(cachedPayload.CurrentMaterialMultiplier or 1) .. " Strength")
	setLabelText(itemNewLabel, formatMultiplier(cachedPayload.NextMaterialMultiplier or 1) .. " Strength")

	local current = cachedPayload.CurrentRebirths or 0
	local nextR = cachedPayload.NextRebirths or (current + 1)
	setLabelText(currentRebirthLabel, "Rebirth " .. current)
	setLabelText(newRebirthLabel, "Rebirth " .. nextR)

	local level = player:GetAttribute("Level") or 1
	local rebirths = cachedPayload.CurrentRebirths or 0
	local getRequired = GameConfig.Rebirth and GameConfig.Rebirth.GetRequiredLevel
	-- mirror of RebirthService.getRequiredLevel (linear); the payload's
	-- RequiredLevel always wins when present
	local reqLevel = cachedPayload.RequiredLevel
		or (getRequired and getRequired(rebirths))
		or (25 + 25 * rebirths)
	setLabelText(completionLabel, string.format("Level: %d/%d", math.min(level, reqLevel), reqLevel))
	if progressFill then
		progressFill.Size = UDim2.new(math.clamp(level / reqLevel, 0, 1), 0, 1, 0)
	end

	-- Robux skip ladder: price escalates per rebirth (payload.SkipPrice) and
	-- only the first 10 rebirths are buyable -- past MaxRobuxRebirths the
	-- server sends CanSkip=false and the button hides.
	if skipRebirthButton then
		local canSkip = cachedPayload.CanSkip == true
		skipRebirthButton.Visible = canSkip
		if canSkip and skipPriceLabel and cachedPayload.SkipPrice then
			setLabelText(skipPriceLabel, skipPricePrefix .. tostring(cachedPayload.SkipPrice))
		end
	end
end

player:GetAttributeChangedSignal("Level"):Connect(function()
	if cachedPayload and rebirthFrame then updateUI() end
end)

local function onRebirthUpdate(payload)
	if not payload then return end
	cachedPayload = payload
	updateUI()
end

-- Rebirth FX (fireworks + sound) key off the Rebirths attribute increasing
-- so BOTH paths celebrate: the level path AND the Robux skip, whose grant
-- now lands server-side in the purchase receipt (there is no client success
-- return to hook anymore). Guarded against the initial attribute push on join.
local lastRebirths = player:GetAttribute("Rebirths")
player:GetAttributeChangedSignal("Rebirths"):Connect(function()
	local now = player:GetAttribute("Rebirths")
	if typeof(now) == "number" and typeof(lastRebirths) == "number" and now > lastRebirths then
		FireworkModule.PlayAtPlayer()
		playRebirthSound()
	end
	lastRebirths = now
end)

local function onRebirthClicked()
	if isRebirthing then return end
	if not cachedPayload then return end
	if not cachedPayload.MeetsRequirements then
		RedNotificationController.Send("Not enough level!")
		return
	end

	isRebirthing = true
	pcall(function()
		return RequestRebirthFunc:InvokeServer()
	end)
	task.delay(1, function() isRebirthing = false end)
end

local function onSkipRebirthClicked()
	if isRebirthing then return end
	if not cachedPayload then return end
	if cachedPayload.CanSkip ~= true then return end

	-- The server picks the ladder product for our CURRENT rebirth count and
	-- grants inside the purchase callback (see RebirthService) -- the invoke
	-- just opens the Robux prompt, the purchase overlay follows the usual
	-- PurchaseResult events.
	isRebirthing = true
	pcall(function()
		return RequestSkipRebirthFunc:InvokeServer()
	end)
	task.delay(1, function() isRebirthing = false end)
end

function RebirthController.GetCurrentMultiplier()
	return cachedPayload and cachedPayload.CurrentCashMultiplier or 1
end

function RebirthController.GetCurrentMaterialMultiplier()
	return cachedPayload and cachedPayload.CurrentMaterialMultiplier or 1
end

function RebirthController.GetCashGamepassMultiplier()
	return cashGamepassMult
end

function RebirthController.Init()
	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then return end

	local folder = gui:WaitForChild("Folder", 30)
	if not folder then return end

	rebirthFrame = folder:WaitForChild("Rebirth", 30)
	if not rebirthFrame then return end

	local requirements = rebirthFrame:WaitForChild("Requirements", 10)
	local stats = requirements and requirements:WaitForChild("Stats", 10)
	local cashFrame = stats and stats:FindFirstChild("Cash")
	local itemFrame = stats and stats:FindFirstChild("Item")
	local rebirthAmount = stats and stats:FindFirstChild("RebirthAmount")

	if cashFrame then
		local oldStat = cashFrame:FindFirstChild("OldStat")
		local newStat = cashFrame:FindFirstChild("NewStat")
		cashOldLabel = oldStat and oldStat:FindFirstChild("Multi")
		cashNewLabel = newStat and newStat:FindFirstChild("Multi")
	end

	if itemFrame then
		local oldStat = itemFrame:FindFirstChild("OldStat")
		local newStat = itemFrame:FindFirstChild("NewStat")
		itemOldLabel = oldStat and oldStat:FindFirstChild("Multi")
		itemNewLabel = newStat and newStat:FindFirstChild("Multi")
	end

	if rebirthAmount then
		currentRebirthLabel = rebirthAmount:FindFirstChild("CurrentRebirth")
		newRebirthLabel = rebirthAmount:FindFirstChild("NewRebirth")
	end

	local progressbar = requirements and requirements:FindFirstChild("Progressbar")
	if progressbar then
		progressFill = progressbar:FindFirstChild("Fill")
		completionLabel = progressbar:FindFirstChild("Completion")
	end

	local buttonsFrame = requirements and requirements:FindFirstChild("Buttons")
	if buttonsFrame then
		rebirthButton = buttonsFrame:FindFirstChild("Rebirth")
		skipRebirthButton = buttonsFrame:FindFirstChild("SkipRebirth")

		if rebirthButton then
			rebirthButton.MouseButton1Click:Connect(onRebirthClicked)
		end
		if skipRebirthButton then
			-- the button has TWO "Title" labels: the "Skip Rebirth" caption
			-- and the price label, whose text is the U+E002 Robux-logo glyph
			-- followed by the number (so tonumber() on it FAILS -- match on
			-- digits instead) -- keep everything before the first digit as a
			-- prefix so the logo survives every price update
			for _, child in ipairs(skipRebirthButton:GetChildren()) do
				if child:IsA("TextLabel") and child.Name == "Title" and child.Text:match("%d") then
					skipPriceLabel = child
					skipPricePrefix = child.Text:match("^[^%d]*") or ""
				end
			end
			skipRebirthButton.MouseButton1Click:Connect(onSkipRebirthClicked)
		end
	end

	RebirthUpdateEvent.OnClientEvent:Connect(onRebirthUpdate)

	rebirthFrame:GetPropertyChangedSignal("Visible"):Connect(function()
		if rebirthFrame.Visible then
			setRebirthLabelsBound(true)
			updateUI()
		else
			setRebirthLabelsBound(false)
		end
	end)

	-- AnimatedTextController auto-bound these labels at startup; drop them
	-- back out until the first open (deferred so it runs after those
	-- queued auto-binds).
	task.defer(function()
		if not rebirthFrame.Visible then
			setRebirthLabelsBound(false)
		end
	end)

	task.spawn(function()
		for _ = 1, 20 do
			local success, payload = pcall(function()
				return RequestRebirthDataFunc:InvokeServer()
			end)
			if success and payload then
				onRebirthUpdate(payload)
				return
			end
			task.wait(0.5)
		end
	end)

	task.spawn(function()
		local gpId = GameConfig.Gamepasses and GameConfig.Gamepasses.x2Cash and GameConfig.Gamepasses.x2Cash.GamepassId
		if not gpId then return end
		local ok, owns = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gpId)
		end)
		cashGamepassMult = (ok and owns) and 2 or 1
	end)
end

return RebirthController