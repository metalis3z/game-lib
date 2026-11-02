--credit to leon games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local EffectLoadManager = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("EffectLoadManager"))
local Frame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RainbowEffect"):WaitForChild("Frame")
local Rainbow = SoundService:WaitForChild("MusicTracks"):WaitForChild("Rainbow")
local t2 = {
	Color3.fromRGB(255, 80, 80),
	Color3.fromRGB(255, 160, 50),
	Color3.fromRGB(255, 240, 60),
	Color3.fromRGB(80, 220, 80),
	Color3.fromRGB(60, 160, 255),
	Color3.fromRGB(100, 60, 220),
	Color3.fromRGB(180, 80, 220)
}
local v1 = false
local t3 = {}
local v2 = nil
local v3 = nil
local v4 = 1
local v5 = 0
local v6 = 1
local v7 = 0
local RainbowEffect = Instance.new("ColorCorrectionEffect")

RainbowEffect.Name = "RainbowEffect"
RainbowEffect.Brightness = 0
RainbowEffect.Saturation = 0
RainbowEffect.Parent = Lighting
Frame.BackgroundTransparency = 1

local function lerpColor(p1, p2, p3) --[[ lerpColor | Line: 75 ]]
	return Color3.new(p1.R + (p2.R - p1.R) * p3, p1.G + (p2.G - p1.G) * p3, p1.B + (p2.B - p1.B) * p3)
end

local t4 = {}

local function refreshSoundCache() --[[ refreshSoundCache | Line: 88 | Upvalues: t4 (copy), Rainbow (copy) ]]
	table.clear(t4)

	for v1, v2 in Rainbow:GetChildren() do
		if v2:IsA("Sound") then
			table.insert(t4, v2)
		end
	end
end

Rainbow.ChildAdded:Connect(refreshSoundCache)
Rainbow.ChildRemoved:Connect(refreshSoundCache)
refreshSoundCache()

local function getMaxLoudness() --[[ getMaxLoudness | Line: 101 | Upvalues: t4 (copy) ]]
	local v1 = 0

	for v2, v3 in t4 do
		if v3.IsPlaying then
			local v4 = v3.PlaybackLoudness / 1000

			if v1 < v4 then
				v1 = v4
			end
		end
	end

	return v1
end

local function saveLighting() --[[ saveLighting | Line: 118 | Upvalues: t3 (copy), Lighting (copy) ]]
	t3.Brightness = Lighting.Brightness
	t3.Ambient = Lighting.Ambient
	t3.OutdoorAmbient = Lighting.OutdoorAmbient
	t3.ExposureCompensation = Lighting.ExposureCompensation
end

local function applyRainbowLighting() --[[ applyRainbowLighting | Line: 125 | Upvalues: TweenService (copy), Lighting (copy), t3 (copy), RainbowEffect (copy) ]]
	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		Brightness = t3.Brightness + 0.3,
		ExposureCompensation = t3.ExposureCompensation + 0.15
	}):Play()
	TweenService:Create(RainbowEffect, v1, {
		Brightness = 0.12,
		Saturation = 0.15
	}):Play()
end

local function restoreLighting() --[[ restoreLighting | Line: 137 | Upvalues: TweenService (copy), Lighting (copy), t3 (copy), RainbowEffect (copy) ]]
	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		Brightness = t3.Brightness,
		ExposureCompensation = t3.ExposureCompensation
	}):Play()
	TweenService:Create(RainbowEffect, v1, {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0
	}):Play()
end

local function spawnRainbowModel() --[[ spawnRainbowModel | Line: 154 | Upvalues: ReplicatedStorage (copy), v2 (ref), TweenService (copy) ]]
	local Rainbow = ReplicatedStorage.Assets:FindFirstChild("Rainbow")

	if not Rainbow then
		warn("[Rainbow] Rainbow model not found in ReplicatedStorage.Assets")

		return
	end

	v2 = Rainbow:Clone()
	v2.Name = "ActiveRainbow"
	v2.Parent = workspace

	local t = {}

	for v1, v22 in v2:GetDescendants() do
		if v22:IsA("BasePart") then
			if v22:GetAttribute("OGTransparency") == nil then
				v22:SetAttribute("OGTransparency", v22.Transparency)
			end

			v22.Transparency = 1
			table.insert(t, v22)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	for v4, v5 in t do
		task.delay(v4 * 0.05, function() --[[ Line: 178 | Upvalues: TweenService (ref), v5 (copy), v3 (copy) ]]
			TweenService:Create(v5, v3, {
				Transparency = v5:GetAttribute("OGTransparency")
			}):Play()
		end)
	end
end

local function removeRainbowModel() --[[ removeRainbowModel | Line: 184 | Upvalues: v2 (ref), TweenService (copy) ]]
	if not v2 then
		return
	end

	local t = {}

	for v1, v22 in v2:GetDescendants() do
		if v22:IsA("BasePart") then
			table.insert(t, v22)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

	for v4, v5 in t do
		TweenService:Create(v5, v3, {
			Transparency = 1
		}):Play()
	end

	local v6 = v2

	task.delay(2.1, function() --[[ Line: 200 | Upvalues: v6 (copy) ]]
		if not (v6 and v6.Parent) then
			return
		end

		v6:Destroy()
	end)
	v2 = nil
end

local function tickRainbow(p1) --[[ tickRainbow | Line: 214 | Upvalues: v5 (ref), t2 (copy), v4 (ref), Frame (copy), t4 (copy), v6 (ref) ]]
	v5 = v5 + p1

	local v2 = math.clamp(v5 / 2, 0, 1)
	local v3 = t2[v4]
	local v42 = v4 % #t2 + 1
	local v52 = t2[v42]

	Frame.BackgroundColor3 = Color3.new(v3.R + (v52.R - v3.R) * v2, v3.G + (v52.G - v3.G) * v2, v3.B + (v52.B - v3.B) * v2)

	if v2 >= 1 then
		v4 = v42
		v5 = 0
	end

	local v62 = 0

	for v7, v8 in t4 do
		if v8.IsPlaying then
			local v9 = v8.PlaybackLoudness / 1000

			if v62 < v9 then
				v62 = v9
			end
		end
	end

	v6 = if v62 >= 0.12 then math.clamp((v62 - 0.12) / 0.88, 0, 1) * -0.7 + 0.95 else 0.95

	local BackgroundTransparency = Frame.BackgroundTransparency

	Frame.BackgroundTransparency = BackgroundTransparency + (v6 - BackgroundTransparency) * math.min(1, p1 * 8)
end

local function startUpdateLoop() --[[ startUpdateLoop | Line: 244 | Upvalues: v3 (ref), v4 (ref), v5 (ref), v7 (ref), v6 (ref), RunService (copy), EffectLoadManager (copy), tickRainbow (copy) ]]
	if not v3 then
		v4 = 1
		v5 = 0
		v7 = 0
		v6 = 0.95
		v3 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 252 | Upvalues: v7 (ref), EffectLoadManager (ref), tickRainbow (ref) ]]
			v7 = v7 + p1

			if not (v7 < EffectLoadManager.GetTickInterval()) then
				debug.profilebegin("Controllers/WeatherController/Rainbow/Tick")
				tickRainbow(v7)
				v7 = 0
				debug.profileend()
			end
		end)
	end
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 267 | Upvalues: v3 (ref) ]]
	if not v3 then
		return
	end

	v3:Disconnect()
	v3 = nil
end

local function fadeInFrame() --[[ fadeInFrame | Line: 278 | Upvalues: Frame (copy), v3 (ref), v4 (ref), v5 (ref), v7 (ref), v6 (ref), RunService (copy), EffectLoadManager (copy), tickRainbow (copy) ]]
	Frame.BackgroundTransparency = 1
	Frame.Visible = true

	if not v3 then
		v4 = 1
		v5 = 0
		v7 = 0
		v6 = 0.95
		v3 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 252 | Upvalues: v7 (ref), EffectLoadManager (ref), tickRainbow (ref) ]]
			v7 = v7 + p1

			if not (v7 < EffectLoadManager.GetTickInterval()) then
				debug.profilebegin("Controllers/WeatherController/Rainbow/Tick")
				tickRainbow(v7)
				v7 = 0
				debug.profileend()
			end
		end)
	end
end

local function fadeOutFrame() --[[ fadeOutFrame | Line: 285 | Upvalues: v3 (ref), TweenService (copy), Frame (copy) ]]
	if not v3 then
		TweenService:Create(Frame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		}):Play()

		return
	end

	v3:Disconnect()
	v3 = nil
	TweenService:Create(Frame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play()
end

function t.StartWeather() --[[ StartWeather | Line: 295 | Upvalues: v1 (ref), EffectLoadManager (copy), NotificationController (copy), t3 (copy), Lighting (copy), applyRainbowLighting (copy), spawnRainbowModel (copy), Frame (copy), v3 (ref), v4 (ref), v5 (ref), v7 (ref), v6 (ref), RunService (copy), tickRainbow (copy) ]]
	if v1 then
		return
	end

	v1 = true
	EffectLoadManager.Register()
	NotificationController:CreateNotification("You received a rainbow magic carpet!\240\159\140\136")
	t3.Brightness = Lighting.Brightness
	t3.Ambient = Lighting.Ambient
	t3.OutdoorAmbient = Lighting.OutdoorAmbient
	t3.ExposureCompensation = Lighting.ExposureCompensation
	applyRainbowLighting()
	spawnRainbowModel()
	Frame.BackgroundTransparency = 1
	Frame.Visible = true

	if not v3 then
		v4 = 1
		v5 = 0
		v7 = 0
		v6 = 0.95
		v3 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 252 | Upvalues: v7 (ref), EffectLoadManager (ref), tickRainbow (ref) ]]
			v7 = v7 + p1

			if not (v7 < EffectLoadManager.GetTickInterval()) then
				debug.profilebegin("Controllers/WeatherController/Rainbow/Tick")
				tickRainbow(v7)
				v7 = 0
				debug.profileend()
			end
		end)
	end
end
function t.EndWeather() --[[ EndWeather | Line: 306 | Upvalues: v1 (ref), EffectLoadManager (copy), restoreLighting (copy), removeRainbowModel (copy), fadeOutFrame (copy) ]]
	if v1 then
		v1 = false
		EffectLoadManager.Unregister()
		restoreLighting()
		removeRainbowModel()
		fadeOutFrame()
	end
end
Networking.WeatherEffects.RainbowStart.OnClientEvent:Connect(function() --[[ Line: 320 | Upvalues: t (copy) ]]
	t.StartWeather()
end)
Networking.WeatherEffects.RainbowEnd.OnClientEvent:Connect(function() --[[ Line: 324 | Upvalues: t (copy) ]]
	t.EndWeather()
end)

return t