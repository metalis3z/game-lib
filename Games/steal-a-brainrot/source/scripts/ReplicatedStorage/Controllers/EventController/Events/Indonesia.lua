-- Indonesia Event Controller (Client)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("Lighting")

require(ReplicatedStorage.Shared.EventTypes)

local module = {}

local SoundController = require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Shared.SharedEventUtils)
local Observers = require(ReplicatedStorage.Packages.Observers)
require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Packages.Shake)
local VFX = require(ReplicatedStorage.Shared.VFX)

local IndonesiaEvent = workspace.Sounds.IndonesiaEvent
local trove = Trove.new()
local EventController = require(ReplicatedStorage.Controllers.EventController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)

local function playIndonesiaSound(activeEventData)
	task.spawn(function()
		-- Le SoundId est déjà assigné directement sur l'objet Sound en Studio/production.
		-- On n'attend PAS EncryptedAssetsController qui peut bloquer indéfiniment.
		-- Si le son n'est pas encore chargé, on attend max 8 secondes.
		local waited = 0
		while not IndonesiaEvent.IsLoaded and waited < 8 do
			task.wait(0.1)
			waited += 0.1
		end

		if not IndonesiaEvent.IsLoaded then
			warn("[Indonesia] Son pas chargé après 8s, on joue quand même.")
		end

		-- Synchroniser la position si l'event a déjà commencé
		local offset = workspace:GetServerTimeNow() - activeEventData.startedAt
		if offset > 0 and IndonesiaEvent.TimeLength > 0 and offset < IndonesiaEvent.TimeLength then
			IndonesiaEvent.TimePosition = offset
		else
			IndonesiaEvent.TimePosition = 0
		end

		IndonesiaEvent:Play()

		CycleController:Update()
		SoundController:UpdateOST()

		trove:Add(function()
			IndonesiaEvent:Stop()
		end)
	end)
end

function module.OnStart(arg1)
	local activeEventData = EventController:GetActiveEventData("Indonesia")
	assert(activeEventData)

	ReplicatedStorage:SetAttribute("IndonesiaEvent", true)

	trove:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)

	local clone = trove:Clone(script.Map)
	clone.Parent = workspace

	trove:Add(Observers.observeTag("HideInIndonesia", function(obj)
		local originalParent = obj.Parent
		obj.Parent = script
		return function()
			pcall(function()
				obj.Parent = originalParent
			end)
		end
	end, {workspace, script}))

	trove:Add(Observers.observeTag("HideInIndonesiaTransparency", function(obj)
		obj.Transparency = 1
		return function()
			obj.Transparency = 0
		end
	end, {workspace}))

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

	VFX.enable(clone.MapVFX.Waterfall)

	local timeLeft = activeEventData.startedAt + 13 - workspace:GetServerTimeNow()

	task.spawn(function()
		if 10 < timeLeft then
			SoundController:PlaySound(
				ReplicatedStorage.Sounds.Events.Indonesia.Activating,
				clone.MapVFX.Waterfall.indonesiawaterfall.Position,
				false
			)
			task.wait(13)
		end
	end)

	local floodPivot = clone.Flood:GetPivot()
	clone.Flood:PivotTo(floodPivot - Vector3.new(0, 3, 0))
	trove:Add(TweenPivot(clone.Flood, TweenInfo.new(timeLeft, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), floodPivot)):Play()

	trove:Add(task.delay(activeEventData.startedAt + 87.79 - workspace:GetServerTimeNow(), function()
		ReplicatedStorage:SetAttribute("IndonesiaEventPart2", true)
		CycleController:Update()
		SoundController:UpdateOST()
		trove:Add(function()
			ReplicatedStorage:SetAttribute("IndonesiaEventPart2", nil)
			CycleController:Update()
			SoundController:UpdateOST()
		end)
	end))

	trove:Add(task.delay(timeLeft, function()
		VFX.disable(clone.MapVFX.Waterfall)
		ReplicatedStorage:SetAttribute("IndonesiaEventAmbience", true)
		trove:Add(function()
			ReplicatedStorage:SetAttribute("IndonesiaEventAmbience", nil)
		end)
	end))

	-- Lancer le son immédiatement
	playIndonesiaSound(activeEventData)
end

function module.OnStop(arg1)
	ReplicatedStorage:SetAttribute("IndonesiaEvent", nil)
	trove:Destroy()
end

local ContentProvider = game:GetService("ContentProvider")
local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local RunService = game:GetService("RunService")
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local Debris = game:GetService("Debris")
local Net = require(ReplicatedStorage.Packages.Net)
local RemoteEvent = Net:RemoteEvent("EventService/Indonesia/Burst")

function module.OnLoad(arg1)
	-- Préchargement du son sans bloquer sur EncryptedAssetsController.
	-- On tente la résolution de l'asset encrypté en arrière-plan UNIQUEMENT
	-- si le SoundId n'est pas déjà assigné sur l'objet Sound.
	task.spawn(function()
		if IndonesiaEvent.SoundId == "" then
			-- Tentative avec timeout pour ne pas bloquer indéfiniment
			local resolved = false
			task.spawn(function()
				local ok, id = pcall(function()
					return EncryptedAssetsController:WaitForAssetId("rbxassetid://113898356712198")
				end)
				if ok and id and id ~= "" then
					IndonesiaEvent.SoundId = id
					resolved = true
					ContentProvider:PreloadAsync({IndonesiaEvent})
				end
			end)
			-- Si pas résolu en 10s, on abandonne (le SoundId sera celui déjà sur l'objet)
			task.delay(10, function()
				if not resolved then
					warn("[Indonesia] EncryptedAssetsController timeout — SoundId actuel conservé:", IndonesiaEvent.SoundId)
				end
			end)
		else
			-- SoundId déjà présent, on précharge directement
			task.spawn(pcall, function()
				ContentProvider:PreloadAsync({IndonesiaEvent})
			end)
		end
	end)

	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	Observers.observeTag("IndonesiaCanoe", function(obj)
		local canoeTrove = Trove.new()
		local clone = canoeTrove:Clone(script.Canoe)
		local PrimaryPart = clone.PrimaryPart
		clone.Parent = obj

		local Weld = Instance.new("Weld")
		Weld.Part0 = PrimaryPart
		Weld.Part1 = obj
		Weld.C0 = CFrame.Angles(0, math.pi, 0)
		Weld.Parent = PrimaryPart

		canoeTrove:Add(RunService.PreRender:Connect(function()
		end))

		return canoeTrove:WrapClean()
	end, {workspace})

	RemoteEvent.OnClientEvent:Connect(function(animalId)
		local animals = AnimalController:GetAnimals()
		if not animals then return end

		local animalData = animals[animalId]
		if not animalData then return end

		local animalModel = animalData.AnimalModel
		if not animalModel then return end

		local instance = animalData.Instance
		if not instance then return end

		local primaryPart = instance.PrimaryPart
		if not primaryPart then return end
	end)
end

return module
