--!strict
-- Pattern: ScreenEffects (ModuleScript, client only)
-- Credit: ideas from miami-shootout (flashbanged.lua: full-screen white frame + ear ringing),
-- street-life (hs.lua: blur + ColorCorrection + FOV dip on a headshot) and steal-a-brainrot
-- (JumpscareController: black flash, contrast and depth-of-field tweens).
--
-- What it does:
--   Small, reusable full-screen effects that never stack badly:
--     ScreenEffects.Flash(color, fadeIn, hold, fadeOut, maxOpacity)  -- flashbang / hit flash / fade to black
--     ScreenEffects.Tint(color, strength, duration)                  -- damage vignette-style color pulse
--     ScreenEffects.BlurPulse(size, duration)                        -- blur in and out
--     ScreenEffects.Desaturate(amount, duration)                     -- low-health / death look (pass 0 to clear)
--
-- Usage (LocalScript):
--   local Screen = require(path.to.ScreenEffects)
--   Screen.Flash(Color3.new(1, 1, 1), 0.05, 0.6, 2.5)        -- flashbang
--   Screen.Flash(Color3.new(0, 0, 0), 0.4, 1, 0.4)           -- fade-to-black transition
--   Screen.Tint(Color3.fromRGB(255, 40, 40), 0.35, 0.4)      -- took damage
--   Screen.BlurPulse(16, 0.3)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local ScreenEffects = {}

local player = Players.LocalPlayer
local gui: ScreenGui? = nil
local flashToken = 0
local tintToken = 0
local blurToken = 0

local function getGui(): ScreenGui
	if gui and gui.Parent then
		return gui
	end
	local g = Instance.new("ScreenGui")
	g.Name = "ScreenEffects"
	g.IgnoreGuiInset = true
	g.ResetOnSpawn = false
	g.DisplayOrder = 999
	g.Parent = player:WaitForChild("PlayerGui")
	gui = g
	return g
end

local function getFrame(name: string): Frame
	local g = getGui()
	local frame = g:FindFirstChild(name) :: Frame?
	if not frame then
		local f = Instance.new("Frame")
		f.Name = name
		f.Size = UDim2.fromScale(1, 1)
		f.BorderSizePixel = 0
		f.BackgroundTransparency = 1
		f.Parent = g
		frame = f
	end
	return frame :: Frame
end

local function getLightingEffect(className: string, name: string): any
	local existing = Lighting:FindFirstChild(name)
	if existing then
		return existing
	end
	local effect = Instance.new(className :: any)
	effect.Name = name
	effect.Parent = Lighting
	return effect
end

-- Full-screen color flash. Calling it again while one runs restarts it (no stacking).
function ScreenEffects.Flash(color: Color3, fadeIn: number?, hold: number?, fadeOut: number?, maxOpacity: number?)
	flashToken += 1
	local token = flashToken
	local frame = getFrame("Flash")
	frame.BackgroundColor3 = color
	local target = 1 - (maxOpacity or 1)

	TweenService:Create(frame, TweenInfo.new(fadeIn or 0.05), { BackgroundTransparency = target }):Play()
	task.delay((fadeIn or 0.05) + (hold or 0), function()
		if token ~= flashToken then
			return
		end
		TweenService:Create(frame, TweenInfo.new(fadeOut or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()
	end)
end

-- Quick color pulse using ColorCorrection (looks better than a frame for damage feedback).
function ScreenEffects.Tint(color: Color3, strength: number, duration: number)
	tintToken += 1
	local token = tintToken
	local cc = getLightingEffect("ColorCorrectionEffect", "ScreenEffectsTint") :: ColorCorrectionEffect
	local white = Color3.new(1, 1, 1)
	cc.TintColor = white:Lerp(color, math.clamp(strength, 0, 1))
	cc.Contrast = 0.1 * strength
	local tween = TweenService:Create(cc, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TintColor = white, Contrast = 0 })
	tween.Completed:Once(function()
		if token == tintToken then
			cc.TintColor = white
		end
	end)
	tween:Play()
end

function ScreenEffects.BlurPulse(size: number, duration: number)
	blurToken += 1
	local token = blurToken
	local blur = getLightingEffect("BlurEffect", "ScreenEffectsBlur") :: BlurEffect
	local half = duration / 2
	TweenService:Create(blur, TweenInfo.new(half, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = size }):Play()
	task.delay(half, function()
		if token ~= blurToken then
			return
		end
		TweenService:Create(blur, TweenInfo.new(half, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = 0 }):Play()
	end)
end

-- amount: 0 = normal colors, 1 = black and white
function ScreenEffects.Desaturate(amount: number, duration: number)
	local cc = getLightingEffect("ColorCorrectionEffect", "ScreenEffectsDesaturate") :: ColorCorrectionEffect
	TweenService:Create(cc, TweenInfo.new(duration), { Saturation = -math.clamp(amount, 0, 1) }):Play()
end

return ScreenEffects
