--credit to prince games studio
local PlantController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController)
local CamShake = require(game.ReplicatedStorage.ClientModules.CamShake)
local BodyShaker = require(game.ReplicatedStorage.ClientModules.BodyShaker)
local v1 = nil

function lerp(p1, p2, p3) --[[ lerp | Line: 9 ]]
	return p1 + (p2 - p1) * p3
end

local t = {}
local Notification = game.SoundService.SFX.Notification
local v2 = nil
local v3 = nil
local v4 = nil

local function ActivateNotificationFrame(p1) --[[ ActivateNotificationFrame | Line: 32 | Upvalues: Notification (copy) ]]
	local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	game.TweenService:Create(p1.TextLabel, v2, {
		Position = p1.TextLabel.Position
	}):Play()
	game.TweenService:Create(p1.ImageLabel, v1, {
		ImageTransparency = 0.5
	}):Play()
	game.TweenService:Create(p1.TextLabel, v1, {
		TextTransparency = 0
	}):Play()
	game.TweenService:Create(p1.TextLabel, v1, {
		TextStrokeTransparency = 0
	}):Play()
	Notification.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Notification.Playing = true
	Notification.TimePosition = 0
end

local function DeactivateNotificationFrame(p1) --[[ DeactivateNotificationFrame | Line: 47 ]]
	local v1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	game.TweenService:Create(p1.TextLabel, v2, {
		Position = p1.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
	}):Play()
	game.TweenService:Create(p1.ImageLabel, v1, {
		ImageTransparency = 1
	}):Play()
	game.TweenService:Create(p1.TextLabel, v1, {
		TextTransparency = 1
	}):Play()
	game.TweenService:Create(p1.TextLabel, v1, {
		TextStrokeTransparency = 1
	}):Play()
	game.Debris:AddItem(p1, v1.Time)
end

local t2 = {}

local function ChangeFace(p1, p2) --[[ ChangeFace | Line: 61 | Upvalues: t2 (copy) ]]
	p1.Texture = t2[p2] or t2.Normal
end

return {
	Drop = function(p1, p2) --[[ Drop | Line: 65 | Upvalues: PlantController (copy) ]]
		PlantController:PlayPlantFx(p1.DropZone1.Position, "Venus Fly Trap")
	end,
	DropOnSpot = function(p1, p2) --[[ DropOnSpot | Line: 70 | Upvalues: PlantController (copy) ]]
		PlantController:PlayPlantFx(p1.DropZone2.Position, "Venus Fly Trap")
	end,
	Plant2 = function(p1, p2) --[[ Plant2 | Line: 76 | Upvalues: PlantController (copy) ]]
		game.Lighting.ClockTime = 12
		PlantController:PlayPlantFx(p1.VFX.Plant2.Position, "")
	end,
	FarmModel2 = function(p1, p2) --[[ FarmModel2 | Line: 81 ]]
		game.Lighting.ClockTime = 13
		workspace.Temporary:ClearAllChildren()
		p1.Fruits["1"].Cleanup:Destroy()
		p1.Fruits["1"].Carrot:ScaleTo(1)

		for v1, v2 in (nil)["2"]:GetDescendants() do
			if v2:HasTag("GrowMeVFX") then
				v2:ScaleTo(0.3)
			end
		end

		(nil)["2"].Parent = p1.Fruits
	end,
	FarmModel3 = function(p1, p2) --[[ FarmModel3 | Line: 97 ]]
		game.Lighting.ClockTime = 14
		game.Lighting.GeographicLatitude = 87
		game.Lighting.SunRays.Intensity = 0.032
		workspace.Temporary:ClearAllChildren()

		for v1, v2 in p1.Fruits["2"]:GetDescendants() do
			if v2:HasTag("GrowMeVFX") then
				local v3 = v2:GetPivot()

				v2:ScaleTo(0.6)
				v2:PivotTo(v3)
			end
		end

		p1.Fruits["2"].Cleanup:Destroy()

		for v4, v5 in (nil)["3"]:GetDescendants() do
			if v5:HasTag("GrowMeVFX") then
				local v6 = v5:GetPivot()

				v5:ScaleTo(0.5)
				v5:PivotTo(v6)
			end
		end

		(nil)["3"].Parent = p1.Fruits
	end,
	FarmModel4 = function(p1, p2) --[[ FarmModel4 | Line: 120 | Upvalues: CamShake (copy) ]]
		game.Lighting.SunRays.Intensity = 0.25
		game.Lighting.GeographicLatitude = 0

		for v1, v2 in p1.Fruits["2"]:GetDescendants() do
			if v2:HasTag("GrowMeVFX") then
				local v3 = v2:GetPivot()

				v2:ScaleTo(1)
				v2:PivotTo(v3)
			end
		end

		for v4, v5 in p1.Fruits["3"]:GetDescendants() do
			if v5:HasTag("GrowMeVFX") then
				local v6 = v5:GetPivot()

				v5:ScaleTo(1)
				v5:PivotTo(v6)
			end
		end

		p1.Fruits["3"].Cleanup:Destroy()
		(nil)["4"].Parent = p1.Fruits
		CamShake:StopSustained(0)
		p1.VFX.Thud:Destroy()
		p1.VFX.Thud2:Destroy()
		p1.NPCs.Bacon:Destroy()
	end,
	GoToNight = function(p1, p2) --[[ GoToNight | Line: 149 ]]
		local Lighting = game.Lighting

		game.Lighting.GeographicLatitude = 24
		task.spawn(function() --[[ Line: 158 | Upvalues: p1 (copy) ]]
			for i = 1, 3 do
				task.wait(1)
				(nil)[tostring(i + 4)].Parent = p1.Fruits
			end
		end)

		local sum = 0
		local v1 = nil

		while sum < 5 do
			sum = sum + game:GetService("RunService").Heartbeat:Wait()
			Lighting.ClockTime = lerp(10, 0, sum / 5)

			if sum > 3 and not v1 then
				game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
					BackgroundTransparency = 0
				}):Play()
				task.delay(4, function() --[[ Line: 172 | Upvalues: p1 (copy) ]]
					game.Lighting.GeographicLatitude = 333
					game.Lighting.ClockTime = 19
					game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
						BackgroundTransparency = 1
					}):Play()
					task.delay(1, function() --[[ Line: 177 | Upvalues: p1 (ref) ]]
						game.Debris:AddItem(p1.NPCs.builderman)
						game.Debris:AddItem(p1.NPCs.BaconHairGirl)
					end)
				end)
				v1 = true
			end
		end
	end,
	ToDay = function(p1, p2) --[[ ToDay | Line: 188 | Upvalues: v1 (ref) ]]
		local Lighting = game.Lighting

		game.Lighting.GeographicLatitude = 0
		task.spawn(function() --[[ Line: 199 | Upvalues: p1 (copy), v1 (ref) ]]
			local t = {}

			for v12, v2 in game.CollectionService:GetTagged("StealMe") do
				if v2:IsDescendantOf(p1) then
					table.insert(t, v2)
				end
			end

			for v3, v4 in p1.StealReferences:GetChildren() do
				for v5, v6 in v4:GetChildren() do
					v6.Value.Parent = v4
				end

				table.insert(t, v4)
			end

			v1 = p1.PickupParticle
			v1.Parent = workspace.Terrain

			for i = 1, #t do
				v1.WorldPosition = t[i]:GetPivot().p
				task.wait(3 / #t)
				t[i]:PivotTo(CFrame.new(0, -100, 0) * t[i]:GetPivot())

				for v7, v8 in v1:GetChildren() do
					v8:Emit(v8:GetAttribute("EmitCount") or 1)
				end
			end
		end)

		local sum = 0

		while sum < 4 do
			sum = sum + game:GetService("RunService").Heartbeat:Wait()
			Lighting.ClockTime = 24 - lerp(4, 10, sum / 4)
		end
	end,
	PlayerThud = function(p1, p2) --[[ PlayerThud | Line: 238 | Upvalues: CamShake (copy) ]]
		CamShake:Shake(CamShake.Presets.Bump)
		p1.VFX.Thud.PixelSmoke:Emit(p1.VFX.Thud.PixelSmoke:GetAttribute("EmitCount") or 8)
	end,
	CarrotThud = function(p1, p2) --[[ CarrotThud | Line: 243 | Upvalues: CamShake (copy) ]]
		CamShake:Shake(CamShake.Presets.Bump)
		p1.VFX.Thud2.PixelSmoke:Emit(p1.VFX.Thud2.PixelSmoke:GetAttribute("EmitCount") or 12)
	end,
	WakeUp = function(p1, p2) --[[ WakeUp | Line: 248 | Upvalues: ActivateNotificationFrame (copy), v3 (ref), t2 (copy), DeactivateNotificationFrame (copy) ]]
		ActivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame)
		v3.Texture = t2.NoobHmmm or t2.Normal
		task.delay(2, function() --[[ Line: 251 | Upvalues: DeactivateNotificationFrame (ref), p1 (copy) ]]
			DeactivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame)
		end)
		p1.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = false
	end,
	NoobCurious = function(p1, p2) --[[ NoobCurious | Line: 257 | Upvalues: v3 (ref), t2 (copy), ActivateNotificationFrame (copy), DeactivateNotificationFrame (copy) ]]
		v3.Texture = t2.NoobCurious or t2.Normal
		task.delay(3, function() --[[ Line: 261 | Upvalues: ActivateNotificationFrame (ref), p1 (copy), DeactivateNotificationFrame (ref) ]]
			ActivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Restock.Frame)
			task.wait(1)
			DeactivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Restock.Frame)
		end)
	end,
	NoobHappy = function(p1, p2) --[[ NoobHappy | Line: 267 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.NoobHappy or t2.Normal
		task.delay(0.3, function() --[[ Line: 269 | Upvalues: p1 (copy) ]]
			p1.Rigs.SeedPack.Base.ParticleEmitter:Emit(8)
		end)
		task.wait(1.5)
		v3.Texture = t2.Normal or t2.Normal
	end,
	NoobWork = function(p1, p2) --[[ NoobWork | Line: 275 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.NoobWork or t2.Normal
	end,
	NoobNormal = function(p1, p2) --[[ NoobNormal | Line: 278 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.Normal or t2.Normal
	end,
	NoobHmm = function(p1, p2) --[[ NoobHmm | Line: 281 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.NoobHmmm or t2.Normal
	end,
	NoobConfident = function(p1, p2) --[[ NoobConfident | Line: 286 | Upvalues: v3 (ref), t2 (copy), v2 (ref) ]]
		v3.Texture = t2.NoobConfident or t2.Normal
		v2.Parent = workspace
		v2.AnimationController:LoadAnimation(v2.Walk):Play()

		local v32 = 0
		local v4 = v2:GetPivot()
		local v5 = v4 * CFrame.new(0, 50, 0)

		task.delay(0.7, function() --[[ Line: 297 | Upvalues: v32 (ref), v2 (ref), v4 (copy), v5 (copy) ]]
			while v32 < 4 do
				v32 = v32 + game:GetService("RunService").Heartbeat:Wait()
				v2:PivotTo(v4:Lerp(v5, v32 / 4))
			end

			v2:Destroy()
		end)
	end,
	NoobSleep = function(p1, p2) --[[ NoobSleep | Line: 306 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.NoobSleep or t2.Normal
		p1.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = true
	end,
	AngryNoob = function(p1, p2) --[[ AngryNoob | Line: 310 | Upvalues: t2 (copy), v3 (ref), v4 (ref) ]]
		for v1, v2 in p1.Faces:GetChildren() do
			t2[v2.Name] = v2.Texture
		end

		v3 = p1.Rigs.MainCharacter.Head.face
		v4 = p1.Rigs.Thief.Head.face
		v3.Texture = t2.AngryNoob or t2.Normal
	end,
	ConfidentNoob = function(p1, p2) --[[ ConfidentNoob | Line: 324 | Upvalues: v3 (ref), t2 (copy) ]]
		v3.Texture = t2.ConfidentNoob or t2.Normal
	end,
	ThiefLook = function(p1, p2) --[[ ThiefLook | Line: 328 | Upvalues: v4 (ref), t2 (copy) ]]
		v4.Texture = t2.ThiefLook or t2.Normal
	end,
	CuriousThief = function(p1, p2) --[[ CuriousThief | Line: 331 | Upvalues: v4 (ref), t2 (copy) ]]
		v4.Texture = t2.CuriousThief or t2.Normal
	end,
	ThiefScream = function(p1, p2) --[[ ThiefScream | Line: 334 | Upvalues: v4 (ref), t2 (copy) ]]
		v4.Texture = t2.ThiefScream or t2.Normal
	end,
	HatOn = function(p1) --[[ HatOn | Line: 338 | Upvalues: CamShake (copy), t (copy) ]]
		p1.Rigs.MainCharacter.BCHardHat.Handle.Transparency = 0
		CamShake:Shake(CamShake.Presets.SideExplosion)

		local Flash1 = p1.Aura.Flash1

		Flash1.Parent = game.Lighting
		Flash1.Enabled = true
		p1.Rigs.MainCharacter["1"].Handle.Transparency = 0
		task.wait(0.075)

		for v1, v2 in p1.Rigs.MainCharacter:GetChildren() do
			if v2:IsA("BasePart") and v2.Name ~= "HumanoidRootPart" then
				for v3, v4 in p1.Aura.Particles:GetChildren() do
					local v5 = v4:Clone()

					v5.Parent = v2
					v5:Emit(4)
					table.insert(t, v5)
				end
			end
		end

		for v7, v8 in p1.Rigs.MainCharacter.Torso.GoldDisperse:GetChildren() do
			v8:Emit(v8:GetAttribute("EmitCount") or 5)
		end

		local Flash2 = p1.Aura.Flash2

		Flash2.Parent = game.Lighting
		Flash1:Destroy()
		Flash2.Enabled = true
		p1.Rigs.MainCharacter["1"].Handle.Transparency = 1
		p1.Rigs.MainCharacter["2"].Handle.Transparency = 0
		task.wait(0.075)
		Flash2:Destroy()

		local Flash3 = p1.Aura.Flash3

		Flash3.Parent = game.Lighting
		Flash3.Enabled = true
		p1.Rigs.MainCharacter["2"].Handle.Transparency = 1
		task.wait(0.075)
		game.Debris:AddItem(Flash3, 4)
		Flash3.Brightness = 0.6
		Flash3.Contrast = 0
		Flash3.Saturation = 0
		Flash3.TintColor = Color3.fromRGB(255, 230, 129)
		game.TweenService:Create(Flash3, TweenInfo.new(0.8), {
			Brightness = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play()
	end,
	Build1 = function(p1) --[[ Build1 | Line: 384 | Upvalues: t (copy) ]]
		for v1, v2 in t do
			v2:Destroy()
		end

		p1.FenceOG:Destroy()
		p1.FenceStage1:PivotTo(p1.FenceStage1:GetPivot() * CFrame.new(0, 100, 0))
	end,
	Build2 = function(p1) --[[ Build2 | Line: 392 ]]
		p1.PlaceInStages["2"]:PivotTo(p1.PlaceInStages["2"]:GetPivot() * CFrame.new(0, 100, 0))
	end,
	Build3 = function(p1) --[[ Build3 | Line: 398 ]]
		p1.PlaceInStages["3"]:PivotTo(p1.PlaceInStages["3"]:GetPivot() * CFrame.new(0, 100, 0))
	end,
	BuildToNight = function(p1) --[[ BuildToNight | Line: 403 | Upvalues: v1 (ref) ]]
		p1.PlaceInStages["4"]:PivotTo(p1.PlaceInStages["4"]:GetPivot() * CFrame.new(0, 100, 0))

		local v12 = p1.QuickPlace:GetChildren()

		task.spawn(function() --[[ Line: 412 | Upvalues: v12 (copy), v1 (ref), p1 (copy) ]]
			for v13, v2 in v12 do
				v2:PivotTo(v2:GetPivot() * CFrame.new(0, 100, 0))
				v1.WorldPosition = v2:GetPivot().p

				for v4, v5 in v1:GetChildren() do
					v5:Emit(v5:GetAttribute("EmitCount") or 1)
				end

				task.wait((1 - (1 - (v13 + 1) / #v12) ^ 2) * 4 - (1 - (1 - v13 / #v12) ^ 2) * 4)
			end

			task.delay(4, function() --[[ Line: 433 | Upvalues: p1 (ref) ]]
				p1.Fruits["5"].Destroy1:Destroy()
				p1.Fruits["6"].Destroy2:Destroy()
				p1.PlaceInStages["3"].DestroyMe:Destroy()
				p1.PlaceInStages["3"].DestroyMe2:Destroy()
			end)
		end)
		game.Lighting.GeographicLatitude = 24

		local sum = 0

		while sum < 4 do
			sum = sum + game:GetService("RunService").Heartbeat:Wait()
			game.Lighting.ClockTime = lerp(14, 6, sum / 4)
		end
	end,
	Sweat = function(p1) --[[ Sweat | Line: 457 | Upvalues: BodyShaker (copy) ]]
		p1.Rigs.Thief.Head.Sweat.Enabled = true
		BodyShaker.EnableShaking(p1.Rigs.Thief)
	end,
	Poof = function(p1) --[[ Poof | Line: 465 | Upvalues: BodyShaker (copy), CamShake (copy) ]]
		BodyShaker.DisableShaking(p1.Rigs.Thief)
		p1.VFX.Poof.PixelSmoke:Emit(18)
		CamShake:Shake(CamShake.Presets.Bump)
	end,
	GAG2 = function(p1) --[[ GAG2 | Line: 471 ]]
		(nil).LogoImg.Visible = true
		(nil).PressAnyTxt.Visible = true
		task.wait(3)
		game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
			ClockTime = 14
		}):Play()
		task.wait(1)
		game.TweenService:Create((nil).LogoImg.UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
			Scale = 1
		}):Play()
		task.delay(4, function() --[[ Line: 482 ]]
			game.TweenService:Create((nil).PressAnyTxt, TweenInfo.new(1), {
				TextTransparency = 0,
				TextStrokeTransparency = 0
			}):Play()
		end)
		task.wait(8)
		game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
			BackgroundTransparency = 0
		}):Play()
	end,
	EndState = function(p1) --[[ EndState | Line: 492 | Upvalues: v3 (ref), v4 (ref), v2 (ref) ]]
		workspace:SetAttribute("TimeFrozen", nil)
		v3 = nil
		v4 = nil
		v2 = nil
	end
}