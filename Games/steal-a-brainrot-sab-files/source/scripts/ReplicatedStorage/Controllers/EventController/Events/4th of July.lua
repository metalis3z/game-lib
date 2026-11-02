local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local EventTypes = require(ReplicatedStorage.Shared.EventTypes)
local EventHandler = {}
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local CreateFireworkEvent = Net:RemoteEvent("EventService/4th of July/CreateFirework")
local ExplodeTraitEffectEvent = Net:RemoteEvent("EventService/4th of July/ExplodeTraitEffect")
local ScriptName = script.Name
local Cleaner = Trove.new()
local FireworkRaycastParams = RaycastParams.new()
FireworkRaycastParams.FilterType = Enum.RaycastFilterType.Include
FireworkRaycastParams.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots
}

EventHandler.OnStart = function(self)
	local ActiveEventData = EventController:GetActiveEventData(ScriptName)
	assert(ActiveEventData)
	ReplicatedStorage:SetAttribute("4thOfJulyEvent", true)
	Cleaner:Add(function()
		ReplicatedStorage:SetAttribute("4thOfJulyEvent", nil)
	end)
	SoundController:UpdateOST()
	CycleController:Update()
	local FireworksModel = ReplicatedStorage.Models.Events["4th of July"].Fireworks:Clone()
	FireworksModel.Parent = workspace
	local FireworkChildren = FireworksModel:GetChildren()
	table.sort(FireworkChildren, function(ChildA, ChildB)
		return tonumber(ChildA.Name) < tonumber(ChildB.Name)
	end)
	local OriginalCFrames = {}
	for _, FireworkPart in FireworkChildren do
		OriginalCFrames[FireworkPart] = FireworkPart.CFrame
	end
	local BumpShake = ShakePresets.BumpS:Clone()
	Cleaner:Add(BumpShake)
	BumpShake.Sustain = true
	Cleaner:Add(ShakePresets.BindShakeToCamera(BumpShake, workspace.CurrentCamera))
	BumpShake:Start()
	Cleaner:Add(task.delay(ActiveEventData.startedAt + 4 - workspace:GetServerTimeNow(), function()
		BumpShake:StopSustain()
	end))
	Cleaner:Add(function()
		for _, FireworkPart in FireworkChildren do
			TweenService:Create(FireworkPart, TweenInfo.new(1 + math.random() + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				CFrame = OriginalCFrames[FireworkPart] - Vector3.new(0, FireworkPart.Size.Y * 1.1, 0)
			}):Play()
		end
		task.wait(3)
		FireworksModel:Destroy()
	end)
	Cleaner:Add(CreateFireworkEvent.OnClientEvent:Connect(function(FireworkDataList)
		for _, FireworkData in FireworkDataList do
			local ChosenFireworkPart = FireworkChildren[FireworkData.Chosen]
			local FireworkBall = script.Firework:Clone()
			FireworkBall.CFrame = OriginalCFrames[ChosenFireworkPart]
			FireworkBall.Parent = workspace
			local FireworkStartup = script.FireworkStartup:Clone()
			FireworkStartup.CFrame = OriginalCFrames[ChosenFireworkPart] + Vector3.new(0, ChosenFireworkPart.Size.Y * 0.5 - FireworkStartup.Size.Y * 0.5, 0)
			FireworkStartup.Parent = workspace
			VFX.emit(FireworkStartup)
			local TrailSound = ReplicatedStorage.Sounds.Events["4th of July"]["Trail Sound Ball"]:Clone()
			TrailSound.Parent = FireworkBall
			SoundController:PlaySound(TrailSound)
			local ShotSound = ReplicatedStorage.Sounds.Events["4th of July"].Shot:Clone()
			ShotSound.Parent = FireworkStartup
			SoundController:PlaySound(ShotSound)
			task.delay(2, function()
				FireworkStartup:Destroy()
			end)
			local GroundPosition = OriginalCFrames[ChosenFireworkPart] - Vector3.new(0, ChosenFireworkPart.Size.Y, 0)
			local PeakPosition = OriginalCFrames[ChosenFireworkPart] + Vector3.new(0, FireworkData.Height, 0)
			local TravelDuration = FireworkData.Height / 20
			local LaunchTween = TweenService:Create(FireworkBall, TweenInfo.new(TravelDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = PeakPosition
			})
			LaunchTween:Play()
			task.delay(TravelDuration * 0.8, function()
				LaunchTween:Destroy()
				SoundController:PlaySound(ReplicatedStorage.Sounds.Events["4th of July"]["Firework Explosion"], PeakPosition.Position)
				local FireworkEffect = script.Effects[tostring(FireworkData.FireworkEffect)]:Clone()
				FireworkEffect.CFrame = PeakPosition
				FireworkEffect.Parent = workspace
				VFX.emit(FireworkEffect)
				FireworkBall:Destroy()
				task.delay(4, function()
					FireworkEffect:Destroy()
				end)
				for _, FalloffTarget in FireworkData.Falloffs do
					local TargetCFrame = nil
					if typeof(FalloffTarget) == "Vector3" then
						TargetCFrame = GroundPosition + FalloffTarget
						local RaycastResult = workspace:Raycast((PeakPosition + FalloffTarget).Position, Vector3.new(-0, -200, -0, -0), FireworkRaycastParams)
						if RaycastResult then
							TargetCFrame = CFrame.new(RaycastResult.Position)
						end
					end
					local FalloffPart = script.Falloff:Clone()
					FalloffPart.CFrame = PeakPosition
					FalloffPart.Parent = workspace
					local ElapsedTime = 0
					local PostSimulationConnection = nil
					do
						local LocalTargetCFrame, LocalElapsedTime, LocalConnection = TargetCFrame, ElapsedTime, PostSimulationConnection
						LocalConnection = RunService.PostSimulation:Connect(function(DeltaTime)
							debug.profilebegin("4th of July:Falloff")
							LocalElapsedTime = LocalElapsedTime + DeltaTime
							local ResolvedTarget = LocalTargetCFrame or type(FalloffTarget) == "string" and CFrame.new(ClientEventUtils.getAnimalPosition(FalloffTarget)) or CFrame.identity
							local Progress = LocalElapsedTime / 2.3
							SharedEventUtils.pushPartCFrame(FalloffPart, CFrame.new(MathUtils.quadBezier(Progress, PeakPosition.Position, PeakPosition.Position + Vector3.new(0, FireworkData.Height, 0) + (ResolvedTarget.Position - PeakPosition.Position) * Vector3.new(1, 0, 1, 0) * 0.7, ResolvedTarget.Position)))
							if Progress >= 1 and type(FalloffTarget) ~= "string" then
								local GroundImpact = script.GroundImpact:Clone()
								GroundImpact.CFrame = ResolvedTarget + Vector3.new(0, GroundImpact.Size.Y * 0.5, 0)
								GroundImpact.Parent = workspace
								VFX.emit(GroundImpact)
								VFX.disable(FalloffPart)
								task.delay(3, function()
									FalloffPart:Destroy()
									GroundImpact:Destroy()
								end)
								LocalConnection:Disconnect()
							end
							debug.profileend()
						end)
					end
				end
			end)
		end
	end))
	local RandomGenerator = Random.new()
	for _, FireworkPart in FireworkChildren do
		FireworkPart.CFrame = OriginalCFrames[FireworkPart] - Vector3.new(0, FireworkPart.Size.Y * 1.1, 0)
		local RiseTween = TweenService:Create(FireworkPart, TweenInfo.new(RandomGenerator:NextNumber(3, 7), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = OriginalCFrames[FireworkPart]
		})
		local CleanerEntry = Cleaner:Add(function()
			RiseTween:Cancel()
			RiseTween:Destroy()
		end)
		RiseTween.Completed:Once(function()
			Cleaner:Remove(CleanerEntry)
		end)
		RiseTween:Play()
	end
end

EventHandler.OnStop = function(self)
	Cleaner:Destroy()
end

EventHandler.OnLoad = function(self)
	ExplodeTraitEffectEvent.OnClientEvent:Connect(function(BurstData)
		ClientEventUtils.playBurst(script.FireworkBurst, BurstData, {
			ReplicatedStorage.Sounds.Events["4th of July"]["Brainrot Hit"]
		})
	end)
end

return EventHandler