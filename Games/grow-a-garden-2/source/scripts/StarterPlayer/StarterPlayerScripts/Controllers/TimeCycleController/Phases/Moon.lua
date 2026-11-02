--credit to leon games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)

require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)

local LocalPlayer = game.Players.LocalPlayer
local t2 = {
	Brightness = 3,
	ClockTime = 3.1,
	Ambient = Color3.new(0.823529, 0.823529, 0.823529),
	ColorShift_Bottom = Color3.new(0.160784, 0.196078, 0.670588),
	ColorShift_Top = Color3.new(0.603922, 0.8, 0.980392),
	OutdoorAmbient = Color3.new(0.34902, 0.419608, 0.4)
}
local v1 = nil
local v2 = false
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = game.SoundService.SFX["Werewolf Howl"]

local function getTargetDensity() --[[ getTargetDensity | Line: 36 | Upvalues: LocalPlayer (copy) ]]
	local v1 = if LocalPlayer:GetAttribute("IsInOwnGarden") then 0.4 else 0.56
	local FogDensityClear = LocalPlayer:FindFirstChild("FogDensityClear")
	local v2 = LocalPlayer:FindFirstChild("FogDensityClear") and FogDensityClear.Value or 0
	local OwlNightVisionMult = LocalPlayer:FindFirstChild("OwlNightVisionMult")
	local v3 = LocalPlayer:FindFirstChild("OwlNightVisionMult") and OwlNightVisionMult.Value or 1

	if v3 <= 0 then
		v3 = 1
	end

	return math.clamp((v1 - v2) / v3, 0, 1)
end

local function tweenAtmosphereDensity(p1, p2, p3) --[[ tweenAtmosphereDensity | Line: 55 | Upvalues: v3 (ref), v8 (ref), TweenService (copy) ]]
	if not v3 then
		return
	end

	if v8 then
		v8:Cancel()
		v8:Destroy()
		v8 = nil
	end

	local v1 = TweenService:Create(v3, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Density = p1
	})

	v8 = v1

	if p3 then
		v1.Completed:Once(function(p1) --[[ Line: 70 | Upvalues: v8 (ref), v1 (copy), p3 (copy) ]]
			if v8 == v1 then
				v8 = nil
			end

			v1:Destroy()
			p3()
		end)
	else
		v1.Completed:Once(function() --[[ Line: 78 | Upvalues: v8 (ref), v1 (copy) ]]
			if v8 == v1 then
				v8 = nil
			end

			v1:Destroy()
		end)
	end

	v1:Play()
end

local function isCutscenePlaying() --[[ isCutscenePlaying | Line: 89 | Upvalues: LocalPlayer (copy) ]]
	return LocalPlayer:GetAttribute("OfflineCutscenePlaying") == true
end

local function refreshDensity() --[[ refreshDensity | Line: 93 | Upvalues: v2 (ref), v3 (ref), LocalPlayer (copy), tweenAtmosphereDensity (copy), getTargetDensity (copy) ]]
	if not v2 then
		return
	end

	if not v3 then
		return
	end

	if LocalPlayer:GetAttribute("OfflineCutscenePlaying") == true then
		tweenAtmosphereDensity(0, 0.5)
	else
		tweenAtmosphereDensity(getTargetDensity(), 1.5)
	end
end

local function applyAtmosphere() --[[ applyAtmosphere | Line: 106 | Upvalues: ReplicatedStorage (copy), v3 (ref), Lighting (copy), LocalPlayer (copy), tweenAtmosphereDensity (copy), getTargetDensity (copy) ]]
	local NightAtmosphere = ReplicatedStorage.Assets:FindFirstChild("NightAtmosphere")

	if not NightAtmosphere then
		return
	end

	if not v3 then
		v3 = NightAtmosphere:Clone()
		v3.Name = "ActiveNightAtmosphere"
		v3.Density = 0
		v3.Parent = Lighting
	end

	if LocalPlayer:GetAttribute("OfflineCutscenePlaying") == true then
		tweenAtmosphereDensity(0, 0.5)
	else
		tweenAtmosphereDensity(getTargetDensity(), 1.5)
	end
end

local function removeAtmosphere() --[[ removeAtmosphere | Line: 130 | Upvalues: v3 (ref), tweenAtmosphereDensity (copy) ]]
	if v3 then
		tweenAtmosphereDensity(0, 2, function() --[[ Line: 132 | Upvalues: v3 (ref) ]]
			if not v3 then
				return
			end

			v3:Destroy()
			v3 = nil
		end)
	end
end

TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

local function spawnNightModel() --[[ spawnNightModel | Line: 142 | Upvalues: ReplicatedStorage (copy), v1 (ref), TweenService (copy), Debris (copy) ]]
	local Night = ReplicatedStorage.Assets:FindFirstChild("Night")

	if not Night then
		return
	end

	v1 = Night:Clone()
	v1.Name = "ActiveNight"
	v1.Parent = workspace

	local t = {}

	for v12, v2 in v1:GetDescendants() do
		if v2:IsA("BasePart") then
			if v2:GetAttribute("OGTransparency") == nil then
				v2:SetAttribute("OGTransparency", v2.Transparency)
			end

			v2.Transparency = 1
			table.insert(t, v2)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	for v4, v5 in t do
		task.delay(v4 * 0.05, function() --[[ Line: 165 | Upvalues: TweenService (ref), v5 (copy), v3 (copy), Debris (ref) ]]
			local v1 = TweenService:Create(v5, v3, {
				Transparency = v5:GetAttribute("OGTransparency")
			})

			v1:Play()
			Debris:AddItem(v1, v3.Time)
		end)
	end
end

local function removeNightModel() --[[ removeNightModel | Line: 174 | Upvalues: v1 (ref), TweenService (copy), Debris (copy) ]]
	if not v1 then
		return
	end

	local t = {}

	for v12, v2 in v1:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, v2)
		end
	end

	local v3 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)

	for v4, v5 in t do
		local v6 = TweenService:Create(v5, v3, {
			Transparency = 1
		})

		v6:Play()
		Debris:AddItem(v6, v3.Time)
	end

	local v7 = v1

	task.delay(2.1, function() --[[ Line: 193 | Upvalues: v7 (copy) ]]
		if not (v7 and v7.Parent) then
			return
		end

		v7:Destroy()
	end)
	v1 = nil
end

function t.Start(p1, p2, p3) --[[ Start | Line: 201 | Upvalues: v2 (ref), v9 (copy), LightingController (copy), t2 (copy), spawnNightModel (copy), applyAtmosphere (copy), v4 (ref), LocalPlayer (copy), refreshDensity (copy), v5 (ref), v6 (ref), v7 (ref) ]]
	v2 = true
	v9.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	v9.Playing = true
	v9.TimePosition = 0
	LightingController:TransitionTo(t2)
	spawnNightModel()
	applyAtmosphere()
	v4 = LocalPlayer:GetAttributeChangedSignal("IsInOwnGarden"):Connect(refreshDensity)

	local FogDensityClear = LocalPlayer:FindFirstChild("FogDensityClear")

	if FogDensityClear then
		v5 = FogDensityClear.Changed:Connect(refreshDensity)
	end

	local OwlNightVisionMult = LocalPlayer:FindFirstChild("OwlNightVisionMult")

	if OwlNightVisionMult then
		v6 = OwlNightVisionMult.Changed:Connect(refreshDensity)
	end

	v7 = LocalPlayer:GetAttributeChangedSignal("OfflineCutscenePlaying"):Connect(refreshDensity)
end
function t.End(p1) --[[ End | Line: 231 | Upvalues: v2 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), removeNightModel (copy), v3 (ref), tweenAtmosphereDensity (copy) ]]
	v2 = false

	if v4 then
		v4:Disconnect()
		v4 = nil
	end

	if v5 then
		v5:Disconnect()
		v5 = nil
	end

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	if v7 then
		v7:Disconnect()
		v7 = nil
	end

	removeNightModel()

	if v3 then
		tweenAtmosphereDensity(0, 2, function() --[[ Line: 132 | Upvalues: v3 (ref) ]]
			if not v3 then
				return
			end

			v3:Destroy()
			v3 = nil
		end)
	end
end

return t