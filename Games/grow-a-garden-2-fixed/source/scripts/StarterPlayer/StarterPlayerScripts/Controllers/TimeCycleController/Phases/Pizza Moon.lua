--credit to leon games studio
local t = {}

game:GetService("Lighting")

local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")

local Players = game:GetService("Players")

game:GetService("SoundService")
require(ReplicatedStorage.SharedModules.Networking)

local LocalPlayer = Players.LocalPlayer
local CamShake = require(ReplicatedStorage.ClientModules.CamShake)
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)

require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)

local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)

require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController)
require(game.ReplicatedStorage.ClientModules.Reticule)

local PizzaMoon = ReplicatedStorage.Assets:WaitForChild("PizzaMoon")
local Skybox = require(game.ReplicatedStorage.ClientModules.Skybox)
local PizzaGuy = require(script.PizzaGuy)
local PizzaSkybox = game.ReplicatedStorage.Assets.Skybox.PizzaSkybox

require(game.ReplicatedStorage.ClientModules.ButtonMash)
require(game.ReplicatedStorage.ClientModules.RagdollModule)
require(game.ReplicatedStorage.SharedModules.Networking)

local Bezier = require(game.ReplicatedStorage.ClientModules.Bezier)

local function lerp(p1, p2, p3) --[[ lerp | Line: 42 ]]
	return p1 + (p2 - p1) * p3
end

local t2 = {
	ClockTime = 24
}
local t3 = {
	Brightness = 0.5,
	EnvironmentDiffuseScale = 1,
	ClockTime = 9,
	Ambient = Color3.fromRGB(141, 117, 158),
	ColorShift_Bottom = Color3.fromRGB(30, 95, 199),
	ColorShift_Top = Color3.fromRGB(250, 208, 124),
	OutdoorAmbient = Color3.fromRGB(184, 43, 255)
}

local function ScaleModelTo(p1, p2, p3, p4, p5) --[[ ScaleModelTo | Line: 63 | Upvalues: TweenService (copy) ]]
	local v1 = p1:GetScale()
	local sum, v4, v5 = 0, if p4 then p4 else Enum.EasingStyle.Linear, if p5 then p5 else Enum.EasingDirection.InOut

	while sum < p3 do
		sum = sum + task.wait(0)
		p1:ScaleTo(v1 + (p2 - v1) * TweenService:GetValue(math.clamp(sum / p3, 0.01, 1), v4, v5))
	end
end

local v1 = nil
local v2 = game.SoundService.SFX.ShakeLoop:Clone()

local function startUpdateLoop() --[[ startUpdateLoop | Line: 93 | Upvalues: Skybox (copy), PizzaSkybox (copy), LightingController (copy), t3 (copy), PizzaMoon (copy) ]]
	game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
		Cover = 0
	}):Play()
	task.delay(1, function() --[[ Line: 98 | Upvalues: Skybox (ref), PizzaSkybox (ref), LightingController (ref), t3 (ref), PizzaMoon (ref) ]]
		Skybox.SetOrder(PizzaSkybox, 2)
		LightingController:TransitionTo(t3, 1)
		PizzaMoon.Parent = workspace
	end)

	local t = {}
	local t2 = {}

	for v1, v2 in PizzaMoon.FloatingVeg:GetChildren() do
		t[v2] = {
			direction = Random.new():NextUnitVector(),
			offset = Random.new():NextNumber(0, 400)
		}
		t2[v2] = v2:GetPivot()

		local v6 = CFrame.new(0, math.sin((math.rad(tick() * 90 + t[v2].offset))) * 10, 0) * t2[v2]

		v2:PivotTo(v6 * CFrame.Angles(math.rad(math.round(t[v2].direction.X) * tick() * 360), math.rad(math.round(t[v2].direction.Y) * tick() * 360), (math.rad(math.round(t[v2].direction.Z) * tick() * 360))))
	end

	local v12 = PizzaMoon.FloatingVeg:GetPivot()
	local v13 = CFrame.new(0, -300, 0) * v12

	task.spawn(function() --[[ Line: 129 | Upvalues: v13 (copy), v12 (copy), PizzaMoon (ref), t (copy), t2 (copy) ]]
		local sum = 0

		while sum < 2 do
			sum = sum + task.wait(0.025)
			PizzaMoon.FloatingVeg:PivotTo((v13:Lerp(v12, (game.TweenService:GetValue(sum / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)))))
		end

		while isActive do
			for v2, v3 in PizzaMoon.FloatingVeg:GetChildren() do
				local v7 = CFrame.new(0, math.sin((math.rad(tick() * 90 + t[v3].offset))) * 10, 0) * t2[v3]

				v3:PivotTo(v7 * CFrame.Angles(math.rad(math.round(t[v3].direction.X) * tick() * 360), math.rad(math.round(t[v3].direction.Y) * tick() * 360), (math.rad(math.round(t[v3].direction.Z) * tick() * 360))))
			end

			task.wait(0.025)
		end
	end)
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 160 | Upvalues: TweenService (copy), CamShake (copy), v1 (ref), v2 (copy), PizzaMoon (copy), ReplicatedStorage (copy), Skybox (copy), PizzaSkybox (copy) ]]
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Parent = game.Lighting
	game.Debris:AddItem(ColorCorrectionEffect, 5)
	game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
		FieldOfView = 95
	}):Play()
	TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
		Brightness = 1.5,
		Contrast = 0.2,
		Saturation = 0.5,
		TintColor = Color3.fromRGB(255, 255, 255)
	}):Play()
	CamShake:Shake(CamShake.Presets.Explosion)

	if not v1 then
		v2:Stop()
		v2.Volume = 0
		CamShake:StopSustained(3)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap)
		task.delay(0.4, function() --[[ Line: 179 | Upvalues: TweenService (ref), ColorCorrectionEffect (copy) ]]
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
		PizzaMoon.Parent = ReplicatedStorage.Assets
		Skybox.SetOrder(PizzaSkybox, 0)

		return
	end

	v1:Destroy()
	v1 = nil
	v2:Stop()
	v2.Volume = 0
	CamShake:StopSustained(3)
	game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap)
	task.delay(0.4, function() --[[ Line: 179 | Upvalues: TweenService (ref), ColorCorrectionEffect (copy) ]]
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
	PizzaMoon.Parent = ReplicatedStorage.Assets
	Skybox.SetOrder(PizzaSkybox, 0)
end

local v3 = PizzaGuy.new(PizzaMoon.PizzaGuy)

function t.Start(p1, p2, p3) --[[ Start | Line: 191 | Upvalues: LightingController (copy), t2 (copy), startUpdateLoop (copy), NotificationController (copy), v3 (copy), Bezier (copy), PizzaMoon (copy) ]]
	if not isActive then
		isActive = true
		LightingController:TransitionTo(t2, 1)
		task.wait(1)
		task.spawn(function() --[[ Line: 200 | Upvalues: startUpdateLoop (ref) ]]
			startUpdateLoop()
		end)

		local function Color(p1, p2) --[[ Color | Line: 203 ]]
			return "<font color=\"#" .. p2:ToHex() .. "\">" .. p1 .. "</font>"
		end

		NotificationController:CreateNotification(("<font color=\"#" .. Color3.fromRGB(255, 60, 60):ToHex() .. "\">PIZZA PARTY!!</font>") .. " Leave your garden for the deliveries to begin!", nil, 7)

		local ActivePizzaTarget = workspace:WaitForChild("ActivePizzaTarget")

		v3:Start()

		local v1 = nil

		local function getControlPoints(p1, p2, p3, p4) --[[ getControlPoints | Line: 220 | Upvalues: Bezier (ref) ]]
			local v1 = p2 - p1
			local v3 = Vector3.new(-v1.Z, 0, v1.X)

			if v3.Magnitude > 0 then
				v3 = v3.Unit
			end

			local v4 = p4 and -v3 or v3

			return Bezier.new(p1, p1 + v1 * 0.25 + v4 * p3, p2 - v1 * 0.25 - v4 * p3, p2)
		end

		local function newTarget(p1, p2, p3, p4) --[[ newTarget | Line: 235 | Upvalues: PizzaMoon (ref), v1 (ref), getControlPoints (copy) ]]
			local Position = PizzaMoon.PizzaGuy:GetPivot().Position

			if v1:IsDescendantOf(workspace.Gardens) then
				p2 = p2 + Vector3.new(0, 24, 0)
			end

			local Magnitude = (Position - p2).Magnitude
			local v2 = getControlPoints(Position, p2, Magnitude * p3, p4)
			local sum = 0
			local v4 = Magnitude / (p1 or 5)

			while sum < v4 and v1 == v1 do
				local v5 = game.TweenService:GetValue(math.clamp(sum / v4, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				local v6 = v2:CalculatePositionAt(v5)
				local v8 = CFrame.new(v6, (v2:CalculatePositionAt(v5 + 0.01)))
				local v9 = math.clamp(sum / 2, 0, 1)
				local v10 = PizzaMoon.PizzaGuy:GetPivot().LookVector:Lerp(v8.LookVector, v9)
				local v14 = CFrame.new(0, math.sin((math.rad(tick() * 180))) * 1, 0)

				PizzaMoon.PizzaGuy:PivotTo(CFrame.new(v6, v6 + v10) * v14)
				sum = sum + task.wait(0.025)
			end
		end

		local function loopAroundPlot(p1) --[[ loopAroundPlot | Line: 280 | Upvalues: ActivePizzaTarget (copy), PizzaMoon (ref), v1 (ref), newTarget (copy) ]]
			local p = (p1.CFrame * CFrame.new(-p1.Size.X / 2, 0, 0)).p
			local p2 = (p1.CFrame * CFrame.new(p1.Size.X / 2, 0, 0)).p
			local v12 = true

			if ActivePizzaTarget.Value then
				PizzaMoon.PizzaGuy.PizzaRig.PizzaSlot.Pizza.Enabled = true
			end

			while v1 == p1 do
				local v2
				local Position = PizzaMoon.PizzaGuy:GetPivot().Position

				v2 = if v12 and p2 then p2 else p
				v12 = not v12
				newTarget(20, v2, 0.4, v12)
			end

			PizzaMoon.PizzaGuy.PizzaRig.PizzaSlot.Pizza.Enabled = false
		end

		task.spawn(function() --[[ Line: 304 | Upvalues: ActivePizzaTarget (copy), PizzaMoon (ref), v1 (ref), newTarget (copy), loopAroundPlot (copy) ]]
			while isActive do
				task.wait(1)

				local v12 = ActivePizzaTarget.Value or PizzaMoon:WaitForChild("Center")

				if v1 ~= v12 then
					v1 = v12
					newTarget(40, v12:GetPivot().Position, 0.8)
					task.spawn(function() --[[ Line: 323 | Upvalues: loopAroundPlot (ref), v12 (ref) ]]
						loopAroundPlot(v12)
					end)
				end
			end
		end)
	end
end
function t.End(p1) --[[ End | Line: 335 | Upvalues: stopUpdateLoop (copy) ]]
	if isActive then
		isActive = false
		stopUpdateLoop()
	end
end

return t