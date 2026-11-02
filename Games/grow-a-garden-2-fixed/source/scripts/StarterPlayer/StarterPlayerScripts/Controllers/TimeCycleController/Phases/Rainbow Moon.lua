--credit to prince games studio
local t = {}

game:GetService("Lighting")

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Players = game:GetService("Players")

game:GetService("SoundService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local CamShake = require(ReplicatedStorage.ClientModules.CamShake)
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local RainbowMoon = ReplicatedStorage.Assets:WaitForChild("RainbowMoon")
local Skybox = require(game.ReplicatedStorage.ClientModules.Skybox)
-- RainbowMoon (Sky) no está en este dump (asset privado); fallback a Goldmoon para no romper.
local RainbowMoon2 = game.ReplicatedStorage.Assets.Skybox:FindFirstChild("RainbowMoon")
	or game.ReplicatedStorage.Assets.Skybox:FindFirstChild("Goldmoon")

local function lerp(p1, p2, p3) --[[ lerp | Line: 32 ]]
	return p1 + (p2 - p1) * p3
end

local t2 = {
	Brightness = 4,
	EnvironmentDiffuseScale = 1,
	ClockTime = 23,
	Ambient = Color3.fromRGB(197, 36, 241),
	ColorShift_Bottom = Color3.fromRGB(74, 171, 110),
	ColorShift_Top = Color3.fromRGB(125, 63, 250),
	OutdoorAmbient = Color3.fromRGB(74, 139, 180)
}

local function ScaleModelTo(p1, p2, p3, p4, p5) --[[ ScaleModelTo | Line: 46 | Upvalues: TweenService (copy) ]]
	local v1 = p1:GetScale()
	local sum, v4, v5 = 0, if p4 then p4 else Enum.EasingStyle.Linear, if p5 then p5 else Enum.EasingDirection.InOut

	while sum < p3 do
		sum = sum + task.wait(0)
		p1:ScaleTo(v1 + (p2 - v1) * TweenService:GetValue(math.clamp(sum / p3, 0.01, 1), v4, v5))
	end
end

local v1 = nil

task.spawn(function() --[[ Line: 74 ]]
	while true do
		task.wait(0.025)

		local v1 = tick() / 2 % 1
		local v2 = Color3.fromHSV(v1, 1, 1)

		for v3, v4 in game.CollectionService:GetTagged("RainbowTween") do
			if v4:IsA("Highlight") then
				local v5 = if v4:HasTag("Multiplier") then 1.5 else 1

				v4.FillColor = Color3.fromHSV(v1 * v5, 1 * v5, 1 * v5)

				continue
			end

			if v4:IsA("ImageLabel") then
				v4.ImageColor3 = v2

				continue
			end

			v4.Color = v2
		end
	end
end)

local function newCharacter(p1) --[[ newCharacter | Line: 101 | Upvalues: ReplicatedStorage (copy), Players (copy), v1 (ref), LocalPlayer (copy), FieldOfViewController (copy), NotificationController (copy) ]]
	if p1:GetAttribute("Rainbow") then
		return
	end

	p1:SetAttribute("Rainbow", true)

	for v12, v2 in ReplicatedStorage.Assets.RainbowEffect:GetChildren() do
		local v3 = v2:Clone()

		if v3:IsA("Highlight") then
			v3.Parent = p1
			v3:AddTag("Multiplier")
			v3:AddTag("RainbowTween")
		else
			v3.Parent = p1:WaitForChild("Torso")
		end

		v3:AddTag("ClearUpRainbow")
	end

	if p1 ~= Players.LocalPlayer.Character or v1 then
		return
	end

	v1 = ReplicatedStorage.Assets.Vignette:Clone()
	v1.ImageLabel.ImageTransparency = 0.7
	v1.ImageLabel.UIScale.Scale = 1
	v1.ImageLabel:AddTag("RainbowTween")
	game.TweenService:Create(v1.ImageLabel.UIScale, TweenInfo.new(1), {
		Scale = 1.04
	}):Play()
	game.TweenService:Create(v1.ImageLabel, TweenInfo.new(1), {
		ImageTransparency = 0.8
	}):Play()
	v1.Parent = LocalPlayer.PlayerGui

	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Parent = game.Lighting
	game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
		Brightness = 0.4,
		TintColor = Color3.fromRGB(235, 175, 255)
	}):Play()
	game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
		FieldOfView = 90
	}):Play()
	task.delay(0.4, function() --[[ Line: 141 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
		game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.8), {
			Brightness = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play()
		game.Debris:AddItem(ColorCorrectionEffect, 0.8)
		game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.6), {
			FieldOfView = 80
		}):Play()
		FieldOfViewController:SetBaseFOV(80)
	end)

	local function Color(p1, p2) --[[ Color | Line: 150 ]]
		return "<font color=\"#" .. p2:ToHex() .. "\">" .. p1 .. "</font>"
	end

	local function EvaluateColorSequence(p1, p2) --[[ EvaluateColorSequence | Line: 155 ]]
		local Keypoints = p1.Keypoints

		if p2 <= Keypoints[1].Time then
			return Keypoints[1].Value
		end

		if Keypoints[#Keypoints].Time <= p2 then
			return Keypoints[#Keypoints].Value
		end

		for i = 1, #Keypoints - 1 do
			local v1 = Keypoints[i]
			local v2 = Keypoints[i + 1]

			if v1.Time <= p2 and p2 <= v2.Time then
				return v1.Value:lerp(v2.Value, (p2 - v1.Time) / (v2.Time - v1.Time))
			end
		end

		return Keypoints[#Keypoints].Value
	end

	local function Gradient(p1, p2) --[[ Gradient | Line: 177 | Upvalues: EvaluateColorSequence (copy) ]]
		local Color = p1.Color
		local v1 = #p2
		local t = {}

		for i = 1, v1 do
			local v2 = EvaluateColorSequence(Color, (i - 1) / math.max(v1 - 1, 1))
			local v3 = string.sub(p2, i, i)
			local format = string.format

			table.insert(t, format("<font color=\"#%s\">%s</font>", v2:ToHex(), v3))
		end

		return table.concat(t)
	end

	NotificationController:CreateNotification("You are " .. ("<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">STAR-POWERED!</font>") .. " Steal QUICK to get a " .. Gradient(game.ReplicatedStorage.Assets.RainbowGradient, "RAINBOW") .. " plant!", nil, 7)
end

local function clearupCharacter(p1) --[[ clearupCharacter | Line: 208 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), v1 (ref), FieldOfViewController (copy) ]]
	local v12 = ReplicatedStorage.Assets.RainbowDisperse:Clone()

	v12.Parent = p1.HumanoidRootPart

	for v2, v3 in v12:GetChildren() do
		if v3:IsA("ParticleEmitter") then
			v3:Emit(v3:GetAttribute("EmitCount") or 3)

			continue
		end

		if v3:IsA("Sound") then
			v3:Play()
		end
	end

	if p1 == LocalPlayer.Character and v1 then
		game.TweenService:Create(v1.ImageLabel.UIScale, TweenInfo.new(1), {
			Scale = 1.14
		}):Play()
		game.TweenService:Create(v1.ImageLabel, TweenInfo.new(1), {
			ImageTransparency = 1
		}):Play()
		FieldOfViewController:SetBaseFOV(70)
		game.Debris:AddItem(v1, 1)
		v1 = nil
	end

	game.Debris:AddItem(v12, 3)
	p1:SetAttribute("Rainbow", nil)

	for v4, v5 in p1:GetDescendants() do
		if v5:HasTag("ClearUpRainbow") then
			if v5:IsA("Highlight") then
				game.TweenService:Create(v5, TweenInfo.new(0.5), {
					FillTransparency = 1,
					OutlineTransparency = 1
				}):Play()
			elseif v5:IsA("ParticleEmitter") or v5:IsA("Trail") then
				v5.Enabled = false
			end

			game.Debris:AddItem(v5, 1)
		end
	end
end

for v2, v3 in game.CollectionService:GetTagged("RainbowHighlight") do
	newCharacter(v3)
end

game.CollectionService:GetInstanceAddedSignal("RainbowHighlight"):Connect(newCharacter)
game.CollectionService:GetInstanceRemovedSignal("RainbowHighlight"):Connect(clearupCharacter)
Networking.WeatherEffects.RainbowMoonStrike.OnClientEvent:Connect(function(p1) --[[ Line: 259 | Upvalues: ReplicatedStorage (copy) ]]
	local v1 = ReplicatedStorage.Assets.RainbowMeteor:Clone()
	local v2 = CFrame.new(p1) * CFrame.new(0, 200, 250)

	v1.CFrame = v2
	v1.Parent = workspace
	v1.Travel:Play()

	local sum = 0

	while sum < 2 do
		sum = sum + task.wait(0.025)

		local v3 = game.TweenService:GetValue(sum / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		v1:PivotTo(v2:Lerp(CFrame.new(p1), v3))
		v1.Attachment.BillboardGui.ImageLabel.Rotation = tick() * 720 % 360
		v1.Attachment.BillboardGui.ImageLabel.ImageColor3 = Color3.fromHSV(tick() % 1, 1, 1)
	end

	v1.Poof:Play()
	v1.Attachment.BillboardGui.Enabled = false

	for v4, v5 in v1.Attachment.Attachment:GetChildren() do
		v5:Emit(v5:GetAttribute("EmitCount") or 5)
	end

	game.Debris:AddItem(v1, 4)
end)

local function startUpdateLoop() --[[ startUpdateLoop | Line: 295 | Upvalues: Skybox (copy), RainbowMoon2 (copy), TweenService (copy), CamShake (copy), RainbowMoon (copy), ScaleModelTo (copy) ]]
	game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
		Cover = 0
	}):Play()
	task.delay(1, function() --[[ Line: 299 | Upvalues: Skybox (ref), RainbowMoon2 (ref) ]]
		Skybox.SetOrder(RainbowMoon2, 2)
	end)
	task.delay(3, function() --[[ Line: 303 | Upvalues: TweenService (ref), CamShake (ref), RainbowMoon (ref), ScaleModelTo (ref) ]]
		local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

		ColorCorrectionEffect.Parent = game.Lighting
		game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
			FieldOfView = 95
		}):Play()
		TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
			Brightness = 1.5,
			Contrast = 0.2,
			Saturation = 0.5,
			TintColor = Color3.fromRGB(243, 153, 255)
		}):Play()
		CamShake:Shake(CamShake.Presets.Explosion)

		local v1 = game.ReplicatedStorage.Assets.RainbowScreenEffect:Clone()
		local v2 = true

		v1.Parent = workspace.Camera
		task.spawn(function() --[[ Line: 320 | Upvalues: v2 (ref), v1 (copy) ]]
			while v2 do
				v1.Size = Vector3.new(math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8 / (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y), 0.1, 2.2)
				v1.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -4)
				game:GetService("RunService").RenderStepped:Wait()
			end
		end)

		for v3, v4 in v1:GetChildren() do
			v4:Emit(v4:GetAttribute("EmitCount"))
		end

		game.SoundService:PlayLocalSound(game.SoundService.SFX.RainbowPoof)
		task.delay(8, function() --[[ Line: 339 | Upvalues: v2 (ref) ]]
			v2 = false
		end)
		game.Debris:AddItem(v1, 8)
		task.delay(0.4, function() --[[ Line: 346 | Upvalues: RainbowMoon (ref), TweenService (ref), ColorCorrectionEffect (copy), ScaleModelTo (ref) ]]
			local v1 = RainbowMoon.beams.CFrame

			RainbowMoon.beams.CFrame = CFrame.new(0, -5, 0) * v1
			RainbowMoon.Parent = workspace
			TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2), {
				Brightness = 0,
				Contrast = 0,
				Saturation = 0,
				TintColor = Color3.fromRGB(255, 255, 255)
			}):Play()
			game.TweenService:Create(RainbowMoon.beams, TweenInfo.new(0.4), {
				CFrame = v1
			}):Play()
			game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
				FieldOfView = 70
			}):Play()
			task.wait(2)
			game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
				FieldOfView = 70
			}):Play()
			TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
				Brightness = 0.6,
				Contrast = 0,
				Saturation = 0.2,
				TintColor = Color3.fromRGB(243, 153, 255)
			}):Play()
			task.delay(0.3, function() --[[ Line: 362 | Upvalues: TweenService (ref), ColorCorrectionEffect (ref) ]]
				game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
					FieldOfView = 70
				}):Play()
				TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2), {
					Brightness = 0,
					Contrast = 0,
					Saturation = 0,
					TintColor = Color3.fromRGB(255, 255, 255)
				}):Play()
			end)
			ScaleModelTo(RainbowMoon.MoonModel, 1, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		end)
	end)
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 373 | Upvalues: TweenService (copy), CamShake (copy), RainbowMoon (copy), ReplicatedStorage (copy), Skybox (copy), RainbowMoon2 (copy) ]]
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Parent = game.Lighting
	game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
		FieldOfView = 95
	}):Play()
	TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
		Brightness = 1.5,
		Contrast = 0.2,
		Saturation = 0.5,
		TintColor = Color3.fromRGB(243, 153, 255)
	}):Play()
	CamShake:Shake(CamShake.Presets.Explosion)
	game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap)
	task.delay(0.4, function() --[[ Line: 383 | Upvalues: TweenService (ref), ColorCorrectionEffect (copy) ]]
		TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2), {
			Brightness = 0,
			Contrast = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play()
		game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
			FieldOfView = 70
		}):Play()
	end)
	game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
		Cover = 0.5
	}):Play()
	RainbowMoon.Parent = ReplicatedStorage.Assets
	Skybox.SetOrder(RainbowMoon2, 0)
end

function t.Start(p1, p2, p3) --[[ Start | Line: 395 | Upvalues: LightingController (copy), t2 (copy), startUpdateLoop (copy) ]]
	if not isActive then
		isActive = true
		LightingController:TransitionTo(t2, 3)
		startUpdateLoop()
	end
end
function t.End(p1) --[[ End | Line: 404 | Upvalues: stopUpdateLoop (copy) ]]
	if isActive then
		isActive = false
		stopUpdateLoop()
	end
end

return t