--credit to prince games studio
local PlantController = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController)
local CamShake = require(game.ReplicatedStorage.ClientModules.CamShake)
local BodyShaker = require(game.ReplicatedStorage.ClientModules.BodyShaker)
local v1 = nil
local v2 = true
local v3 = nil

function lerp(p1, p2, p3) --[[ lerp | Line: 9 ]]
	return p1 + (p2 - p1) * p3
end

local v4 = nil
local t = {}
local t2 = {}
local t3 = {}
local Notification = game.SoundService.SFX.Notification
local v5 = nil
local v6 = nil
local v7 = nil

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

local t4 = {}

local function ChangeFace(p1, p2) --[[ ChangeFace | Line: 61 | Upvalues: t4 (copy) ]]
	p1.Texture = t4[p2] or t4.Normal
end

return {
	FadeIn = function(p1, p2) --[[ FadeIn | Line: 65 | Upvalues: v1 (ref), v5 (ref), v4 (ref), v2 (ref), t4 (copy), v6 (ref), v7 (ref) ]]
		local v12 = p1.Music:Clone()

		v12.Parent = workspace
		v12:Play()
		workspace:SetAttribute("TimeFrozen", true)
		game.Lighting.GeographicLatitude = 24
		v1 = p1:WaitForChild("FadeIn")
		v1.Frame.BackgroundTransparency = 0
		v1.Parent = game.Players.LocalPlayer.PlayerGui
		v5 = p1.Racoon
		v5.Parent = game.ReplicatedStorage
		v4 = p1.Map.Plants
		v4.Parent = game.ReplicatedStorage
		game.TweenService:Create(v1.Frame, TweenInfo.new(1), {
			BackgroundTransparency = 1
		}):Play()
		v2 = true

		for v22, v3 in p1.Faces:GetChildren() do
			t4[v3.Name] = v3.Texture
		end

		v6 = p1.Rigs.MainCharacter.Head.face
		v7 = p1.Rigs.Thief.Head.face

		local v42 = p1.Blur:Clone()

		v42.Parent = game.Lighting
		game.TweenService:Create(v42, TweenInfo.new(5), {
			Size = 0
		}):Play()

		local Screen = p1.Screen
		local sum = 0

		while v2 == true do
			sum = sum + game:GetService("RunService").RenderStepped:Wait()

			local v52 = math.clamp(sum / 12, 0, 1)

			Screen.LoadingGui.ProgressBar.Bar.Size = UDim2.new(v52, 0, 1, 0)
			Screen.LoadingGui.Variant1Frame.InnerFrame.CounterTxt.Text = "Loading " .. math.round(v52 * 2507) .. "/2507"

			local v8 = math.tan((math.rad(workspace.CurrentCamera.FieldOfView / 2))) * 32
			local v9 = v8 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y)

			Screen.LoadingGui.CanvasSize = workspace.CurrentCamera.ViewportSize
			Screen.Size = Vector3.new(v9, v8, 0.1)
			Screen.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -16)
		end
	end,
	LockScreenLocation = function(p1, p2) --[[ LockScreenLocation | Line: 119 | Upvalues: v2 (ref) ]]
		task.wait(0.5)
		v2 = false
		task.delay(3, function() --[[ Line: 123 | Upvalues: p1 (copy) ]]
			p1.Screen.LoadingGui.Enabled = false
		end)
	end,
	SparkleFarm = function(p1, p2) --[[ SparkleFarm | Line: 129 ]]
		for v1, v2 in p1.Sparkles:GetDescendants() do
			if v2:IsA("ParticleEmitter") then
				v2.Enabled = true
				task.delay(Random.new():NextInteger(1, 2), function() --[[ Line: 134 | Upvalues: v2 (copy) ]]
					v2.Enabled = false
				end)
			end
		end
	end,
	CharacterLand = function(p1, p2) --[[ CharacterLand | Line: 141 ]]
		p1.VFX.CharacterLand.PixelSmoke:Emit(8)
		p1.PlotSign.Empty.Enabled = false
		p1.PlotSign.InGame.Enabled = true
	end,
	WalkBehindNPC = function(p1, p2) --[[ WalkBehindNPC | Line: 147 | Upvalues: t3 (copy) ]]
		for v1, v2 in p1.NPCs:GetChildren() do
			local Humanoid = v2.Humanoid
			local v3 = t3[v2]

			if not v3 then
				v3 = {}
				t3[v2] = v3
			end

			for v4, v5 in v2.Anims:GetChildren() do
				local v6 = v3[v5]

				if v6 then
					v6:Stop(0)
				else
					local v7 = Humanoid:LoadAnimation(v5)

					v3[v5] = v7
					v6 = v7
				end

				v6:Play()
			end

			if v2:FindFirstChild("WalkPath") then
				task.spawn(function() --[[ Line: 175 | Upvalues: v2 (copy) ]]
					local t = {}

					for v1, v22 in v2.WalkPath:GetChildren() do
						t[tonumber(v22.Name)] = v22
					end

					for v4, v5 in t do
						v2.Humanoid:MoveTo(v5.Position)
						v2.Humanoid.MoveToFinished:Wait()
					end
				end)
			end
		end
	end,
	CarrotSeedAnim = function(p1, p2) --[[ CarrotSeedAnim | Line: 193 | Upvalues: PlantController (copy) ]]
		PlantController:PlayPlantFx(p1.VFX.PlantFirst.Position, "")
	end,
	FarmModel1 = function(p1, p2) --[[ FarmModel1 | Line: 197 | Upvalues: v4 (ref) ]]
		game.Lighting.ClockTime = 11
		v4["1"].Parent = p1.Fruits
	end,
	Plant2 = function(p1, p2) --[[ Plant2 | Line: 201 | Upvalues: PlantController (copy) ]]
		game.Lighting.ClockTime = 12
		PlantController:PlayPlantFx(p1.VFX.Plant2.Position, "")
	end,
	FarmModel2 = function(p1, p2) --[[ FarmModel2 | Line: 206 | Upvalues: v4 (ref) ]]
		game.Lighting.ClockTime = 13
		workspace.Temporary:ClearAllChildren()
		p1.Fruits["1"].Cleanup:Destroy()
		p1.Fruits["1"].Carrot:ScaleTo(1)

		for v1, v2 in v4["2"]:GetDescendants() do
			if v2:HasTag("GrowMeVFX") then
				v2:ScaleTo(0.3)
			end
		end

		v4["2"].Parent = p1.Fruits
	end,
	FarmModel3 = function(p1, p2) --[[ FarmModel3 | Line: 222 | Upvalues: v4 (ref) ]]
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

		for v42, v5 in v4["3"]:GetDescendants() do
			if v5:HasTag("GrowMeVFX") then
				local v6 = v5:GetPivot()

				v5:ScaleTo(0.5)
				v5:PivotTo(v6)
			end
		end

		v4["3"].Parent = p1.Fruits
	end,
	FarmModel4 = function(p1, p2) --[[ FarmModel4 | Line: 245 | Upvalues: v4 (ref), CamShake (copy) ]]
		game.Lighting.SunRays.Intensity = 0.25
		game.Lighting.GeographicLatitude = 0

		for v1, v2 in p1.Fruits["2"]:GetDescendants() do
			if v2:HasTag("GrowMeVFX") then
				local v3 = v2:GetPivot()

				v2:ScaleTo(1)
				v2:PivotTo(v3)
			end
		end

		for v42, v5 in p1.Fruits["3"]:GetDescendants() do
			if v5:HasTag("GrowMeVFX") then
				local v6 = v5:GetPivot()

				v5:ScaleTo(1)
				v5:PivotTo(v6)
			end
		end

		p1.Fruits["3"].Cleanup:Destroy()
		v4["4"].Parent = p1.Fruits
		CamShake:StopSustained(0)
		p1.VFX.Thud:Destroy()
		p1.VFX.Thud2:Destroy()
		p1.NPCs.Bacon:Destroy()
	end,
	GoToNight = function(p1, p2) --[[ GoToNight | Line: 274 | Upvalues: v4 (ref), v1 (ref) ]]
		local Lighting = game.Lighting

		game.Lighting.GeographicLatitude = 24
		task.spawn(function() --[[ Line: 283 | Upvalues: v4 (ref), p1 (copy) ]]
			for i = 1, 3 do
				task.wait(1)
				v4[tostring(i + 4)].Parent = p1.Fruits
			end
		end)

		local sum = 0
		local v12 = nil

		while sum < 5 do
			sum = sum + game:GetService("RunService").Heartbeat:Wait()
			Lighting.ClockTime = lerp(10, 0, sum / 5)

			if sum > 3 and not v12 then
				game.TweenService:Create(v1.Frame, TweenInfo.new(1), {
					BackgroundTransparency = 0
				}):Play()
				task.delay(4, function() --[[ Line: 297 | Upvalues: v1 (ref), p1 (copy) ]]
					game.Lighting.GeographicLatitude = 333
					game.Lighting.ClockTime = 19
					game.TweenService:Create(v1.Frame, TweenInfo.new(1), {
						BackgroundTransparency = 1
					}):Play()
					task.delay(1, function() --[[ Line: 302 | Upvalues: p1 (ref) ]]
						game.Debris:AddItem(p1.NPCs.builderman)
						game.Debris:AddItem(p1.NPCs.BaconHairGirl)
					end)
				end)
				v12 = true
			end
		end
	end,
	ToDay = function(p1, p2) --[[ ToDay | Line: 313 | Upvalues: v3 (ref) ]]
		local Lighting = game.Lighting

		game.Lighting.GeographicLatitude = 0
		task.spawn(function() --[[ Line: 324 | Upvalues: p1 (copy), v3 (ref) ]]
			local t = {}

			for v1, v2 in game.CollectionService:GetTagged("StealMe") do
				if v2:IsDescendantOf(p1) then
					table.insert(t, v2)
				end
			end

			for v32, v4 in p1.StealReferences:GetChildren() do
				for v5, v6 in v4:GetChildren() do
					v6.Value.Parent = v4
				end

				table.insert(t, v4)
			end

			v3 = p1.PickupParticle
			v3.Parent = workspace.Terrain

			for i = 1, #t do
				v3.WorldPosition = t[i]:GetPivot().p
				task.wait(3 / #t)
				t[i]:Destroy()

				for v7, v8 in v3:GetChildren() do
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
	PlayerThud = function(p1, p2) --[[ PlayerThud | Line: 363 | Upvalues: CamShake (copy) ]]
		CamShake:Shake(CamShake.Presets.Bump)
		p1.VFX.Thud.PixelSmoke:Emit(p1.VFX.Thud.PixelSmoke:GetAttribute("EmitCount") or 8)
	end,
	CarrotThud = function(p1, p2) --[[ CarrotThud | Line: 368 | Upvalues: CamShake (copy) ]]
		CamShake:Shake(CamShake.Presets.Bump)
		p1.VFX.Thud2.PixelSmoke:Emit(p1.VFX.Thud2.PixelSmoke:GetAttribute("EmitCount") or 12)
	end,
	WakeUp = function(p1, p2) --[[ WakeUp | Line: 373 | Upvalues: ActivateNotificationFrame (copy), v6 (ref), t4 (copy), DeactivateNotificationFrame (copy) ]]
		ActivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame)
		v6.Texture = t4.NoobHmmm or t4.Normal
		task.delay(2, function() --[[ Line: 376 | Upvalues: DeactivateNotificationFrame (ref), p1 (copy) ]]
			DeactivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame)
		end)
		p1.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = false
	end,
	NoobCurious = function(p1, p2) --[[ NoobCurious | Line: 382 | Upvalues: v6 (ref), t4 (copy), ActivateNotificationFrame (copy), DeactivateNotificationFrame (copy) ]]
		v6.Texture = t4.NoobCurious or t4.Normal
		task.delay(3, function() --[[ Line: 386 | Upvalues: ActivateNotificationFrame (ref), p1 (copy), DeactivateNotificationFrame (ref) ]]
			ActivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Restock.Frame)
			task.wait(1)
			DeactivateNotificationFrame(p1.Rigs.MainCharacter.Head.Notif.Restock.Frame)
		end)
	end,
	NoobHappy = function(p1, p2) --[[ NoobHappy | Line: 392 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.NoobHappy or t4.Normal
		task.delay(0.3, function() --[[ Line: 394 | Upvalues: p1 (copy) ]]
			p1.Rigs.SeedPack.Base.ParticleEmitter:Emit(8)
		end)
		task.wait(1.5)
		v6.Texture = t4.Normal or t4.Normal
	end,
	NoobWork = function(p1, p2) --[[ NoobWork | Line: 400 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.NoobWork or t4.Normal
	end,
	NoobNormal = function(p1, p2) --[[ NoobNormal | Line: 403 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.Normal or t4.Normal
	end,
	NoobHmm = function(p1, p2) --[[ NoobHmm | Line: 406 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.NoobHmmm or t4.Normal
	end,
	NoobConfident = function(p1, p2) --[[ NoobConfident | Line: 411 | Upvalues: v6 (ref), t4 (copy), v5 (ref) ]]
		v6.Texture = t4.NoobConfident or t4.Normal
		v5.Parent = workspace
		v5.AnimationController:LoadAnimation(v5.Walk):Play()

		local v3 = 0
		local v4 = v5:GetPivot()
		local v52 = v4 * CFrame.new(0, 50, 0)

		task.delay(0.7, function() --[[ Line: 422 | Upvalues: v3 (ref), v5 (ref), v4 (copy), v52 (copy) ]]
			while v3 < 4 do
				v3 = v3 + game:GetService("RunService").Heartbeat:Wait()
				v5:PivotTo(v4:Lerp(v52, v3 / 4))
			end

			v5:Destroy()
		end)
	end,
	NoobSleep = function(p1, p2) --[[ NoobSleep | Line: 431 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.NoobSleep or t4.Normal
		p1.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = true
	end,
	AngryNoob = function(p1, p2) --[[ AngryNoob | Line: 435 | Upvalues: v6 (ref), t4 (copy), CamShake (copy) ]]
		v6.Texture = t4.AngryNoob or t4.Normal
		task.delay(0.2, function() --[[ Line: 438 | Upvalues: CamShake (ref) ]]
			CamShake:Shake(CamShake.Presets.Bump2)
		end)
	end,
	ConfidentNoob = function(p1, p2) --[[ ConfidentNoob | Line: 443 | Upvalues: v6 (ref), t4 (copy) ]]
		v6.Texture = t4.ConfidentNoob or t4.Normal
	end,
	ThiefLook = function(p1, p2) --[[ ThiefLook | Line: 447 | Upvalues: v7 (ref), t4 (copy) ]]
		v7.Texture = t4.ThiefLook or t4.Normal
	end,
	CuriousThief = function(p1, p2) --[[ CuriousThief | Line: 450 | Upvalues: v7 (ref), t4 (copy) ]]
		v7.Texture = t4.CuriousThief or t4.Normal
	end,
	ThiefScream = function(p1, p2) --[[ ThiefScream | Line: 453 | Upvalues: v7 (ref), t4 (copy) ]]
		v7.Texture = t4.ThiefScream or t4.Normal
	end,
	HatOn = function(p1) --[[ HatOn | Line: 457 | Upvalues: CamShake (copy), t2 (copy) ]]
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
					table.insert(t2, v5)
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
	Build1 = function(p1) --[[ Build1 | Line: 503 | Upvalues: t2 (copy) ]]
		for v1, v2 in t2 do
			v2:Destroy()
		end

		p1.FenceOG:Destroy()
		p1.FenceStage1:PivotTo(p1.FenceStage1:GetPivot() * CFrame.new(0, 100, 0))
	end,
	Build2 = function(p1) --[[ Build2 | Line: 511 ]]
		p1.PlaceInStages["2"]:PivotTo(p1.PlaceInStages["2"]:GetPivot() * CFrame.new(0, 100, 0))
	end,
	Build3 = function(p1) --[[ Build3 | Line: 517 ]]
		p1.PlaceInStages["3"]:PivotTo(p1.PlaceInStages["3"]:GetPivot() * CFrame.new(0, 100, 0))
	end,
	BuildToNight = function(p1) --[[ BuildToNight | Line: 522 | Upvalues: v3 (ref) ]]
		p1.PlaceInStages["4"]:PivotTo(p1.PlaceInStages["4"]:GetPivot() * CFrame.new(0, 100, 0))

		local v1 = p1.QuickPlace:GetChildren()

		task.spawn(function() --[[ Line: 531 | Upvalues: v1 (copy), v3 (ref), p1 (copy) ]]
			for v12, v2 in v1 do
				v2:PivotTo(v2:GetPivot() * CFrame.new(0, 100, 0))
				v3.WorldPosition = v2:GetPivot().p

				for v4, v5 in v3:GetChildren() do
					v5:Emit(v5:GetAttribute("EmitCount") or 1)
				end

				task.wait((1 - (1 - (v12 + 1) / #v1) ^ 2) * 4 - (1 - (1 - v12 / #v1) ^ 2) * 4)
			end

			task.delay(4, function() --[[ Line: 552 | Upvalues: p1 (ref) ]]
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
	Sweat = function(p1) --[[ Sweat | Line: 576 | Upvalues: BodyShaker (copy) ]]
		p1.Rigs.Thief.Head.Sweat.Enabled = true
		BodyShaker.EnableShaking(p1.Rigs.Thief)
	end,
	Poof = function(p1) --[[ Poof | Line: 584 | Upvalues: BodyShaker (copy), CamShake (copy) ]]
		BodyShaker.DisableShaking(p1.Rigs.Thief)
		p1.VFX.Poof.PixelSmoke:Emit(18)
		CamShake:Shake(CamShake.Presets.Bump)
	end,
	GAG2 = function(p1) --[[ GAG2 | Line: 590 | Upvalues: v1 (ref) ]]
		v1.LogoImg.Visible = true
		v1.PressAnyTxt.Visible = true
		task.wait(3)
		game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
			ClockTime = 14
		}):Play()
		task.wait(1)
		game.TweenService:Create(v1.LogoImg.UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
			Scale = 1
		}):Play()
		task.delay(4, function() --[[ Line: 601 | Upvalues: v1 (ref) ]]
			game.TweenService:Create(v1.PressAnyTxt, TweenInfo.new(1), {
				TextTransparency = 0,
				TextStrokeTransparency = 0
			}):Play()
		end)
		task.wait(8)
		game.TweenService:Create(v1.Frame, TweenInfo.new(1), {
			BackgroundTransparency = 0
		}):Play()
	end,
	EndState = function(p1) --[[ EndState | Line: 611 | Upvalues: v1 (ref), v6 (ref), v7 (ref), v5 (ref), t (ref), v2 (ref) ]]
		v1.LogoImg.Visible = false
		v1.PressAnyTxt.Visible = false
		workspace:SetAttribute("TimeFrozen", nil)
		game.TweenService:Create(v1.Frame, TweenInfo.new(1), {
			BackgroundTransparency = 1
		}):Play()
		game.Debris:AddItem(v1, 1)
		v6 = nil
		v7 = nil
		v5 = nil

		for v12, v22 in t do
			v22:Destroy()
		end

		t = {}
		v2 = false
		p1.Screen:Destroy()
	end
}