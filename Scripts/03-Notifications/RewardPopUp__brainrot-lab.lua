-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: StarterPlayer/StarterPlayerScripts/PopUpController.client.luau  (client, 149 lines)
-- Categories: ui-animation 21.8, notifications 17.8, rng-gacha 11.2
-- What it does: "+$123" reward pop-ups at a random spot near screen centre: pop-size + fade in, float up + fade out, with sound; driven by server RemoteEvents.

--!strict
-- LOCATION: StarterPlayerScripts/PopUpController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

-- Modules
local NumberFormatter = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NumberFormatter"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("GUI")

-- Assets
local Templates = ReplicatedStorage:WaitForChild("Templates")
local PopUpTemplate = Templates:WaitForChild("PopUp")
local PopUpPowerTemplate = Templates:WaitForChild("PopUpPower") -- Added Power Template
local Events = ReplicatedStorage:WaitForChild("Events")
local GlobalSounds = Workspace:WaitForChild("Sounds")

-- Config
local TWEEN_INFO_IN = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_INFO_FADE_IN = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_INFO_OUT = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local LIFETIME = 1.5
local SPREAD_X = 0.1 -- 10% screen width spread
local SPREAD_Y = 0.1 -- 10% screen height spread

print("[PopUpController] Loaded")

-- [ LOGIC ]

local function spawnPopUp(amount: number, isPower: boolean)
	-- 1. Clone Correct Template & Get References
	local templateToUse = isPower and PopUpPowerTemplate or PopUpTemplate
	local popUp = templateToUse:Clone() :: Frame

	local textLabel = popUp:FindFirstChild("Text") :: TextLabel
	local imageLabel = popUp:FindFirstChild("Image") :: ImageLabel
	local textStroke = textLabel and textLabel:FindFirstChild("Stroke") :: UIStroke

	if not textLabel then 
		warn("PopUp Template missing 'Text' label")
		popUp:Destroy()
		return 
	end

	-- 2. Setup Data (Cash gets $, Power doesn't)
	if isPower then
		textLabel.Text = "+" .. NumberFormatter.Format(amount)
	else
		textLabel.Text = "+$" .. NumberFormatter.Format(amount)
	end

	-- 3. Position & Initialize State
	local randX = 0.5 + (math.random() * SPREAD_X * 2 - SPREAD_X)
	local randY = 0.5 + (math.random() * SPREAD_Y * 2 - SPREAD_Y)
	local originalSize = templateToUse.Size

	popUp.Position = UDim2.fromScale(randX, randY)
	popUp.Size = UDim2.fromScale(0, 0) -- Start tiny for pop effect
	popUp.Rotation = math.random(-10, 10)

	-- ## TRANSPARENCY SETUP ##
	popUp.BackgroundTransparency = 1 -- Frame stays transparent
	textLabel.TextTransparency = 1
	textLabel.TextStrokeTransparency = 1
	if imageLabel then imageLabel.ImageTransparency = 1 end
	if textStroke then textStroke.Transparency = 1 end

	popUp.Parent = mainGui

	-- 4. Play Sound
	local soundName = isPower and "Power" or "Money" 
	local soundTemplate = GlobalSounds:FindFirstChild(soundName)

	-- Fallback just in case the sound is missing
	if not soundTemplate then
		soundTemplate = GlobalSounds:FindFirstChild(isPower and "Effect" or "Money")
	end

	if soundTemplate and soundTemplate:IsA("Sound") then
		local sound = soundTemplate:Clone()
		sound.Parent = popUp
		sound:Play()
	end

	-- 5. Animate In (Pop Size + Fade In CONTENT ONLY)

	-- Tween size (Pop effect)
	local tweenPopSize = TweenService:Create(popUp, TWEEN_INFO_IN, {Size = originalSize})

	-- Tween content transparencies
	-- Note: We DO NOT tween popUp.BackgroundTransparency, it stays 1
	local tweenFadeText = TweenService:Create(textLabel, TWEEN_INFO_FADE_IN, {TextTransparency = 0, TextStrokeTransparency = 0})
	local tweenFadeImage = imageLabel and TweenService:Create(imageLabel, TWEEN_INFO_FADE_IN, {ImageTransparency = 0})
	local tweenFadeStroke = textStroke and TweenService:Create(textStroke, TWEEN_INFO_FADE_IN, {Transparency = 0})

	tweenPopSize:Play()
	tweenFadeText:Play()
	if tweenFadeImage then tweenFadeImage:Play() end
	if tweenFadeStroke then tweenFadeStroke:Play() end

	-- 6. Float Up & Fade Out
	task.delay(LIFETIME * 0.7, function()
		if not popUp.Parent then return end

		local endPos = popUp.Position - UDim2.fromScale(0, 0.15) -- Move up 15%

		-- Float up frame
		local tweenOutFrame = TweenService:Create(popUp, TWEEN_INFO_OUT, {Position = endPos})

		-- Fade out text elements
		local tweenOutText = TweenService:Create(textLabel, TWEEN_INFO_OUT, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		})

		-- Fade out other elements
		local tweenOutImage = imageLabel and TweenService:Create(imageLabel, TWEEN_INFO_OUT, {ImageTransparency = 1})
		local tweenOutStroke = textStroke and TweenService:Create(textStroke, TWEEN_INFO_OUT, {Transparency = 1})

		tweenOutFrame:Play()
		tweenOutText:Play()
		if tweenOutImage then tweenOutImage:Play() end
		if tweenOutStroke then tweenOutStroke:Play() end

		-- Cleanup
		Debris:AddItem(popUp, TWEEN_INFO_OUT.Time + 0.1)
	end)
end

-- [ EVENT LISTENERS ]
local cashEvent = Events:WaitForChild("ShowCashPopUp")
cashEvent.OnClientEvent:Connect(function(amount)
	spawnPopUp(amount, false)
end)

-- Wait for the server to create the new Power event, then connect to it
task.spawn(function()
	local powerEvent = Events:WaitForChild("ShowPowerPopUp")
	powerEvent.OnClientEvent:Connect(function(amount)
		spawnPopUp(amount, true)
	end)
end)