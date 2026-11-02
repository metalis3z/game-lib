--credit to quartz games studio
local t = {
	NoMusic = true
}

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
local FieldOfViewController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController)
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local MusicController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController)

require(game.ReplicatedStorage.ClientModules.Reticule)

local ChainedMoon = ReplicatedStorage.Assets:WaitForChild("ChainedMoon")
local Skybox = require(game.ReplicatedStorage.ClientModules.Skybox)
local EnchainedMoon = game.ReplicatedStorage.Assets.Skybox.EnchainedMoon
local ButtonMash = require(game.ReplicatedStorage.ClientModules.ButtonMash)
local RagdollModule = require(game.ReplicatedStorage.ClientModules.RagdollModule)
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)

local function lerp(p1, p2, p3) --[[ lerp | Line: 45 ]]
	return p1 + (p2 - p1) * p3
end

local t2 = {
	ClockTime = 23
}
local t3 = {
	Brightness = 4,
	EnvironmentDiffuseScale = 1,
	ClockTime = 23,
	Ambient = Color3.fromRGB(197, 36, 241),
	ColorShift_Bottom = Color3.fromRGB(163, 70, 199),
	ColorShift_Top = Color3.fromRGB(125, 63, 250),
	OutdoorAmbient = Color3.fromRGB(74, 139, 180)
}

local function ScaleModelTo(p1, p2, p3, p4, p5) --[[ ScaleModelTo | Line: 65 | Upvalues: TweenService (copy) ]]
	local v1 = p1:GetScale()
	local sum, v4, v5 = 0, if p4 then p4 else Enum.EasingStyle.Linear, if p5 then p5 else Enum.EasingDirection.InOut

	while sum < p3 do
		sum = sum + task.wait(0)
		p1:ScaleTo(v1 + (p2 - v1) * TweenService:GetValue(math.clamp(sum / p3, 0.01, 1), v4, v5))
	end
end

local v1 = nil
local v2 = nil
local v3 = game.SoundService.SFX.ShakeLoop:Clone()

local function startUpdateLoop() --[[ startUpdateLoop | Line: 95 | Upvalues: Skybox (copy), EnchainedMoon (copy), MusicController (copy), ReplicatedStorage (copy), LocalPlayer (copy), FieldOfViewController (copy), CamShake (copy), LightingController (copy), t3 (copy), v1 (ref), TweenService (copy), ChainedMoon (copy), v3 (copy) ]]
	game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
		Cover = 0
	}):Play()
	task.delay(1, function() --[[ Line: 99 | Upvalues: Skybox (ref), EnchainedMoon (ref) ]]
		Skybox.SetOrder(EnchainedMoon, 2)
	end)
	MusicController:SetActiveWeather("Chained Moon")

	local v12 = false
	local v2 = true

	local function Chain(p1, p2) --[[ Chain | Line: 109 | Upvalues: v2 (ref), v12 (ref), ReplicatedStorage (ref), LocalPlayer (ref), FieldOfViewController (ref), CamShake (ref) ]]
		local v1 = game.ReplicatedStorage.Assets.ChainEffect:Clone()

		v1.Parent = workspace.CurrentCamera
		task.spawn(function() --[[ Line: 113 | Upvalues: v2 (ref), v12 (ref), v1 (copy), p2 (copy), p1 (copy), ReplicatedStorage (ref), LocalPlayer (ref), FieldOfViewController (ref), CamShake (ref) ]]
			task.wait(0.4)
			game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainMove)

			local v13 = game.SoundService.SFX.Gear:Clone()

			v13.Parent = game.SoundService
			v13.PlayOnRemove = true
			v13:Destroy()

			local sum2 = 0
			local v22 = false

			while v2 do
				sum2 = sum2 + game:GetService("RunService").Heartbeat:Wait()

				local v52 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
				local v62 = v52 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)
				local v72 = 0.5 * (workspace.CurrentCamera.FieldOfView / 70)

				if v12 then
					v1.Attachment1.Beam.TextureSpeed = 10 * v72
				end

				v1.Attachment1.Beam.Width0 = v72
				v1.Attachment1.Beam.Width1 = v72
				v1.Attachment1.Beam.TextureLength = v72

				local v82 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -p2)
				local v92 = v82 * CFrame.new(p1 * (v62 / 4), v52 / 4, 0)
				local v102 = v82 * CFrame.new(-p1 * (v62 / 4), -v52 / 4, 0)
				local LookVector = CFrame.new(v92.p, v102.p).LookVector
				local v11 = game.TweenService:GetValue(math.min(sum2, 0.7) / 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				if v11 == 1 and not v22 then
					v22 = true

					for v122, v132 in v1.Attachment2:GetChildren() do
						v132:Emit(v132:GetAttribute("EmitCount") or 15)
						v132.Enabled = false
					end

					local v14 = ReplicatedStorage.Assets.Vignette:Clone()

					v14.ImageLabel.ImageTransparency = 0.7
					v14.ImageLabel.UIScale.Scale = 1
					v14.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253)
					game.SoundService:PlayLocalSound(game.SoundService.SFX.Forge)
					game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact)
					game.TweenService:Create(v14.ImageLabel.UIScale, TweenInfo.new(1), {
						Scale = 1.1
					}):Play()
					game.TweenService:Create(v14.ImageLabel, TweenInfo.new(1), {
						ImageTransparency = 1
					}):Play()
					v14.Parent = LocalPlayer.PlayerGui

					local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

					ColorCorrectionEffect.Parent = game.Lighting
					game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
						Brightness = 0.4,
						TintColor = Color3.fromRGB(210, 119, 255)
					}):Play()
					game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
						FieldOfView = 90
					}):Play()
					task.delay(0.4, function() --[[ Line: 183 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
						game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
							Brightness = 0,
							TintColor = Color3.fromRGB(255, 255, 255)
						}):Play()
						game.Debris:AddItem(ColorCorrectionEffect, 0.8)
						game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
							FieldOfView = 80
						}):Play()
						FieldOfViewController:SetBaseFOV(80)
					end)
					game.Debris:AddItem(v14, 1)
					CamShake:Shake(CamShake.Presets.SideExplosion)

					local v15 = game.ReplicatedStorage.Assets.ChainGlow:Clone()

					v15.Parent = v1

					for v16, v17 in v15:GetChildren() do
						v17:Emit(v17:GetAttribute("EmitCount") or 15)
					end

					task.spawn(function() --[[ Line: 203 | Upvalues: v2 (ref), v15 (copy), p1 (ref) ]]
						while v2 do
							local v3 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
							local v4 = v3 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)

							v15.Size = Vector3.new(v4 / 2, 0.1, 0.1)
							v15.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-p1 * v4 / 4, -v3 / 2, -4)
							game:GetService("RunService").RenderStepped:Wait()
						end

						v15:Destroy()
					end)
				end

				local v18 = v92:Lerp(v102, v11)

				v1.Attachment2.WorldCFrame = CFrame.new(v18.Position, v18.Position + LookVector)
				v1.Attachment1.WorldCFrame = v92
			end

			v1:Destroy()
		end)
	end

	local v32 = game.SoundService.SFX.Gear:Clone()

	v32.Parent = game.SoundService

	local v4 = game.SoundService.SFX.ChainMove:Clone()

	v4.Parent = game.SoundService

	local v5 = game.ReplicatedStorage.Assets.ChainEffect:Clone()

	v5.Parent = workspace.CurrentCamera

	local v6 = 2
	local v7 = -1

	task.spawn(function() --[[ Line: 113 | Upvalues: v2 (ref), v12 (ref), v5 (copy), v6 (copy), v7 (copy), ReplicatedStorage (ref), LocalPlayer (ref), FieldOfViewController (ref), CamShake (ref) ]]
		task.wait(0.4)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainMove)

		local v13 = game.SoundService.SFX.Gear:Clone()

		v13.Parent = game.SoundService
		v13.PlayOnRemove = true
		v13:Destroy()

		local sum2 = 0
		local v22 = false

		while v2 do
			sum2 = sum2 + game:GetService("RunService").Heartbeat:Wait()

			local v52 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
			local v62 = v52 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)
			local v72 = 0.5 * (workspace.CurrentCamera.FieldOfView / 70)

			if v12 then
				v5.Attachment1.Beam.TextureSpeed = 10 * v72
			end

			v5.Attachment1.Beam.Width0 = v72
			v5.Attachment1.Beam.Width1 = v72
			v5.Attachment1.Beam.TextureLength = v72

			local v82 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -v6)
			local v92 = v82 * CFrame.new(v7 * (v62 / 4), v52 / 4, 0)
			local v102 = v82 * CFrame.new(-v7 * (v62 / 4), -v52 / 4, 0)
			local LookVector = CFrame.new(v92.p, v102.p).LookVector
			local v11 = game.TweenService:GetValue(math.min(sum2, 0.7) / 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			if v11 == 1 and not v22 then
				v22 = true

				for v122, v132 in v5.Attachment2:GetChildren() do
					v132:Emit(v132:GetAttribute("EmitCount") or 15)
					v132.Enabled = false
				end

				local v14 = ReplicatedStorage.Assets.Vignette:Clone()

				v14.ImageLabel.ImageTransparency = 0.7
				v14.ImageLabel.UIScale.Scale = 1
				v14.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253)
				game.SoundService:PlayLocalSound(game.SoundService.SFX.Forge)
				game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact)
				game.TweenService:Create(v14.ImageLabel.UIScale, TweenInfo.new(1), {
					Scale = 1.1
				}):Play()
				game.TweenService:Create(v14.ImageLabel, TweenInfo.new(1), {
					ImageTransparency = 1
				}):Play()
				v14.Parent = LocalPlayer.PlayerGui

				local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

				ColorCorrectionEffect.Parent = game.Lighting
				game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
					Brightness = 0.4,
					TintColor = Color3.fromRGB(210, 119, 255)
				}):Play()
				game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
					FieldOfView = 90
				}):Play()
				task.delay(0.4, function() --[[ Line: 183 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
					game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
						Brightness = 0,
						TintColor = Color3.fromRGB(255, 255, 255)
					}):Play()
					game.Debris:AddItem(ColorCorrectionEffect, 0.8)
					game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
						FieldOfView = 80
					}):Play()
					FieldOfViewController:SetBaseFOV(80)
				end)
				game.Debris:AddItem(v14, 1)
				CamShake:Shake(CamShake.Presets.SideExplosion)

				local v15 = game.ReplicatedStorage.Assets.ChainGlow:Clone()

				v15.Parent = v5

				for v16, v17 in v15:GetChildren() do
					v17:Emit(v17:GetAttribute("EmitCount") or 15)
				end

				task.spawn(function() --[[ Line: 203 | Upvalues: v2 (ref), v15 (copy), v7 (ref) ]]
					while v2 do
						local v3 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
						local v4 = v3 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)

						v15.Size = Vector3.new(v4 / 2, 0.1, 0.1)
						v15.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-p1 * v4 / 4, -v3 / 2, -4)
						game:GetService("RunService").RenderStepped:Wait()
					end

					v15:Destroy()
				end)
			end

			local v18 = v92:Lerp(v102, v11)

			v5.Attachment2.WorldCFrame = CFrame.new(v18.Position, v18.Position + LookVector)
			v5.Attachment1.WorldCFrame = v92
		end

		v5:Destroy()
	end)
	task.wait(0.7)
	task.delay(0.3, function() --[[ Line: 243 | Upvalues: LightingController (ref), t3 (ref) ]]
		LightingController:TransitionTo(t3, 0.4)
	end)
	task.wait(1)

	local v8 = game.ReplicatedStorage.Assets.ChainEffect:Clone()

	v8.Parent = workspace.CurrentCamera

	local v9 = 2.1
	local v10 = 1

	task.spawn(function() --[[ Line: 113 | Upvalues: v2 (ref), v12 (ref), v8 (copy), v9 (copy), v10 (copy), ReplicatedStorage (ref), LocalPlayer (ref), FieldOfViewController (ref), CamShake (ref) ]]
		task.wait(0.4)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainMove)

		local v13 = game.SoundService.SFX.Gear:Clone()

		v13.Parent = game.SoundService
		v13.PlayOnRemove = true
		v13:Destroy()

		local sum2 = 0
		local v22 = false

		while v2 do
			sum2 = sum2 + game:GetService("RunService").Heartbeat:Wait()

			local v52 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
			local v62 = v52 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)
			local v72 = 0.5 * (workspace.CurrentCamera.FieldOfView / 70)

			if v12 then
				v8.Attachment1.Beam.TextureSpeed = 10 * v72
			end

			v8.Attachment1.Beam.Width0 = v72
			v8.Attachment1.Beam.Width1 = v72
			v8.Attachment1.Beam.TextureLength = v72

			local v82 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -v9)
			local v92 = v82 * CFrame.new(v10 * (v62 / 4), v52 / 4, 0)
			local v102 = v82 * CFrame.new(-v10 * (v62 / 4), -v52 / 4, 0)
			local LookVector = CFrame.new(v92.p, v102.p).LookVector
			local v11 = game.TweenService:GetValue(math.min(sum2, 0.7) / 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			if v11 == 1 and not v22 then
				v22 = true

				for v122, v132 in v8.Attachment2:GetChildren() do
					v132:Emit(v132:GetAttribute("EmitCount") or 15)
					v132.Enabled = false
				end

				local v14 = ReplicatedStorage.Assets.Vignette:Clone()

				v14.ImageLabel.ImageTransparency = 0.7
				v14.ImageLabel.UIScale.Scale = 1
				v14.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253)
				game.SoundService:PlayLocalSound(game.SoundService.SFX.Forge)
				game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact)
				game.TweenService:Create(v14.ImageLabel.UIScale, TweenInfo.new(1), {
					Scale = 1.1
				}):Play()
				game.TweenService:Create(v14.ImageLabel, TweenInfo.new(1), {
					ImageTransparency = 1
				}):Play()
				v14.Parent = LocalPlayer.PlayerGui

				local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

				ColorCorrectionEffect.Parent = game.Lighting
				game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
					Brightness = 0.4,
					TintColor = Color3.fromRGB(210, 119, 255)
				}):Play()
				game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
					FieldOfView = 90
				}):Play()
				task.delay(0.4, function() --[[ Line: 183 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
					game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
						Brightness = 0,
						TintColor = Color3.fromRGB(255, 255, 255)
					}):Play()
					game.Debris:AddItem(ColorCorrectionEffect, 0.8)
					game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
						FieldOfView = 80
					}):Play()
					FieldOfViewController:SetBaseFOV(80)
				end)
				game.Debris:AddItem(v14, 1)
				CamShake:Shake(CamShake.Presets.SideExplosion)

				local v15 = game.ReplicatedStorage.Assets.ChainGlow:Clone()

				v15.Parent = v8

				for v16, v17 in v15:GetChildren() do
					v17:Emit(v17:GetAttribute("EmitCount") or 15)
				end

				task.spawn(function() --[[ Line: 203 | Upvalues: v2 (ref), v15 (copy), v10 (ref) ]]
					while v2 do
						local v3 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 8
						local v4 = v3 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)

						v15.Size = Vector3.new(v4 / 2, 0.1, 0.1)
						v15.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-p1 * v4 / 4, -v3 / 2, -4)
						game:GetService("RunService").RenderStepped:Wait()
					end

					v15:Destroy()
				end)
			end

			local v18 = v92:Lerp(v102, v11)

			v8.Attachment2.WorldCFrame = CFrame.new(v18.Position, v18.Position + LookVector)
			v8.Attachment1.WorldCFrame = v92
		end

		v8:Destroy()
	end)
	task.wait(1.1)
	v1 = ReplicatedStorage.Assets.Vignette:Clone()
	v1.ImageLabel.ImageTransparency = 0.7
	v1.ImageLabel.UIScale.Scale = 1
	v1.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253)
	game.TweenService:Create(v1.ImageLabel.UIScale, TweenInfo.new(1), {
		Scale = 1.04
	}):Play()
	game.TweenService:Create(v1.ImageLabel, TweenInfo.new(1), {
		ImageTransparency = 0.8
	}):Play()
	v1.Parent = LocalPlayer.PlayerGui
	CamShake:ShakeSustain(CamShake.Presets.Earthquake, 0)
	task.delay(0.5, function() --[[ Line: 262 | Upvalues: v12 (ref), v32 (copy), v4 (copy) ]]
		v12 = true
		v32.Looped = true
		v4:Play()
		v32:Play()
	end)
	task.delay(1, function() --[[ Line: 274 | Upvalues: TweenService (ref), CamShake (ref), v2 (ref), v4 (copy), v32 (copy), ChainedMoon (ref), v3 (ref) ]]
		local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

		ColorCorrectionEffect.Parent = game.Lighting
		game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
			FieldOfView = 95
		}):Play()
		TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
			Brightness = 1.5,
			Contrast = 0.2,
			Saturation = 0.5,
			TintColor = Color3.fromRGB(243, 153, 255)
		}):Play()
		CamShake:Shake(CamShake.Presets.Explosion)
		task.wait(0.38)
		ColorCorrectionEffect.Brightness = 131
		ColorCorrectionEffect.Contrast = 0
		ColorCorrectionEffect.Saturation = 155
		task.wait(0.08)
		ColorCorrectionEffect.Brightness = -4
		ColorCorrectionEffect.Contrast = 10
		ColorCorrectionEffect.Saturation = -1
		workspace.CurrentCamera.FieldOfView = 90
		task.wait(0.08)
		ColorCorrectionEffect.Brightness = 1.5
		ColorCorrectionEffect.Contrast = 0.1
		ColorCorrectionEffect.Saturation = -0.2
		v2 = false
		v4:Stop()
		v32:Stop()
		game.Debris:AddItem(v32, 1)
		game.Debris:AddItem(v4, 1)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainBreak)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact2)
		game.TweenService:Create(game.SoundService.Master.GameMusic, TweenInfo.new(3), {
			Volume = 1
		}):Play()
		game.Workspace.CurrentCamera.FieldOfView = 110
		CamShake:Shake(CamShake.Presets.Explosion)

		local v1 = ChainedMoon.Moon:GetPivot()

		ChainedMoon.Moon:PivotTo(v1 * CFrame.new(0, -600, 0))
		ChainedMoon.Parent = workspace
		TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2), {
			Brightness = 0.1,
			Contrast = 0.2,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 172, 241)
		}):Play()
		game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
			FieldOfView = 70
		}):Play()

		local v22 = game.ReplicatedStorage.Assets.ChainBreak:Clone()
		local v33 = true

		v22.Parent = workspace.CurrentCamera
		task.spawn(function() --[[ Line: 330 | Upvalues: v33 (ref), v22 (copy) ]]
			while v33 do
				game:GetService("RunService").RenderStepped:Wait()
				v22.Size = Vector3.new(math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 4 / (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y), 0.1, 2.2)
				v22.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2)
			end
		end)

		for v42, v5 in v22:GetChildren() do
			v5:Emit(v5:GetAttribute("EmitCount"))
		end

		task.delay(8, function() --[[ Line: 349 | Upvalues: v22 (copy), v33 (ref) ]]
			v22:Destroy()
			v33 = false
		end)
		task.spawn(function() --[[ Line: 354 | Upvalues: ChainedMoon (ref), v3 (ref), TweenService (ref), v1 (copy), ColorCorrectionEffect (copy), CamShake (ref) ]]
			local sum = 0

			for v12, v2 in ChainedMoon.Debris:GetChildren() do
				game.TweenService:Create(v2, TweenInfo.new(1.5), {
					TimeScale = 1
				}):Play()
			end

			v3.Parent = workspace
			v3:Play()
			TweenService:Create(v3, TweenInfo.new(1), {
				Volume = 0.3
			}):Play()

			while sum < 4 do
				sum = sum + task.wait(0.025)
				ChainedMoon.Moon:PivotTo((v1 * CFrame.new(0, -600, 0)):Lerp(v1, (TweenService:GetValue(sum / 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * CFrame.new(Random.new():NextUnitVector() * 1))
			end

			task.spawn(function() --[[ Line: 383 | Upvalues: ChainedMoon (ref), v1 (ref), TweenService (ref), ColorCorrectionEffect (ref) ]]
				local t = {}
				local t2 = {}

				for v12, v2 in ChainedMoon.Rocks:GetChildren() do
					t[v2] = v2:GetPivot()
					t2[v2] = Random.new():NextInteger(0, 10000)
				end

				while isActive do
					ChainedMoon.Moon:PivotTo(v1 * CFrame.new(Random.new():NextUnitVector() * 1))

					for v3, v4 in ChainedMoon.Rocks:GetChildren() do
						v4:PivotTo(CFrame.new(0, math.sin((math.rad(tick() * 90 + t2[v4]))) * 10, 0) * t[v4])
					end

					task.wait(0.025)
				end

				for v8, v9 in t do
					v8:PivotTo(v9)
				end

				TweenService:Create(ColorCorrectionEffect, TweenInfo.new(2), {
					Brightness = 0,
					Contrast = 0,
					Saturation = 0,
					TintColor = Color3.fromRGB(255, 255, 255)
				}):Play()
				game.Debris:AddItem(ColorCorrectionEffect, 5)
			end)
			CamShake:StopSustained(2)
			CamShake:ShakeSustain(CamShake.Presets.SoftEarthquake)
		end)
	end)
end

local function stopUpdateLoop() --[[ stopUpdateLoop | Line: 422 | Upvalues: TweenService (copy), CamShake (copy), v1 (ref), v3 (copy), ChainedMoon (copy), ReplicatedStorage (copy), Skybox (copy), EnchainedMoon (copy) ]]
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
		TintColor = Color3.fromRGB(243, 153, 255)
	}):Play()
	CamShake:Shake(CamShake.Presets.Explosion)

	if not v1 then
		v3:Stop()
		v3.Volume = 0
		CamShake:StopSustained(3)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap)
		task.delay(0.4, function() --[[ Line: 441 | Upvalues: TweenService (ref), ColorCorrectionEffect (copy) ]]
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
		ChainedMoon.Parent = ReplicatedStorage.Assets
		Skybox.SetOrder(EnchainedMoon, 0)

		return
	end

	v1:Destroy()
	v1 = nil
	v3:Stop()
	v3.Volume = 0
	CamShake:StopSustained(3)
	game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap)
	task.delay(0.4, function() --[[ Line: 441 | Upvalues: TweenService (ref), ColorCorrectionEffect (copy) ]]
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
	ChainedMoon.Parent = ReplicatedStorage.Assets
	Skybox.SetOrder(EnchainedMoon, 0)
end

function t.Start(p1, p2, p3) --[[ Start | Line: 453 | Upvalues: LightingController (copy), t2 (copy), startUpdateLoop (copy) ]]
	if not isActive then
		isActive = true
		game.TweenService:Create(game.SoundService.Master.GameMusic, TweenInfo.new(3), {
			Volume = 0
		}):Play()
		LightingController:TransitionTo(t2, 3)
		task.wait(3)
		startUpdateLoop()
	end
end
function t.End(p1) --[[ End | Line: 466 | Upvalues: stopUpdateLoop (copy) ]]
	if isActive then
		isActive = false
		stopUpdateLoop()
	end
end

local function newCharacter(p1) --[[ newCharacter | Line: 475 | Upvalues: ReplicatedStorage (copy), Players (copy), v2 (ref), LocalPlayer (copy), FieldOfViewController (copy), NotificationController (copy) ]]
	if p1:GetAttribute("Enchained") then
		return
	end

	p1:SetAttribute("Enchained", true)

	for v1, v22 in ReplicatedStorage.Assets.EnchainedEffect:GetChildren() do
		local v3 = v22:Clone()

		if v3:IsA("Highlight") then
			v3.Parent = p1
		else
			v3.Parent = p1:WaitForChild("Torso")
		end

		v3:AddTag("EnchainedClearup")
	end

	if p1 ~= Players.LocalPlayer.Character or v2 then
		return
	end

	v2 = ReplicatedStorage.Assets.Vignette:Clone()
	v2.ImageLabel.ImageTransparency = 0.7
	v2.ImageLabel.UIScale.Scale = 1
	game.TweenService:Create(v2.ImageLabel.UIScale, TweenInfo.new(1), {
		Scale = 1.04
	}):Play()
	game.TweenService:Create(v2.ImageLabel, TweenInfo.new(1), {
		ImageTransparency = 0.8
	}):Play()
	v2.Parent = LocalPlayer.PlayerGui

	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

	ColorCorrectionEffect.Parent = game.Lighting
	game.TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
		Brightness = 0.4,
		TintColor = Color3.fromRGB(235, 175, 255)
	}):Play()
	game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
		FieldOfView = 90
	}):Play()
	task.delay(0.4, function() --[[ Line: 515 | Upvalues: ColorCorrectionEffect (copy), FieldOfViewController (ref) ]]
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

	local function Color(p1, p2) --[[ Color | Line: 524 ]]
		return "<font color=\"#" .. p2:ToHex() .. "\">" .. p1 .. "</font>"
	end

	NotificationController:CreateNotification("You\'ve been " .. ("<font color=\"#" .. Color3.fromRGB(239, 116, 255):ToHex() .. "\">ENCHAINED!</font>") .. " Button mash to ESCAPE!", nil, 7)
end

local function clearupCharacter(p1) --[[ clearupCharacter | Line: 538 | Upvalues: ReplicatedStorage (copy), LocalPlayer (copy), v2 (ref), v1 (ref), FieldOfViewController (copy) ]]
	local v12 = ReplicatedStorage.Assets.EnchainedDisperse:Clone()

	v12.Parent = p1.HumanoidRootPart

	for v22, v3 in v12:GetChildren() do
		if v3:IsA("ParticleEmitter") then
			v3:Emit(v3:GetAttribute("EmitCount") or 3)

			continue
		end

		if v3:IsA("Sound") then
			v3:Play()
		end
	end

	if p1 == LocalPlayer.Character and v2 then
		game.TweenService:Create(v1.ImageLabel.UIScale, TweenInfo.new(1), {
			Scale = 1.14
		}):Play()
		v2.ImageLabel.ImageColor3 = Color3.fromRGB(255, 114, 217)
		game.TweenService:Create(v2.ImageLabel, TweenInfo.new(1), {
			ImageTransparency = 1
		}):Play()
		FieldOfViewController:SetBaseFOV(70)
		game.Debris:AddItem(v2, 1)
		v2 = nil
	end

	game.Debris:AddItem(v12, 3)
	p1:SetAttribute("Enchained", nil)

	for v4, v5 in p1:GetDescendants() do
		if v5:HasTag("EnchainedClearup") then
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

for v4, v5 in game.CollectionService:GetTagged("EnchainedHighlight") do
	newCharacter(v5)
end

game.CollectionService:GetInstanceAddedSignal("EnchainedHighlight"):Connect(newCharacter)
game.CollectionService:GetInstanceRemovedSignal("EnchainedHighlight"):Connect(clearupCharacter)

local PlantVisualizerController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController)

Networking.WeatherEffects.ChainPull.OnClientEvent:Connect(function() --[[ Line: 594 | Upvalues: PlantVisualizerController (copy), Networking (copy), LocalPlayer (copy), RagdollModule (copy), ButtonMash (copy), ChainedMoon (copy) ]]
	if PlantVisualizerController:GetOfflineCutsceneState() then
		task.wait(0.3)
		Networking.WeatherEffects.ChainPull:Fire(false)

		return
	end

	LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	RagdollModule:Ragdoll(LocalPlayer.Character)

	local v1 = tick()
	local v2 = nil

	task.spawn(function() --[[ Line: 609 | Upvalues: v2 (ref), ButtonMash (ref) ]]
		v2 = ButtonMash.Start(0.1, 0.4)
	end)

	local v3 = nil

	v3 = ChainedMoon.FloorCheck.Touched:Connect(function(p1) --[[ Line: 613 | Upvalues: LocalPlayer (ref), v3 (ref) ]]
		if not (LocalPlayer.Character and p1:IsDescendantOf(LocalPlayer.Character)) then
			return
		end

		v3:Disconnect()
		v3 = nil
	end)

	repeat
		task.wait(0)
	until v2 or (tick() - v1 > 15 or v3 == nil)

	if not v3 then
		ButtonMash.Disable()
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		RagdollModule:Unragdoll(LocalPlayer.Character)
		game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainAttacks.Chain)
		Networking.WeatherEffects.ChainPull:Fire(v2)

		return
	end

	v3:Disconnect()
	v3 = nil
	ButtonMash.Disable()
	LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	RagdollModule:Unragdoll(LocalPlayer.Character)
	game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainAttacks.Chain)
	Networking.WeatherEffects.ChainPull:Fire(v2)
end)

return t