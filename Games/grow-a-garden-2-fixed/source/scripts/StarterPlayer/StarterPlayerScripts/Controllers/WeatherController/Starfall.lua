--credit to leon games studio
local t = {}
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)

local Skybox = require(game.ReplicatedStorage.ClientModules.Skybox)
local StarfallSkybox = game.ReplicatedStorage.Assets.Skybox.StarfallSkybox
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Frame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RainbowEffect"):WaitForChild("Frame")
local Rainbow = SoundService:WaitForChild("MusicTracks"):WaitForChild("Rainbow")
local _ = {
	Color3.fromRGB(255, 80, 80),
	Color3.fromRGB(255, 160, 50),
	Color3.fromRGB(255, 240, 60),
	Color3.fromRGB(80, 220, 80),
	Color3.fromRGB(60, 160, 255),
	Color3.fromRGB(100, 60, 220),
	Color3.fromRGB(180, 80, 220)
}
local v1 = false
local t2 = {}
local v2 = nil
local StarEffect = Instance.new("ColorCorrectionEffect")

StarEffect.Name = "StarEffect"
StarEffect.Brightness = 0
StarEffect.Saturation = 0
StarEffect.Parent = Lighting
Frame.BackgroundTransparency = 1

local function lerpColor(p1, p2, p3) --[[ lerpColor | Line: 73 ]]
	return Color3.new(p1.R + (p2.R - p1.R) * p3, p1.G + (p2.G - p1.G) * p3, p1.B + (p2.B - p1.B) * p3)
end

local function getMaxLoudness() --[[ getMaxLoudness | Line: 81 | Upvalues: Rainbow (copy) ]]
	local v1 = 0

	for v2, v3 in Rainbow:GetChildren() do
		if v3:IsA("Sound") and v3.IsPlaying then
			local v4 = v3.PlaybackLoudness / 1000

			if v1 < v4 then
				v1 = v4
			end
		end
	end

	return v1
end

local function saveLighting() --[[ saveLighting | Line: 98 | Upvalues: t2 (copy), Lighting (copy) ]]
	t2.Brightness = Lighting.Brightness
	t2.Ambient = Lighting.Ambient
	t2.OutdoorAmbient = Lighting.OutdoorAmbient
	t2.ExposureCompensation = Lighting.ExposureCompensation
	t2.ClockTime = Lighting.ClockTime
end

local function applyLighting() --[[ applyLighting | Line: 106 | Upvalues: TweenService (copy), Lighting (copy), StarEffect (copy), Skybox (copy), StarfallSkybox (copy) ]]
	workspace:SetAttribute("TimeFrozen", true)
	TweenService:Create(Lighting, TweenInfo.new(2), {
		ClockTime = 27
	}):Play()
	task.wait(2)

	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		Brightness = 1,
		ExposureCompensation = 0.7,
		EnvironmentDiffuseScale = 1,
		EnvironmentSpecularScale = 1,
		ClockTime = 9.5,
		Ambient = Color3.fromRGB(143, 137, 211),
		OutdoorAmbient = Color3.fromRGB(220, 170, 255)
	}):Play()
	TweenService:Create(game.Workspace.Terrain.Clouds, v1, {
		Cover = 0.56,
		Density = 1,
		Color = Color3.fromRGB(89, 89, 255)
	}):Play()

	local ActiveNightAtmosphere = game.Lighting:FindFirstChild("ActiveNightAtmosphere")

	if not ActiveNightAtmosphere then
		local StarSphere = game.ReplicatedStorage.Assets.NightAtmosphere:Clone()

		StarSphere.Parent = game.Lighting
		StarSphere.Name = "StarSphere"
		ActiveNightAtmosphere = StarSphere
	end

	TweenService:Create(ActiveNightAtmosphere, TweenInfo.new(3), {
		Density = 0.3,
		Haze = 1,
		Color = Color3.fromRGB(0, 179, 199)
	}):Play()
	TweenService:Create(StarEffect, v1, {
		Brightness = 0.05,
		Contrast = 0.1,
		Saturation = 0.1,
		TintColor = Color3.fromRGB(199, 214, 255)
	}):Play()
	Skybox.SetOrder(StarfallSkybox, 3)
end

local function restoreLighting() --[[ restoreLighting | Line: 150 | Upvalues: TweenService (copy), Lighting (copy), t2 (copy), StarEffect (copy), Skybox (copy), StarfallSkybox (copy) ]]
	workspace:SetAttribute("TimeFrozen", nil)

	local v1 = TweenInfo.new(3, Enum.EasingStyle.Sine)

	TweenService:Create(Lighting, v1, {
		EnvironmentDiffuseScale = 0,
		EnvironmentSpecularScale = 0,
		Brightness = t2.Brightness,
		ExposureCompensation = t2.ExposureCompensation,
		Ambient = t2.Ambient,
		OutdoorAmbient = t2.OutdoorAmbient,
		ClockTime = t2.ClockTime
	}):Play()
	TweenService:Create(StarEffect, v1, {
		Brightness = 0,
		Contrast = 0,
		Saturation = 0,
		TintColor = Color3.fromRGB(255, 255, 255)
	}):Play()
	TweenService:Create(game.Workspace.Terrain.Clouds, v1, {
		Cover = 0,
		Density = 0,
		Color = Color3.fromRGB(255, 255, 255)
	}):Play()

	if not game.Lighting:FindFirstChild("StarSphere") then
		Skybox.SetOrder(StarfallSkybox, 0)

		return
	end

	game.Lighting:FindFirstChild("StarSphere"):Destroy()
	Skybox.SetOrder(StarfallSkybox, 0)
end

local function startUpdateLoop() --[[ startUpdateLoop | Line: 182 | Upvalues: v2 (ref) ]] end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 188 | Upvalues: v2 (ref) ]]
	if not v2 then
		return
	end

	v2:Disconnect()
	v2 = nil
end

local function fadeInFrame() --[[ fadeInFrame | Line: 199 | Upvalues: Frame (copy), v2 (ref) ]]
	Frame.BackgroundTransparency = 1
	Frame.Visible = true
end

local function fadeOutFrame() --[[ fadeOutFrame | Line: 206 | Upvalues: v2 (ref), TweenService (copy), Frame (copy) ]]
	if not v2 then
		TweenService:Create(Frame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		}):Play()

		return
	end

	v2:Disconnect()
	v2 = nil
	TweenService:Create(Frame, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play()
end

Networking.WeatherEffects.ShootingStar.OnClientEvent:Connect(function(p1) --[[ Line: 216 | Upvalues: ReplicatedStorage (copy) ]]
	local v1 = ReplicatedStorage.Assets.ShootingStarMeteor:Clone()
	local v2 = CFrame.new(p1) * CFrame.new(0, 200, 250)

	v1.CFrame = v2
	v1.Parent = workspace
	v1.Travel:Play()

	local sum = 0

	while sum < 4 do
		sum = sum + task.wait()

		local v3 = game.TweenService:GetValue(sum / 4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		v1:PivotTo(v2:Lerp(CFrame.new(p1), v3))
		v1.Attachment.BillboardGui.ImageLabel.Rotation = tick() * 90
	end

	v1.Poof:Play()
	v1.Attachment.BillboardGui.Enabled = false

	for v4, v5 in v1.Attachment.Attachment:GetChildren() do
		if v5:IsA("ParticleEmitter") then
			v5:Emit(v5:GetAttribute("EmitCount") or 5)

			continue
		end

		if v5:IsA("PointLight") then
			game.TweenService:Create(v5, TweenInfo.new(3), {
				Range = 0
			}):Play()
		end
	end

	game.Debris:AddItem(v1, 4)
end)

local v3 = game.ReplicatedStorage.Assets.StarfallModel:Clone()

function t.StartWeather() --[[ StartWeather | Line: 259 | Upvalues: v1 (ref), v3 (copy), t2 (copy), Lighting (copy), applyLighting (copy), Frame (copy), v2 (ref) ]]
	if v1 then
		return
	end

	v1 = true

	for v12, v22 in v3:GetDescendants() do
		if v22:IsA("ParticleEmitter") then
			v22.Enabled = true
		end
	end

	v3.Parent = workspace
	t2.Brightness = Lighting.Brightness
	t2.Ambient = Lighting.Ambient
	t2.OutdoorAmbient = Lighting.OutdoorAmbient
	t2.ExposureCompensation = Lighting.ExposureCompensation
	t2.ClockTime = Lighting.ClockTime
	applyLighting()
	Frame.BackgroundTransparency = 1
	Frame.Visible = true
end
function t.EndWeather() --[[ EndWeather | Line: 275 | Upvalues: v1 (ref), v3 (copy), restoreLighting (copy), fadeOutFrame (copy) ]]
	if not v1 then
		return
	end

	v1 = false

	for v12, v2 in v3:GetDescendants() do
		if v2:IsA("ParticleEmitter") then
			v2.Enabled = false
			v2:Clear()
		end
	end

	v3.Parent = script
	restoreLighting()
	fadeOutFrame()
end
workspace:GetAttributeChangedSignal("ShootingStarEvent"):Connect(function() --[[ Line: 291 | Upvalues: t (copy) ]]
	if workspace:GetAttribute("ShootingStarEvent") then
		t.StartWeather()
	else
		t.EndWeather()
	end
end)

return t