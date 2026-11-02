local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)

local LocalPlayer = Players.LocalPlayer

local CurrentCamera = workspace.CurrentCamera

local Name = script.Name

local RapConcert = workspace.Sounds.RapConcert

local managedObj_3 = Trove.new()

local val9 = nil

data.OnStart = function(_)

	local l_v12_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v12_ActiveEventData_0)

	local function _(val10)

		return (math.max(l_v12_ActiveEventData_0.startedAt + val10 - workspace:GetServerTimeNow(), 0))
	end

	local function createEventScheduler(val11, val12, val13)

		local function compute()

			local v32 = val12

			return (math.max(l_v12_ActiveEventData_0.startedAt + v32 - workspace:GetServerTimeNow(), 0))
		end

		local function run()

			val13(compute)
		end
		local flag_4 = nil
		local serverTimeNow = math.max(l_v12_ActiveEventData_0.startedAt + val11 - workspace:GetServerTimeNow(), 0)
		if serverTimeNow > 0 then
			flag_4 = task.delay(serverTimeNow, run)
		else
			val13(compute)
		end

		return function()

			if flag_4 and coroutine.status(flag_4) == "suspended" then
				pcall(task.cancel, flag_4)
			end
		end
	end
	managedObj_3:Add(function()
		ReplicatedStorage:SetAttribute("RapConcertEvent", nil)
		ReplicatedStorage:SetAttribute("RapConcertEventMusic", nil)
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)
	local Atmosphere = Lighting:FindFirstChild("Atmosphere")
	if Atmosphere then
		Atmosphere.Parent = ReplicatedStorage
		managedObj_3:Add(function()

			Atmosphere.Parent = Lighting
		end)
	end
	managedObj_3:Clone(script.Atmosphere).Parent = Lighting
	local Cartoon = Lighting:FindFirstChild("Cartoon")
	if Cartoon then
		Cartoon.Parent = ReplicatedStorage
		managedObj_3:Add(function()

			Cartoon.Parent = Lighting
		end)
	end
	local adjustSpeedObj = nil
	local colorCorrectionEffect = managedObj_3:Add(Instance.new("ColorCorrectionEffect"))
	colorCorrectionEffect.Parent = CurrentCamera

	local function createStage()

		Lighting.Ambient = Color3.new(0, 0, 0)
		Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
		managedObj_3:Add(function()

			Lighting.Ambient = Color3.fromRGB(241, 241, 241)
			Lighting.OutdoorAmbient = Color3.fromRGB(212, 212, 212)
			Lighting.EnvironmentDiffuseScale = 1
			Lighting.EnvironmentSpecularScale = 0.5
		end)
		managedObj_3:Add(task.spawn(function()
			local startTime = l_v12_ActiveEventData_0.startedAt + 5
			local elapsedTime = workspace:GetServerTimeNow() - startTime
			RapConcert.TimePosition = math.max(0, elapsedTime)
			RapConcert.Volume = 0.5
			ReplicatedStorage:SetAttribute("RapConcertEventMusic", true)
			RapConcert:Play()
			SoundController:UpdateOST()
		end))
		local val14 = {
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(255, 0, 0),
			Color3.fromRGB(255, 128, 0),
			Color3.fromRGB(255, 255, 0),
			Color3.fromRGB(128, 255, 0),
			Color3.fromRGB(0, 255, 0),
			Color3.fromRGB(0, 255, 128),
			Color3.fromRGB(0, 255, 255),
			Color3.fromRGB(0, 0, 255),
			Color3.fromRGB(128, 0, 255),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(255, 0, 128),
			Color3.fromRGB(255, 0, 255),
			Color3.fromRGB(0, 128, 255)
		}
		managedObj_3:Clone(script.Night_Sky).Parent = Lighting
		local parent = if ServerData.IsBiggerServer() then managedObj_3:Clone(script.StageBigger) else managedObj_3:Clone(script.Stage)
		local ref1 = if ServerData.IsBiggerServer() then managedObj_3:Clone(script.VFXBigger) else managedObj_3:Clone(script.VFX)
		local SmokeStage = ref1.SmokeStage
		managedObj_3:Add(SmokeStage)
		SmokeStage.Parent = workspace
		ref1.Parent = parent
		VFX.disable(ref1)
		local flag_5 = false
		local val15 = false
		local data_2 = {}
		local data_3 = {}
		local data_4 = {}
		local data_5 = {}
		local children = parent.SpotLights:GetChildren()
		local _unused = #children
		local data_6 = {}
		local data_7 = {}
		local data_8 = {}
		local data_9 = {}
		local data_10 = {}
		for _, l_Children_0Entry in children do
			data_7[l_Children_0Entry] = l_Children_0Entry:GetPivot()
			data_8[l_Children_0Entry] = 0
			data_9[l_Children_0Entry] = 0
			data_10[l_Children_0Entry] = 25
			l_Children_0Entry.Rotate.Neon["1"].LightBeam:Destroy()
			local managedObj_4 = script.lightbeambig.Beams:Clone()
			for _, child in managedObj_4:GetChildren() do
				child.Attachment0 = l_Children_0Entry.Rotate.Neon["1"]
				child.Attachment1 = l_Children_0Entry.Rotate.Neon["2"]
				child.Parent = l_Children_0Entry.Rotate.Neon
				table.insert(data_6, child)
			end
			managedObj_4:Destroy()
		end
		parent.Parent = workspace
		managedObj_3:Add(Observers.observeTag("HideInRapConcert", function(ref2)
			local Parent = ref2.Parent
			ref2.Parent = script

			return function()

				pcall(function()

					ref2.Parent = Parent
				end)
			end
		end, {
			workspace,
			script
		}))
		local color3Value = managedObj_3:Add(Instance.new("Color3Value"))
		color3Value.Value = Color3.fromRGB(0, 0, 0)
		local val16 = true
		managedObj_3:Add(function()

			val16 = false
		end)

		for _, v56Entry in data_6 do
			v56Entry.Enabled = false
		end
		managedObj_3:Add((createEventScheduler(10, 15, function(val17)

			VFX.enable(ref1)
			local val18 = 1
			local val19 = 0
			local val20 = 0
			local val21 = 0
			local val22 = 0
			local data_11 = {}
			local val23 = Color3.new(0, 0, 0)
			local val24 = ColorSequence.new(val23)
			task.delay(val17(), function()

				for _, v56Entry_2 in data_6 do
					v56Entry_2.Enabled = true
				end
			end)
			managedObj_3:Add(function()
				workspace.Gravity = 196.2
			end)
			local VFXDisco = ref1.VFXDisco
			local pivot = VFXDisco:GetPivot()
			local flag_6 = 0
			managedObj_3:Add(RunService.PostSimulation:Connect(function(val25)

				debug.profilebegin("Rap Concert:Update")
				workspace.Gravity = 29.429999999999996
				flag_6 = flag_6 - val25
				val20 = val20 - val25
				val19 = val19 - val25
				val22 = val22 - val25
				val21 = val21 - val25
				local TimePosition = RapConcert.TimePosition
				local flag_7 = math.clamp((RapConcert.PlaybackLoudness - 100) / 700, 0, 1)
				for _, v52Entry in data_4 do
					v52Entry.TimeScale = math.clamp(flag_7 / 0.05, 1, 2) * data_5[v52Entry]
				end

				if adjustSpeedObj then
					adjustSpeedObj:AdjustSpeed((math.clamp(flag_7 / 0.2, 0.5, 1.1)))
				end

				if flag_7 >= 0.11 and val21 <= 0 and val17() <= 0 then
					val21 = 0.3
					val18 = val18 % #val14 + 1
					CreateTween(color3Value, TweenInfo.new(0.2), {
						Value = val14[val18]
					})
				end
				VFXDisco:PivotTo(pivot * CFrame.Angles(0, workspace:GetServerTimeNow() - l_v12_ActiveEventData_0.startedAt, 0))
				Spr.target(VFXDisco, 1, 2, {
					Scale = 1
				})
				if flag_6 <= 0 and flag_7 > 0.05 then
					flag_6 = 0.1
					Spr.target(VFXDisco, 1, 10, {
						Scale = flag_7 + 1
					})
				end
				local Value = color3Value.Value
				local val26 = ColorSequence.new(Value)
				for _, v50Entry in data_2 do
					v50Entry.Color = if data_11[v50Entry] then val24 else val26
				end

				for _, v51Entry in data_3 do
					v51Entry.Color = if data_11[v51Entry] then val23 else Value
				end
				local val27 = val25 * math.clamp(flag_7 / 0.25, 0.05, 1)
				for _, l_Children_0Entry_2 in children do
					local val1 = data_9[l_Children_0Entry_2] or 0
					local val2 = data_10[l_Children_0Entry_2] or 0
					local flag = math.clamp((data_8[l_Children_0Entry_2] or 0) + val27, 0, 1)
					data_8[l_Children_0Entry_2] = flag
					if flag >= 1 then
						data_8[l_Children_0Entry_2] = 0
						data_9[l_Children_0Entry_2] = val2
						local v60 = data_10
						v60[l_Children_0Entry_2] = v60[l_Children_0Entry_2] * -1
					else
						local val3 = math.rad((math.lerp(val1, val2, flag)))
						l_Children_0Entry_2:PivotTo(data_7[l_Children_0Entry_2] * CFrame.Angles(0, val3, if flag_5 then val3 else 0))
						if flag_5 then
							for _, child_2 in l_Children_0Entry_2.Rotate.Neon:GetChildren() do
								if child_2.Name == "CustomAttachment_-1" or child_2.Name == "2" or child_2.Name == "CustomAttachment_2" then
									child_2.Position = Vector3.new(child_2.Position.X, math.sin(flag * 3.141592653589793) * 100, 300)
								end
							end
						end
					end
				end

				if TimePosition >= 25 and not val15 then
					val15 = true
					for _, l_Children_0Entry_3 in children do
						local attachment0 = l_Children_0Entry_3.Rotate.Neon["1"]
						local cloneObj = l_Children_0Entry_3.Rotate.Neon["2"]
						local attachment1 = cloneObj:Clone()
						attachment1.Name = "CustomAttachment_1"
						attachment1.Parent = l_Children_0Entry_3.Rotate.Neon
						CreateTween(cloneObj, TweenInfo.new(5), {
							Position = cloneObj.Position + Vector3.new(15, 0, 0, 0)
						})
						CreateTween(attachment1, TweenInfo.new(5), {
							Position = cloneObj.Position - Vector3.new(15, 0, 0, 0)
						})
						local managedObj = script.lightbeambig.Beams:Clone()
						for _, child_3 in managedObj:GetChildren() do
							child_3.Width0 = 0.5
							child_3.Width1 = 1
							child_3.Brightness = 13
							child_3.Attachment0 = attachment0
							child_3.Attachment1 = attachment1
							child_3.Parent = l_Children_0Entry_3.Rotate.Neon
							table.insert(data_6, child_3)
							table.insert(data_2, child_3)
						end
						managedObj:Destroy()
					end
				end

				if TimePosition >= 71 and not flag_5 then
					VFX.enable(SmokeStage)
					task.delay(5, function()

						VFX.disable(SmokeStage)
					end)
					flag_5 = true
					for _, l_Children_0Entry_4 in children do
						local attachment0_2 = l_Children_0Entry_4.Rotate.Neon["1"]
						local cloneObj_2 = l_Children_0Entry_4.Rotate.Neon["2"]
						local val4 = cloneObj_2.Position - Vector3.new(15, 0, 0, 0)
						CreateTween(cloneObj_2, TweenInfo.new(5), {
							Position = val4
						})
						for flag_2 = -2, 2 do
							if flag_2 ~= 0 then
								local attachment1_2 = cloneObj_2:Clone()
								attachment1_2.Name = ("CustomAttachment_%*"):format(flag_2)
								attachment1_2.Parent = l_Children_0Entry_4.Rotate.Neon
								CreateTween(attachment1_2, TweenInfo.new(5), {
									Position = val4 + Vector3.new(flag_2 * 30, 0, 0)
								})
								local managedObj_2 = script.lightbeambig.Beams:Clone()
								for _, child_4 in managedObj_2:GetChildren() do
									child_4.Width0 = 0.5
									child_4.Width1 = 1
									child_4.Brightness = 13
									child_4.Attachment0 = attachment0_2
									child_4.Attachment1 = attachment1_2
									child_4.Parent = l_Children_0Entry_4.Rotate.Neon
									table.insert(data_6, child_4)
									table.insert(data_2, child_4)
								end
								managedObj_2:Destroy()
							end
						end
					end
				end

				if flag_7 >= 0.2 and val19 <= 0 then
					val19 = 0.1
					CameraController:Fov((flag_7 - 0.2) * 15 + 70, 0.1)
				end
				debug.profileend()
			end))
		end)))

		for _, descendant in parent:GetDescendants() do
			if not descendant:IsDescendantOf(ref1.VFXDisco) then
				if descendant:IsA("BasePart") and descendant.Name == "Neon" or descendant:IsA("SpotLight") then
					table.insert(data_3, descendant)
				elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
					table.insert(data_2, descendant)
					if descendant:IsA("ParticleEmitter") then
						data_5[descendant] = descendant.TimeScale
						table.insert(data_4, descendant)
					end
				end
			end
		end
		managedObj_3:Add((createEventScheduler(10, 15, function(val5)

			CreateTween(color3Value, TweenInfo.new(val5()), {
				Value = val14[1]
			})
		end)))
	end
	managedObj_3:Add((createEventScheduler(0, 5, function(val6)

		CreateTween(colorCorrectionEffect, TweenInfo.new(val6(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Brightness = -1.2
		})
		task.delay(val6(), createStage)
		EffectController:Run("ConcertEvent", "GrassRecolor")
		managedObj_3:Add(function()

			EffectController:Stop("ConcertEvent", "GrassRecolor")
		end)
		EffectController:Run("ConcertEvent", "WallRecolor")
		managedObj_3:Add(function()

			EffectController:Stop("ConcertEvent", "WallRecolor")
		end)
		EffectController:Run("ConcertEvent", "WallBottomRecolor")
		managedObj_3:Add(function()

			EffectController:Stop("ConcertEvent", "WallBottomRecolor")
		end)
	end)))
	managedObj_3:Add((createEventScheduler(10, 15, function(val7)

		CreateTween(colorCorrectionEffect, TweenInfo.new(val7(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Brightness = -0.05
		})
	end)))
	managedObj_3:Add(task.delay(math.max(l_v12_ActiveEventData_0.startedAt + 15 - workspace:GetServerTimeNow(), 0), function()

		local _unused = managedObj_3:Add(Signal.new())
		local _unused = managedObj_3:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, waitForChildObj)

			local addObj = Trove.new()
			addObj:Add(task.spawn(function()

				local Humanoid = waitForChildObj:WaitForChild("Humanoid")
				if not Humanoid then
					return
				else
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					else
						local tweenObj = Animator:LoadAnimation(script.Dance)
						tweenObj.Priority = Enum.AnimationPriority.Action
						adjustSpeedObj = tweenObj
						local flag_3 = 0
						addObj:Add(RunService.PostSimulation:Connect(function(val8)

							debug.profilebegin("Rap Concert:Player:Dance")
							local serverTimeNow = workspace:GetServerTimeNow()
							if math.max(l_v12_ActiveEventData_0.startedAt + 75 - workspace:GetServerTimeNow(), 0) > 0 then
								if not tweenObj.IsPlaying then
									tweenObj:Play()
								end
								debug.profileend()
								return
							else
								if not (Humanoid.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not LocalPlayer:GetAttribute("Stealing") then
									if flag_3 < 3 then
										flag_3 = flag_3 + val8
									elseif not tweenObj.IsPlaying then
										tweenObj:Play()
									end
								else
									flag_3 = 0
									if tweenObj.IsPlaying then
										tweenObj:Stop()
									end
								end
								debug.profileend()
								return
							end
						end))
						addObj:Add(function()

							tweenObj:Stop()
							tweenObj:Destroy()
							adjustSpeedObj = nil
						end)
						return
					end
				end
			end))

			return addObj:WrapClean()
		end))
	end))
	CycleController:Update()
	SoundController:UpdateOST()
end

data.OnStop = function(_)
	ReplicatedStorage:SetAttribute("RapConcertEvent", nil)
	ReplicatedStorage:SetAttribute("RapConcertEventMusic", nil)
	managedObj_3:Destroy()
	val9 = nil
end

data.OnLoad = function(_)

	task.spawn(function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		ContentProvider:PreloadAsync({
			RapConcert
		})
	end)
end

return data