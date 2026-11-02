local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local EventTypes = require(ReplicatedStorage.Shared.EventTypes)
local SnowController = {}
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local TsunamiEventController = require(ReplicatedStorage.Controllers.TsunamiEventController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local scriptName = script.Name
local snowHitRemote = Net:RemoteEvent("EventService/Snow/Hit")
local trove = Trove.new()

local function tweenPile(pile)
	task.wait(math.random() * 0.8)
	local targetCFrame = pile:GetPivot() * CFrame.new(0, 10, 0)
	local cframeValue = Instance.new("CFrameValue")
	cframeValue.Value = pile:GetPivot()
	local changedConnection = cframeValue.Changed:Connect(function(newCFrame)
		pile:PivotTo(newCFrame)
	end)
	local tweenInfo = TweenInfo.new(1.2)
	local tween = TweenService:Create(cframeValue, tweenInfo, {
		Value = targetCFrame
	})
	tween:Play()
	tween.Completed:Connect(function()
		changedConnection:Disconnect()
		cframeValue:Destroy()
		pile:PivotTo(targetCFrame)
	end)
end

SnowController.OnStart = function(self)
	local activeEventData = EventController:GetActiveEventData(scriptName)
	assert(activeEventData)
	ReplicatedStorage:SetAttribute("Snow", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("Snow", nil)
	end)
	local function getTimeLeftForSync(duration, currentTime)
		return activeEventData.startedAt + duration - (currentTime or workspace:GetServerTimeNow())
	end
	local startDelay = activeEventData.startedAt + 4 - workspace:GetServerTimeNow()
	local snowWeather = if ServerData.IsTsunamiServer() then trove:Clone(script.SnowWeatherTsunami) else trove:Clone(script.SnowWeather)
	VFX.disable(snowWeather)
	snowWeather.Parent = workspace
	if ServerData.IsBiggerServer() then
		ClientEventUtils.resizeEffects(snowWeather, 2)
	end
	trove:Add(task.delay(startDelay, function()
		local atmosphere = Lighting:FindFirstChild("Atmosphere")
		if atmosphere then
			atmosphere.Parent = script
			trove:Add(function()
				atmosphere.Parent = Lighting
			end)
		end
		trove:Clone(script.AtmosphereSnow).Parent = Lighting
		local cartoon = Lighting:FindFirstChild("Cartoon")
		if cartoon then
			cartoon.Parent = script
			trove:Add(function()
				cartoon.Parent = Lighting
			end)
		end
		trove:Clone(script.SkySnow).Parent = Lighting
		VFX.enable(snowWeather)
	end))

	trove:Add(CollectionService:GetInstanceAddedSignal("SnowPile"):Connect(function(instance)
		if instance:IsA("Model") then
			task.spawn(tweenPile, instance)
		end
	end))
	for _, snowPile in CollectionService:GetTagged("SnowPile") do
		if snowPile:IsA("Model") then
			task.spawn(tweenPile, snowPile)
		end
	end

	EffectController:Run("Snow", "GrassRecolor")
	trove:Add(function()
		EffectController:Stop("Snow", "GrassRecolor")
	end)
	CycleController:Update()
	SoundController:UpdateOST()
	SoundController:UpdateAmbience()
end

SnowController.OnStop = function(self)
	trove:Destroy()
end

SnowController.OnLoad = function(self)
	snowHitRemote.OnClientEvent:Connect(function(hitPosition)
		ClientEventUtils.playBurst(script.StruckVFX, hitPosition, {
			ReplicatedStorage.Sounds.Events.Snow.Burst
		})
	end)
end

return SnowController