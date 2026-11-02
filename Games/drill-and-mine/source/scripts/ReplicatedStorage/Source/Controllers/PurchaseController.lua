local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local FireworkModule = require(ReplicatedStorage.Source.Modules.FireworkModule)

local PurchaseController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PurchaseRemotes = Remotes:WaitForChild("PurchaseService")
local PromptPurchaseFunc = PurchaseRemotes:WaitForChild("PromptPurchase")
local PurchaseResultEvent = PurchaseRemotes:WaitForChild("PurchaseResult")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local mainGui = nil
local purchaseFrame = nil
local dotsFrame = nil
local dots = {}

local Sounds = SoundService:WaitForChild("Sounds")
local purchaseClickSound = Sounds:WaitForChild("PurchaseClickSound")
local purchasedSound = Sounds:WaitForChild("PurchasedSound")

local isDotAnimating = false

local function playClickSound()
	if purchaseClickSound then purchaseClickSound:Play() end
end

local function playSuccessSound()
	if purchasedSound then purchasedSound:Play() end
end

local DOT_COUNT = 4
local DOT_WAVE_HEIGHT = 8
local DOT_WAVE_SPEED = 0.4
local DOT_OFFSET = 0.15

local dotOriginalPositions = {}

local function startDotAnimation()
	if isDotAnimating then return end
	isDotAnimating = true

	for i = 1, DOT_COUNT do
		local dot = dots[i]
		if dot and not dotOriginalPositions[i] then
			dotOriginalPositions[i] = dot.Position
		end
	end

	task.spawn(function()
		while isDotAnimating do
			for i = 1, DOT_COUNT do
				local dot = dots[i]
				if not dot then continue end

				local origPos = dotOriginalPositions[i]
				if not origPos then continue end

				local upPos = UDim2.new(
					origPos.X.Scale, origPos.X.Offset,
					origPos.Y.Scale, origPos.Y.Offset - DOT_WAVE_HEIGHT
				)

				local tweenUp = TweenService:Create(dot, TweenInfo.new(
					DOT_WAVE_SPEED * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
					), { Position = upPos })

				local tweenDown = TweenService:Create(dot, TweenInfo.new(
					DOT_WAVE_SPEED * 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In
					), { Position = origPos })

				tweenUp:Play()
				tweenUp.Completed:Once(function()
					if isDotAnimating then
						tweenDown:Play()
					else
						dot.Position = origPos
					end
				end)

				task.wait(DOT_OFFSET)
			end

			task.wait(DOT_WAVE_SPEED + 0.1)
		end
	end)
end

local function stopDotAnimation()
	isDotAnimating = false

	for i = 1, DOT_COUNT do
		local dot = dots[i]
		local origPos = dotOriginalPositions[i]
		if dot and origPos then
			dot.Position = origPos
		end
	end
end

local function showPurchaseFrame()
	if purchaseFrame then
		purchaseFrame.Visible = true
		startDotAnimation()
	end
end

local function hidePurchaseFrame()
	stopDotAnimation()
	if purchaseFrame then
		purchaseFrame.Visible = false
	end
end

local function onPurchaseResult(status, _context)
	if status == "Prompting" then
		playClickSound()
		showPurchaseFrame()
	elseif status == "Success" then
		playSuccessSound()
		FireworkModule.PlayAtPlayer()
		hidePurchaseFrame()
	elseif status == "Cancelled" then
		hidePurchaseFrame()
	end
end

-- TrySkipRebirth is gone: the skip purchase is now started SERVER-side by
-- RebirthService (escalating GameConfig.Rebirth.RobuxLadder product per
-- rebirth) -- RebirthController just invokes RequestSkipRebirth.

function PurchaseController.Init()
	-- MainUI is the legacy ScreenGui — the current game uses `GUI` instead and the
	-- old purchase frame doesn't exist. Used to early-return here, which silently
	-- killed the PurchaseResult listener so success-sound + firework never fired
	-- for any purchase that didn't have an inline playSuccessSound call (Shop
	-- LuckyBlock / Cash / Passes flows). Now: gracefully skip the UI setup when
	-- MainUI is absent and always connect the listener.
	mainGui = playerGui:FindFirstChild("MainUI")
	if mainGui then
		local frames = mainGui:FindFirstChild("Frames")
		if frames then
			purchaseFrame = frames:FindFirstChild("PurchaseFrame")
			if purchaseFrame then
				purchaseFrame.Visible = false

				dotsFrame = purchaseFrame:FindFirstChild("Dots")
				if dotsFrame then
					for i = 1, DOT_COUNT do
						local dot = dotsFrame:FindFirstChild("Dot" .. i)
						if dot then dots[i] = dot end
					end
				end
			end
		end
	end

	PurchaseResultEvent.OnClientEvent:Connect(onPurchaseResult)
end

return PurchaseController