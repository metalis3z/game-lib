local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
game:GetService("TweenService")
local RunService = game:GetService("RunService")
game:GetService("Lighting")
local Players = game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)

local EventModule = {}
local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local IndonesiaEventSound = workspace.Sounds.IndonesiaEvent
local _ = Players.LocalPlayer
local _ = workspace.CurrentCamera
local EventName = script.Name
local BurstRemote = Net:RemoteEvent((("EventService/%*/Burst"):format(EventName)))
local _ = workspace.RenderedMovingAnimals
local trove = Trove.new()

function EventModule.OnStart(_)
	local activeEventData = EventController:GetActiveEventData(EventName)
	assert(activeEventData)

	trove:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)

	local mapModel
	if ServerData.IsBiggerServer() then
		mapModel = trove:Clone(script.MapBigger)
	else
		mapModel = trove:Clone(script.Map)
	end
	mapModel.Parent = workspace

	trove:Add(Observers.observeTag("HideInIndonesia", function(taggedInstance)
		local originalParent = taggedInstance.Parent
		taggedInstance.Parent = script
		return function()
			pcall(function()
				taggedInstance.Parent = originalParent
			end)
		end
	end, { workspace, script }))

	EffectController:Activate("Blink")
	CycleController:Update()
	SoundController:UpdateOST()
	EffectController:Run("IndonesiaEvent", "GrassRecolor")
	EffectController:Run("IndonesiaEvent", "WallRecolor")
	EffectController:Run("IndonesiaEvent", "WallBottomRecolor")

	trove:Add(function()
		EffectController:Stop("IndonesiaEvent", "GrassRecolor")
		EffectController:Stop("IndonesiaEvent", "WallRecolor")
		EffectController:Stop("IndonesiaEvent", "WallBottomRecolor")
	end)

	if ServerData.IsBiggerServer() then
		ClientEventUtils.resizeEffects(mapModel.MapVFX, 2)
	end

	VFX.enable(mapModel.MapVFX.Waterfall)

	local timeUntilFloodRise = activeEventData.startedAt + 13 - workspace:GetServerTimeNow()

	task.spawn(function()
		if timeUntilFloodRise > 10 then
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Indonesia.Activating, mapModel.MapVFX.Waterfall.indonesiawaterfall.Position, false)
		end
	end)

	local floodOriginalCFrame = mapModel.Flood:GetPivot()
	mapModel.Flood:PivotTo(floodOriginalCFrame - Vector3.new(0, 3, 0))

	trove:Add(TweenPivot(mapModel.Flood, TweenInfo.new(timeUntilFloodRise, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), floodOriginalCFrame)):Play()

	trove:Add(task.delay(activeEventData.startedAt + 87.78999999999999 - workspace:GetServerTimeNow(), function()
		ReplicatedStorage:SetAttribute("IndonesiaEventPart2", true)
		ReplicatedStorage:SetAttribute("IndonesiaEventMusic", nil)
		CycleController:Update()
		SoundController:UpdateOST()
		trove:Add(function()
			ReplicatedStorage:SetAttribute("IndonesiaEventPart2", nil)
			CycleController:Update()
			SoundController:UpdateOST()
		end)
	end))

	trove:Add(task.delay(timeUntilFloodRise, function()
		VFX.disable(mapModel.MapVFX.Waterfall)
		ReplicatedStorage:SetAttribute("IndonesiaEventAmbience", true)
		trove:Add(function()
			ReplicatedStorage:SetAttribute("IndonesiaEventAmbience", nil)
		end)
	end))

	trove:Add(task.spawn(function()
		IndonesiaEventSound.Volume = 0
		CreateTween(IndonesiaEventSound, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Volume = 0.35
		})
		IndonesiaEventSound.TimePosition = 0 + (workspace:GetServerTimeNow() - activeEventData.startedAt)
		IndonesiaEventSound:Play()
        ReplicatedStorage:SetAttribute("IndonesiaEventMusic", true)
		trove:Add(function()
			ReplicatedStorage:SetAttribute("IndonesiaEventMusic", nil)
			IndonesiaEventSound:Stop()
		end)
	end))
end

function EventModule.OnStop(_)
	trove:Destroy()
end

function EventModule.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	task.spawn(function()
		ContentProvider:PreloadAsync({ IndonesiaEventSound })
	end)

	Observers.observeTag("IndonesiaCanoe", function(canoeAttachPoint)
		local canoeTrove = Trove.new()
		local canoeModel = canoeTrove:Clone(script.Canoe)
		local canoePrimaryPart = canoeModel.PrimaryPart
		canoeModel.Parent = canoeAttachPoint

		local weld = Instance.new("Weld")
		weld.Part0 = canoePrimaryPart
		weld.Part1 = canoeAttachPoint
		weld.C0 = CFrame.Angles(0, 3.141592653589793, 0)
		weld.Parent = canoePrimaryPart

		local bambuDanceTrack = canoeModel["Bambu Bambu Sahur"].AnimationController.Animator:LoadAnimation(script.BambuDance);
		(canoeTrove or trove):Add(function()
			bambuDanceTrack:Stop(0)
			bambuDanceTrack:Destroy()
		end)

		bambuDanceTrack.Looped = true
		bambuDanceTrack:Play()

		canoeTrove:Add(RunService.PreRender:Connect(function()
			local loudnessNormalized = IndonesiaEventSound.PlaybackLoudness / 1000
			local clampedLoudness = math.clamp(loudnessNormalized, 0, 1)
			bambuDanceTrack:AdjustSpeed((math.lerp(1.3, 2, clampedLoudness)))
		end))

		return canoeTrove:WrapClean()
	end, { workspace })

	BurstRemote.OnClientEvent:Connect(function(burstData)
		ClientEventUtils.playBurst(script.Burst, burstData, { ReplicatedStorage.Sounds.Events.Indonesia.BrainrotHit })
	end)
end

return EventModule