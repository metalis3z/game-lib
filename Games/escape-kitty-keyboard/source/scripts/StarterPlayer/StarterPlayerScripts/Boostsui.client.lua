-- ============================================
-- BOOSTS UI - Wins (🏆) + XP (🚀)
-- LocalScript, dans StarterPlayerScripts
-- Mult + Timer en pilules colorées auto-adaptatives. Côte à côte si les 2 actifs.
-- ============================================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local WinsEventUpdate = Remotes:WaitForChild("WinsEventUpdate")

local BonusUpdate = ReplicatedStorage:WaitForChild("BonusUpdate")
local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================
-- COULEURS
-- ============================
local COLORS = {
	Wins = Color3.fromRGB(255, 195, 60),
	XP = Color3.fromRGB(100, 200, 255),
	text = Color3.fromRGB(20, 20, 25), -- texte sombre sur fond coloré, plus lisible
	textDim = Color3.fromRGB(200, 200, 210),
	warning = Color3.fromRGB(255, 90, 90),
}

-- ============================
-- SCREENGUI + HOLDER (empile les badges côte à côte, même place si un seul actif)
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BoostsUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local holder = Instance.new("Frame")
holder.Name = "BoostsHolder"
holder.AnchorPoint = Vector2.new(1, 1)
holder.Size = UDim2.new(0, 260, 0, 90)
holder.Position = UDim2.new(1, -20, 1, -20)
holder.BackgroundTransparency = 1
holder.Parent = screenGui

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Horizontal
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
listLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
listLayout.Padding = UDim.new(0, 18)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = holder

-- ============================
-- CREATION D'UNE PILULE AUTO-ADAPTATIVE (mult ou timer)
-- ============================
local function createPill(color, layoutOrder, textSize)
	local pill = Instance.new("TextLabel")
	pill.Name = "Pill"
	pill.AutomaticSize = Enum.AutomaticSize.X
	pill.Size = UDim2.new(0, 0, 0, 18)
	pill.BackgroundColor3 = color
	pill.BorderSizePixel = 0
	pill.Font = Enum.Font.GothamBold
	pill.TextSize = textSize
	pill.TextColor3 = COLORS.text
	pill.Text = ""
	pill.LayoutOrder = layoutOrder
	pill.Parent = nil -- assigné par l'appelant

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = pill

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.Parent = pill

	return pill
end

-- ============================
-- CREATION D'UN BADGE (emoji en haut, pilule mult, pilule timer en dessous)
-- ============================
local function createBadge(emoji, color, layoutOrder)
	local badge = Instance.new("Frame")
	badge.Name = "Badge"
	badge.AutomaticSize = Enum.AutomaticSize.X
	badge.Size = UDim2.new(0, 70, 0, 88)
	badge.BackgroundTransparency = 1
	badge.Visible = false
	badge.LayoutOrder = layoutOrder
	badge.Parent = holder

	local innerLayout = Instance.new("UIListLayout")
	innerLayout.FillDirection = Enum.FillDirection.Vertical
	innerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	innerLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	innerLayout.Padding = UDim.new(0, 6)
	innerLayout.SortOrder = Enum.SortOrder.LayoutOrder
	innerLayout.Parent = badge

	-- Emoji, sans fond
	local icon = Instance.new("TextLabel")
	icon.Name = "Icon"
	icon.Size = UDim2.new(0, 40, 0, 40)
	icon.BackgroundTransparency = 1
	icon.Font = Enum.Font.GothamBold
	icon.Text = emoji
	icon.TextScaled = true
	icon.LayoutOrder = 1
	icon.Parent = badge

	local iconConstraint = Instance.new("UITextSizeConstraint")
	iconConstraint.MaxTextSize = 34
	iconConstraint.Parent = icon

	-- Pilule multiplicateur (fond coloré, largeur auto)
	local multBadge = createPill(color, 2, 13)
	multBadge.Text = "x2"
	multBadge.Parent = badge

	-- Pilule timer (même style que le multiplicateur, largeur auto)
	local timerLabel = createPill(color, 3, 12)
	timerLabel.Text = "--:--"
	timerLabel.Parent = badge

	return {
		frame = badge,
		icon = icon,
		multBadge = multBadge,
		timerLabel = timerLabel,
	}
end

local winsBadge = createBadge("\xF0\x9F\x8F\x86", COLORS.Wins, 1) -- 🏆
local xpBadge = createBadge("\xF0\x9F\x9A\x80", COLORS.XP, 2)     -- 🚀

-- ============================
-- LOGIQUE PARTAGEE (timer, animations)
-- ============================
local function formatTime(seconds)
	if seconds == math.huge then
		return "\xE2\x88\x9E" -- symbole infini
	end
	seconds = math.max(0, math.floor(seconds))
	local hours = math.floor(seconds / 3600)
	local mins = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	if hours > 0 then
		return string.format("%d:%02d:%02d", hours, mins, secs)
	else
		return string.format("%02d:%02d", mins, secs)
	end
end

local function makeController(badgeData, color)
	local active = false
	local endTime = 0
	local loopThread = nil

	local function cancelLoop()
		if loopThread then
			pcall(function() task.cancel(loopThread) end)
			loopThread = nil
		end
	end

	local function hide()
		active = false
		cancelLoop()

		TweenService:Create(badgeData.icon, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
		TweenService:Create(badgeData.multBadge, TweenInfo.new(0.2), { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
		TweenService:Create(badgeData.timerLabel, TweenInfo.new(0.2), { BackgroundTransparency = 1, TextTransparency = 1 }):Play()

		task.delay(0.2, function()
			badgeData.frame.Visible = false
			badgeData.icon.TextTransparency = 0
			badgeData.multBadge.BackgroundTransparency = 0
			badgeData.multBadge.TextTransparency = 0
			badgeData.timerLabel.BackgroundTransparency = 0
			badgeData.timerLabel.TextTransparency = 0
		end)
	end

	local function startTimer()
		cancelLoop()
		loopThread = task.spawn(function()
			while active do
				if endTime == math.huge then
					badgeData.timerLabel.Text = formatTime(math.huge)
				else
					local remaining = endTime - os.time()
					if remaining <= 0 then
						hide()
						break
					end
					badgeData.timerLabel.Text = formatTime(remaining)
					if remaining <= 60 then
						badgeData.timerLabel.BackgroundColor3 = COLORS.warning
					else
						badgeData.timerLabel.BackgroundColor3 = color
					end
				end
				task.wait(0.5)
			end
		end)
	end

	local function show(multiplier, newEndTime)
		active = true
		endTime = newEndTime
		badgeData.multBadge.Text = "x" .. tostring(multiplier)
		badgeData.timerLabel.BackgroundColor3 = color

		local wasVisible = badgeData.frame.Visible
		badgeData.frame.Visible = true

		if not wasVisible then
			badgeData.icon.TextTransparency = 1
			badgeData.multBadge.BackgroundTransparency = 1
			badgeData.multBadge.TextTransparency = 1
			badgeData.timerLabel.BackgroundTransparency = 1
			badgeData.timerLabel.TextTransparency = 1

			TweenService:Create(badgeData.icon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
			TweenService:Create(badgeData.multBadge, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
			TweenService:Create(badgeData.timerLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
		end

		startTimer()
	end

	return {
		show = show,
		hide = hide,
		isActive = function() return active end,
	}
end

local winsController = makeController(winsBadge, COLORS.Wins)
local xpController = makeController(xpBadge, COLORS.XP)

-- ============================
-- ECOUTE : WINS (WinsEventUpdate -> {active, multiplier, endTime})
-- ============================
WinsEventUpdate.OnClientEvent:Connect(function(status)
	if status.active then
		local endTime = (status.endTime and status.endTime > 0) and status.endTime or math.huge
		winsController.show(status.multiplier, endTime)
	else
		if winsController.isActive() then
			winsController.hide()
		end
	end
end)

-- ============================
-- ECOUTE : XP (BonusUpdate -> payload.XP = {mult, remaining})
-- ============================
BonusUpdate.OnClientEvent:Connect(function(payload)
	if type(payload) == "table" and payload.XP then
		local mult = payload.XP.mult
		local remaining = payload.XP.remaining

		ClientState:Update({ BonusXPMultiplier = mult })

		local endTime
		if remaining and remaining > 0 then
			endTime = os.time() + remaining
		else
			endTime = math.huge
		end

		xpController.show(mult, endTime)
	else
		ClientState:Update({ BonusXPMultiplier = 1 })
		if xpController.isActive() then
			xpController.hide()
		end
	end
end)