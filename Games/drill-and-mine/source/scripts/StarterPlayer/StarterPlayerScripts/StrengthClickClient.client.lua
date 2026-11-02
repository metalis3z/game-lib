-- StrengthClickClient: world clicks grant (1 + drill Power) * trail boost
-- Strength (see StrengthClickServer); quick floating popup shows that
-- per-click value, UI click sound, level bar pulse on level-up.
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local ContentProvider = game:GetService("ContentProvider")

local plr = Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")
local remote = ReplicatedStorage:WaitForChild("StrengthClickRemote")

local MUSCLE = "rbxassetid://118947473669783"
local FONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)

local LIFETIME = 0.65          -- short: in and gone fast
local RISE = 0.09
local IMG_TRANSPARENCY = 0.3   -- popup is semi-transparent
local TXT_TRANSPARENCY = 0.1

-- same bubble-pop the drill HP tick plays while mining (DrillClient's
-- HP_TICK_SOUND_ID)
local CLICK_SOUND_ID = "rbxassetid://72297116609623"
local CLICK_VOLUME = 0.7
local soundTemplate = Instance.new("Sound")
soundTemplate.SoundId = CLICK_SOUND_ID
soundTemplate.Volume = CLICK_VOLUME
soundTemplate.Parent = SoundService

-- Escalating combo pitch: every pop lands a touch higher than the last,
-- up to a modest cap; pausing PITCH_RESET_AFTER seconds drops it back to
-- the base pitch on the next pop.
local PITCH_BASE = 1.0
local PITCH_STEP = 0.02
local PITCH_MAX = 1.25
local PITCH_RESET_AFTER = 3
local comboPitch = PITCH_BASE
local lastPop = 0

local function playClick()
	local now = os.clock()
	if now - lastPop > PITCH_RESET_AFTER then
		comboPitch = PITCH_BASE
	else
		comboPitch = math.min(comboPitch + PITCH_STEP, PITCH_MAX)
	end
	lastPop = now

	local s = soundTemplate:Clone()
	s.PlaybackSpeed = comboPitch
	s.Parent = SoundService
	s:Play()
	s.Ended:Once(function() s:Destroy() end)
	task.delay(4, function() if s and s.Parent then s:Destroy() end end)
end

-- ===== Level-up FX (client-only) =====
-- Moved from StrengthClickServer: the server used to build the Sound +
-- ParticleEmitter on the character, which replicated the celebration to
-- EVERY player. Now the server fires "levelup" at the leveling player
-- only, and the burst + sound exist purely on this client.
local LEVELUP_SOUND = "rbxassetid://96102213526905"
local PARTICLE_IMAGE = "rbxassetid://96055694784380"

-- Preloaded level-up template: a fresh Sound built at level-up time paid
-- a first-play load hiccup; cloning a preloaded template starts instantly
local levelUpTemplate = Instance.new("Sound")
levelUpTemplate.SoundId = LEVELUP_SOUND
levelUpTemplate.Volume = 0.7
levelUpTemplate.Parent = SoundService
task.spawn(function()
	pcall(function()
		ContentProvider:PreloadAsync({ soundTemplate, levelUpTemplate })
	end)
end)

local function levelUpFX()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- sound, slightly re-pitched every time (preloaded template clone)
	local s = levelUpTemplate:Clone()
	s.PlaybackSpeed = 0.95 + math.random() * 0.18
	s.Parent = SoundService
	s:Play()
	s.Ended:Once(function() s:Destroy() end)
	task.delay(4, function() if s and s.Parent then s:Destroy() end end)

	-- smooth particle burst
	local att = Instance.new("Attachment")
	att.Name = "LevelUpAttachment"
	att.Parent = hrp
	local pe = Instance.new("ParticleEmitter")
	pe.Texture = PARTICLE_IMAGE
	pe.Rate = 0
	pe.Lifetime = NumberRange.new(0.9, 1.5)
	pe.Speed = NumberRange.new(7, 11)
	pe.SpreadAngle = Vector2.new(180, 180)
	pe.Rotation = NumberRange.new(-180, 180)
	pe.RotSpeed = NumberRange.new(-70, 70)
	pe.Drag = 3
	pe.Acceleration = Vector3.new(0, 2, 0)
	pe.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.15, 1.3),
		NumberSequenceKeypoint.new(1, 0.45),
	})
	pe.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.05),
		NumberSequenceKeypoint.new(0.7, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})
	pe.LightEmission = 0.6
	pe.Parent = att
	pe:Emit(28)
	task.delay(3, function() att:Destroy() end)
end

remote.OnClientEvent:Connect(function(action)
	if action == "levelup" then levelUpFX() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "StrengthPopupGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 98
gui:SetAttribute("AT_Ignore", true)   -- keep AnimatedText away from popups
gui.Parent = playerGui

-- 1234567 -> "1.23M": popup numbers reach the billions with late drills.
-- Small values keep one decimal so fractional trail boosts stay visible
-- (+1.2); big ones use the same K/M/B/T suffixes as the layer HP bars.
local AMOUNT_SUFFIXES = { "", "K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td" }
local function formatAmount(n)
	if n < 10 then
		return string.format("%g", math.floor(n * 10 + 0.5) / 10)
	end
	n = math.floor(n + 0.5)
	if n < 1000 then return tostring(n) end
	local mag = math.min(math.floor(math.log10(n) / 3), #AMOUNT_SUFFIXES - 1)
	local scaled = n / 1000 ^ mag
	local s
	if scaled >= 10 then s = string.format("%.1f", scaled) else s = string.format("%.2f", scaled) end
	s = s:gsub("%.?0+$", "")
	return s .. AMOUNT_SUFFIXES[mag + 1]
end

local function spawnPopup(text)
	-- side-biased ring: left/right of the character, never on the vertical
	-- centre line, never over the middle. Pure %, resolution-independent.
	local side = (math.random() < 0.5) and -1 or 1
	local ang = (math.random() - 0.5) * math.rad(120)   -- -60..60 deg from horizontal
	local rx = 0.17 + math.random() * 0.10              -- 0.17 .. 0.27 of width
	local ry = 0.14 + math.random() * 0.09              -- 0.14 .. 0.23 of height
	local x = 0.5 + side * math.cos(ang) * rx
	local y = 0.5 + math.sin(ang) * ry

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.AnchorPoint = Vector2.new(0.5, 0.5)
	holder.Position = UDim2.new(x, 0, y, 0)
	holder.Size = UDim2.new(0.08, 0, 0.08, 0)
	holder.SizeConstraint = Enum.SizeConstraint.RelativeYY
	holder.ZIndex = 50
	holder.Parent = gui

	local scale = Instance.new("UIScale")
	scale.Scale = 0
	scale.Parent = holder

	-- image: bigger, sits under the text
	local img = Instance.new("ImageLabel")
	img.BackgroundTransparency = 1
	img.Image = MUSCLE
	img.ImageTransparency = IMG_TRANSPARENCY
	img.AnchorPoint = Vector2.new(0.5, 0.5)
	img.Position = UDim2.new(0.5, 0, 0.62, 0)
	img.Size = UDim2.new(1.2, 0, 1.2, 0)
	img.Rotation = math.random(-14, 14)
	img.ZIndex = 50
	img.Parent = holder

	-- text: raised above the image
	local txt = Instance.new("TextLabel")
	txt.BackgroundTransparency = 1
	txt.AnchorPoint = Vector2.new(0.5, 0.5)
	txt.Position = UDim2.new(0.5, 0, 0.08, 0)
	txt.Size = UDim2.new(1.15, 0, 0.58, 0)
	txt.FontFace = FONT
	txt.Text = text or "+1"
	txt.TextScaled = true
	txt.TextColor3 = Color3.new(1, 1, 1)
	txt.TextTransparency = TXT_TRANSPARENCY
	txt.ZIndex = 51
	txt.Parent = holder
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Transparency = TXT_TRANSPARENCY
	stroke.Parent = txt

	TweenService:Create(scale, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	TweenService:Create(holder, TweenInfo.new(LIFETIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Position = UDim2.new(x, 0, y - RISE, 0) }):Play()
	TweenService:Create(img, TweenInfo.new(LIFETIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		{ Rotation = img.Rotation + math.random(-8, 8) }):Play()

	task.delay(LIFETIME - 0.22, function()
		local INFO = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		TweenService:Create(img, INFO, { ImageTransparency = 1 }):Play()
		TweenService:Create(txt, INFO, { TextTransparency = 1 }):Play()
		TweenService:Create(stroke, INFO, { Transparency = 1 }):Play()
	end)
	task.delay(LIFETIME + 0.03, function() holder:Destroy() end)
end

-- Training ore pads: the server pushes "gain" every payout tick while the
-- player AFK-drills a pad; reuse the click popup with the granted amount.
task.spawn(function()
	local padRemote = ReplicatedStorage:WaitForChild("TrainingPadRemote")
	padRemote.OnClientEvent:Connect(function(action, amount)
		if action == "gain" and type(amount) == "number" then
			spawnPopup("+" .. formatAmount(amount))
		end
	end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if plr:GetAttribute("Underground") then return end -- no strength clicks in the zones
	if plr:GetAttribute("OnTrainingPad") then return end -- pad is already granting strength
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		remote:FireServer()
		playClick()
		-- mirror the server's per-click formula: (1 + drill Power) * trail
		-- boost * rebirth StrengthMultiplier * strength ladder multiplier
		-- (attributes mirrored by their services), so the popup shows what
		-- the click is worth
		local boost = math.max(tonumber(plr:GetAttribute("TrailBoost")) or 1, 1)
		local power = math.max(tonumber(plr:GetAttribute("DrillPower")) or 0, 0)
		local rebirthMult = math.max(tonumber(plr:GetAttribute("StrengthMultiplier")) or 1, 1)
		local passMult = math.max(tonumber(plr:GetAttribute("StrengthLadderMult")) or 1, 1)
		spawnPopup("+" .. formatAmount((1 + power) * boost * rebirthMult * passMult))
	end
end)

-- The level-bar pulse now lives in LevelBarController, which pops the WHOLE bar
-- (bar + text + shadow, as one rigid unit) on every Strength gain -- so world
-- clicks and AFK training-pad payouts both animate it, not just level-ups.
