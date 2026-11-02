local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

require(ReplicatedStorage.Shared.EventTypes)
local Event10BVisitsController = {}

require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local CreateFireworkRE = Net:RemoteEvent("EventService/10B Visits/CreateFirework")
local ExplodeTraitEffectRE = Net:RemoteEvent("EventService/10B Visits/ExplodeTraitEffect")

local ScriptName = script.Name
local MainTrove = Trove.new()

local RaycastFilter = RaycastParams.new()
RaycastFilter.FilterType = Enum.RaycastFilterType.Include
RaycastFilter.FilterDescendantsInstances = { workspace.Map, workspace.Plots }

local ActiveColors = {}

function Event10BVisitsController.OnStart(_)
	local eventData = EventController:GetActiveEventData(ScriptName)
	assert(eventData)

	ReplicatedStorage:SetAttribute("10BVisitsEvent", true)
	MainTrove:Add(function()
		ReplicatedStorage:SetAttribute("10BVisitsEvent", nil)
	end)

	SoundController:UpdateOST()
	CycleController:Update()

	local fireworksModel = ReplicatedStorage.Models.Events["10B Visits"].Fireworks:Clone()
	fireworksModel.Parent = workspace

	local fireworkLaunchers = fireworksModel:GetChildren()
	table.sort(fireworkLaunchers, function(a, b)
		return tonumber(a.Name) < tonumber(b.Name)
	end)

	local launcherCFrames = {}
	for _, launcher in ipairs(fireworkLaunchers) do
		launcherCFrames[launcher] = launcher.CFrame
	end

	local cameraShake = ShakePresets.BumpS:Clone()
	MainTrove:Add(cameraShake)
	cameraShake.Sustain = true
	MainTrove:Add(ShakePresets.BindShakeToCamera(cameraShake, workspace.CurrentCamera))
	cameraShake:Start()

	MainTrove:Add(task.delay(eventData.startedAt + 4 - workspace:GetServerTimeNow(), function()
		cameraShake:StopSustain()
	end))

	MainTrove:Add(function()
		for _, launcher in ipairs(fireworkLaunchers) do
			local tweenInfo = TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			local targetCFrame = launcherCFrames[launcher] - Vector3.new(0, launcher.Size.Y * 1.1, 0)
			TweenService:Create(launcher, tweenInfo, { CFrame = targetCFrame }):Play()
		end
		task.wait(3)
		fireworksModel:Destroy()
	end)


	local droneRig = MainTrove:Clone(script.DroneRig)
	droneRig.Parent = workspace

	local droneAnim = droneRig.AnimationController.Animator:LoadAnimation(script.DronesAnimation)
	droneAnim:Play(0, 1, 0.2)

	droneAnim:GetMarkerReachedSignal("TungFinished"):Once(function()
		droneAnim:AdjustSpeed(1)
	end)

	droneAnim:GetMarkerReachedSignal("Lower"):Once(function()
		TweenPivot(droneRig, TweenInfo.new(1), script.DroneRig:GetPivot() - Vector3.new(0, 100, 0)):Play()
	end)

	droneAnim:GetMarkerReachedSignal("Freeze"):Once(function()
		droneAnim:AdjustSpeed(0)
	end)

	local droneParts = {}
	for _, child in ipairs(droneRig:GetChildren()) do
		if child:IsA("BasePart") then
			table.insert(droneParts, child)
		end
	end


	MainTrove:Add(CreateFireworkRE.OnClientEvent:Connect(function(fireworkDataList)
		for id, fwData in pairs(fireworkDataList) do
			local effectSpecs = script.Effects[tostring(fwData.FireworkEffect)].specs["Embers [20]"]
			local fwColor = effectSpecs and effectSpecs.Color or ColorSequence.new(Color3.new(1, 1, 1))
			ActiveColors[id] = fwColor

			local chosenLauncher = fireworkLaunchers[fwData.Chosen]
			local fireworkProj = script.Firework:Clone()
			fireworkProj.CFrame = launcherCFrames[chosenLauncher]
			fireworkProj.Parent = workspace

			local startupEffect = script.FireworkStartup:Clone()
			startupEffect.CFrame = launcherCFrames[chosenLauncher] + Vector3.new(0, chosenLauncher.Size.Y * 0.5 - startupEffect.Size.Y * 0.5, 0)
			startupEffect.Parent = workspace
			VFX.emit(startupEffect)

			local trailSound = ReplicatedStorage.Sounds.Events["10B Visits"]["Trail Sound Ball"]:Clone()
			trailSound.Parent = fireworkProj
			SoundController:PlaySound(trailSound)

			local shotSound = ReplicatedStorage.Sounds.Events["10B Visits"].Shot:Clone()
			shotSound.Parent = startupEffect
			SoundController:PlaySound(shotSound)

			task.delay(2, function() startupEffect:Destroy() end)

			local startPos = launcherCFrames[chosenLauncher] - Vector3.new(0, chosenLauncher.Size.Y, 0)
			local targetCFrame = launcherCFrames[chosenLauncher] + Vector3.new(0, fwData.Height, 0)
			local travelTime = fwData.Height / 20

			local ascendTween = TweenService:Create(fireworkProj, TweenInfo.new(travelTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = targetCFrame
			})
			ascendTween:Play()

			task.delay(travelTime * 0.8, function()
				ascendTween:Destroy()
				SoundController:PlaySound(ReplicatedStorage.Sounds.Events["10B Visits"]["Firework Explosion"], targetCFrame.Position)

				local dominantColor = fwColor.Keypoints[1].Value
				for _, part in ipairs(droneParts) do part.Color = dominantColor end

				local explosionEffect = script.Effects[tostring(fwData.FireworkEffect)]:Clone()
				explosionEffect.CFrame = targetCFrame
				explosionEffect.Parent = workspace
				VFX.emit(explosionEffect)

				fireworkProj:Destroy()
				task.delay(4, function() explosionEffect:Destroy() end)

				for _, falloffVector in ipairs(fwData.Falloffs) do
					local falloffTarget = nil
					if typeof(falloffVector) == "Vector3" then
						falloffTarget = startPos + falloffVector
						local rayResult = workspace:Raycast((targetCFrame + falloffVector).Position, Vector3.new(0, -200, 0), RaycastFilter)
						if rayResult then falloffTarget = CFrame.new(rayResult.Position) end
					end

					local falloffEffect = script.Falloff:Clone()
					falloffEffect.CFrame = targetCFrame
					for _, emitter in ipairs(falloffEffect:GetDescendants()) do
						if emitter:IsA("ParticleEmitter") then emitter.Color = fwColor end
					end
					falloffEffect.Parent = workspace

					local timeElapsed = 0
					local renderConn = nil

					renderConn = RunService.PostSimulation:Connect(function(dt)
						debug.profilebegin("10B Visits:Falloff")
						timeElapsed = timeElapsed + dt

						local currentTarget = falloffTarget
						if not currentTarget and type(falloffVector) == "string" then
							currentTarget = CFrame.new(ClientEventUtils.getAnimalPosition(falloffVector))
						end

						local safeTarget = currentTarget or CFrame.identity
						local progress = timeElapsed / 2.3

						SharedEventUtils.pushPartCFrame(falloffEffect, CFrame.new(MathUtils.quadBezier(
							progress, 
							targetCFrame.Position, 
							targetCFrame.Position + Vector3.new(0, fwData.Height, 0) + (safeTarget.Position - targetCFrame.Position) * Vector3.new(1, 0, 1) * 0.7, 
							safeTarget.Position
							)))

						if progress >= 1 then
							if type(falloffVector) ~= "string" then
								local impactEffect = script.GroundImpact:Clone()
								impactEffect.CFrame = safeTarget + Vector3.new(0, impactEffect.Size.Y * 0.5, 0)
								for _, emitter in ipairs(impactEffect:GetDescendants()) do
									if emitter:IsA("ParticleEmitter") then emitter.Color = fwColor end
								end
								impactEffect.Parent = workspace
								VFX.emit(impactEffect)
								VFX.disable(falloffEffect)

								task.delay(3, function()
									falloffEffect:Destroy()
									impactEffect:Destroy()
								end)
								renderConn:Disconnect()
							end
						end
						debug.profileend()
					end)
				end
			end)
		end
	end))

	local rng = Random.new()
	for _, launcher in ipairs(fireworkLaunchers) do
		launcher.CFrame = launcherCFrames[launcher] - Vector3.new(0, launcher.Size.Y * 1.1, 0)
		local appearTween = TweenService:Create(launcher, TweenInfo.new(rng:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = launcherCFrames[launcher]
		})

		local tweenTrove = MainTrove:Add(function()
			appearTween:Cancel()
			appearTween:Destroy()
		end)

		appearTween.Completed:Once(function()
			MainTrove:Remove(tweenTrove)
		end)
		appearTween:Play()
	end
end

function Event10BVisitsController.OnStop(_)
	MainTrove:Destroy()
	table.clear(ActiveColors)
end

function Event10BVisitsController.OnLoad(_)
	ExplodeTraitEffectRE.OnClientEvent:Connect(function(targetId)
		ClientEventUtils.playBurst(script.FireworkBurst, targetId, { ReplicatedStorage.Sounds.Events[ScriptName]["Brainrot Hit"] }, {
			modify = function(burstModel)
				local colorSeq = ColorSequence.new(Color3.new(1, 1, 1))


				local effectSpecs = script.Effects:FindFirstChild("1")
				if effectSpecs and effectSpecs:FindFirstChild("specs") and effectSpecs.specs:FindFirstChild("Embers [20]") then 
					colorSeq = effectSpecs.specs["Embers [20]"].Color 
				end

				for _, emitter in ipairs(burstModel:GetDescendants()) do
					if emitter:IsA("ParticleEmitter") then
						emitter.Color = colorSeq
					end
				end
				return burstModel
			end
		})
	end)
end

return Event10BVisitsController