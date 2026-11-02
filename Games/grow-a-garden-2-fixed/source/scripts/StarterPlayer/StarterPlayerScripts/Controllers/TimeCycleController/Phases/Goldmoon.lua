--credit to leon games studio
local t = {}

game:GetService("Lighting")

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Players = game:GetService("Players")

game:GetService("SoundService")

local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local Goldmoon = ReplicatedStorage.Assets:WaitForChild("Goldmoon")
local Skybox = require(game.ReplicatedStorage.ClientModules.Skybox)
local Goldmoon2 = game.ReplicatedStorage.Assets.Skybox.Goldmoon

local function lerp(p1, p2, p3) --[[ lerp | Line: 31 ]]
	return p1 + (p2 - p1) * p3
end

local t2 = {
	Brightness = 4,
	EnvironmentDiffuseScale = 1,
	ClockTime = 21,
	Ambient = Color3.fromRGB(241, 175, 7),
	ColorShift_Bottom = Color3.fromRGB(35, 135, 171),
	ColorShift_Top = Color3.fromRGB(250, 218, 34),
	OutdoorAmbient = Color3.fromRGB(74, 139, 180)
}

local function ScaleModelTo(p1, p2, p3, p4, p5) --[[ ScaleModelTo | Line: 45 | Upvalues: TweenService (copy) ]]
	local v1 = p1:GetScale()
	local sum, v4, v5 = 0, if p4 then p4 else Enum.EasingStyle.Linear, if p5 then p5 else Enum.EasingDirection.InOut

	while sum < p3 do
		sum = sum + task.wait(0)
		p1:ScaleTo(v1 + (p2 - v1) * TweenService:GetValue(math.clamp(sum / p3, 0.01, 1), v4, v5))
	end
end

local v1 = nil

local function newCharacter(p1) --[[ newCharacter | Line: 73 | Upvalues: ReplicatedStorage (copy), Players (copy), v1 (ref), LocalPlayer (copy), FieldOfViewController (copy), NotificationController (copy) ]]
	if p1:GetAttribute("Gold") then
		return
	end

	p1:SetAttribute("Gold", true)

	for v12, v2 in ReplicatedStorage.Assets.GoldEffect:GetChildren() do
		local v3 = v2:Clone()

		if v3:IsA("Highlight") then
			v3.Parent = p1
		else
			v3.Parent = p1:WaitForChild("Torso")
		end

		v3:AddTag("ClearUpGold")
	end

	if p1 ~= Players.LocalPlayer.Character or v1 then
		return
	end

	v1 = ReplicatedStorage.Assets.Vignette:Clone()
	v1.ImageLabel.ImageTransparency = 0.7
	v1.ImageLabel.UIScale.Scale = 1
	v1.ImageLabel.ImageColor3 = Color3.fromRGB(255, 234, 128)
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
		TintColor = Color3.fromRGB(255, 223, 94)
	}):Play()
	game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
		FieldOfView = 90
	}):Play()
	task.delay(0.4, function() --[[ Line: 111 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
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

	local function Color(p1, p2) --[[ Color | Line: 120 ]]
		return "<font color=\"#" .. p2:ToHex() .. "\">" .. p1 .. "</font>"
	end

	NotificationController:CreateNotification("You are " .. ("<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">MIDAS!</font>") .. " Steal QUICK to get a " .. "<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">GOLD PLANT!</font>", nil, 7)
end

local function clearupCharacter(p1) --[[ clearupCharacter | Line: 133 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), v1 (ref), FieldOfViewController (copy) ]]
	local v12 = ReplicatedStorage.Assets.GoldDisperse:Clone()

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
	p1:SetAttribute("Gold", nil)

	for v4, v5 in p1:GetDescendants() do
		if v5:HasTag("ClearUpGold") then
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

for v2, v3 in game.CollectionService:GetTagged("GoldHighlight") do
	newCharacter(v3)
end

game.CollectionService:GetInstanceAddedSignal("GoldHighlight"):Connect(newCharacter)
game.CollectionService:GetInstanceRemovedSignal("GoldHighlight"):Connect(clearupCharacter)
Networking.WeatherEffects.GoldMoonStrike.OnClientEvent:Connect(function(p1) --[[ Line: 184 | Upvalues: ReplicatedStorage (copy) ]]
	local v1 = ReplicatedStorage.Assets.GoldMeteor:Clone()
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
	end

	v1.Poof:Play()
	v1.Attachment.BillboardGui.Enabled = false

	for v4, v5 in v1.Attachment.Attachment:GetChildren() do
		v5:Emit(v5:GetAttribute("EmitCount") or 5)
	end

	game.Debris:AddItem(v1, 4)
end)

local function startUpdateLoop() --[[ startUpdateLoop | Line: 221 | Upvalues: Goldmoon (copy), Skybox (copy), Goldmoon2 (copy), ScaleModelTo (copy) ]]
	task.delay(2, function() --[[ Line: 224 | Upvalues: Goldmoon (ref), Skybox (ref), Goldmoon2 (ref), ScaleModelTo (ref) ]]
		Goldmoon.MoonModel:ScaleTo(0.01)
		Skybox.SetOrder(Goldmoon2, 2)
		ScaleModelTo(Goldmoon.MoonModel, 1, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	end)
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 231 | Upvalues: Goldmoon (copy), ReplicatedStorage (copy), Skybox (copy), Goldmoon2 (copy) ]]
	Goldmoon.Parent = ReplicatedStorage.Assets
	Skybox.SetOrder(Goldmoon2, 0)
end

function t.Start(p1, p2, p3) --[[ Start | Line: 240 | Upvalues: NotificationController (copy), LightingController (copy), t2 (copy), Goldmoon (copy), Skybox (copy), Goldmoon2 (copy), ScaleModelTo (copy) ]]
	if not isActive then
		isActive = true
		NotificationController:CreateNotification("May midas grace you...")
		LightingController:TransitionTo(t2, 3)
		Goldmoon.Parent = workspace
		task.delay(2, function() --[[ Line: 224 | Upvalues: Goldmoon (ref), Skybox (ref), Goldmoon2 (ref), ScaleModelTo (ref) ]]
			Goldmoon.MoonModel:ScaleTo(0.01)
			Skybox.SetOrder(Goldmoon2, 2)
			ScaleModelTo(Goldmoon.MoonModel, 1, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		end)
	end
end
function t.End(p1) --[[ End | Line: 251 | Upvalues: Goldmoon (copy), ReplicatedStorage (copy), Skybox (copy), Goldmoon2 (copy) ]]
	if isActive then
		isActive = false
		Goldmoon.Parent = ReplicatedStorage.Assets
		Skybox.SetOrder(Goldmoon2, 0)
	end
end

return t