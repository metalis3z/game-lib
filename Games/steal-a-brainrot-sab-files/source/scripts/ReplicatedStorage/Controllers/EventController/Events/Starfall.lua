

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.VFX)
local Shake = require(ReplicatedStorage.Packages.Shake)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)

local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)

local eventServiceStarfallCreateStar = Net:RemoteEvent("EventService/Starfall/CreateStar")
local eventServiceStarfallExplodeStar = Net:RemoteEvent("EventService/Starfall/ExplodeStar")

local Name = script.Name

local cloneObj = Shake.new()

cloneObj.Amplitude = 1.5
cloneObj.Frequency = 0.1
cloneObj.FadeInTime = 0
cloneObj.FadeOutTime = 0.6
cloneObj.PositionInfluence = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224, 0)
cloneObj.RotationInfluence = Vector3.new(2.5, 0.5, 0.5, 0)
local managedObj = Trove.new()
local data_2 = {}

data.OnStart = function(_)

	local l_v18_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v18_ActiveEventData_0)
	ReplicatedStorage:SetAttribute("Starfall", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("Starfall", nil)
	end)
	managedObj:Add(function()

		EffectController:Activate("Blink")
	end)
	local ref3 = if ServerData.IsTsunamiServer() then managedObj:Clone(script.StarfallWeatherTsunami) else managedObj:Clone(script.StarfallWeather)
	VFX.disable(ref3)
	ref3.Parent = workspace
	if ServerData.IsBiggerServer() then
		ClientEventUtils.resizeEffects(ref3, 2)
	end
	local serverTimeNow = l_v18_ActiveEventData_0.startedAt + 4 - workspace:GetServerTimeNow()
	managedObj:Add(task.delay(serverTimeNow, function()

		EffectController:Activate("Blink")
		local ref1 = Lighting:FindFirstChildOfClass("Atmosphere")
		if ref1 then
			ref1.Parent = script
			managedObj:Add(function()

				ref1.Parent = Lighting
			end)
		end
		managedObj:Clone(script.Atmosphere).Parent = Lighting
		local ref2 = Lighting:FindFirstChildOfClass("Sky")
		if ref2 then
			ref2.Parent = script
			managedObj:Add(function()

				ref2.Parent = Lighting
			end)
		end
		managedObj:Clone(script.Sky).Parent = Lighting
		VFX.enable(ref3)
	end))
	CycleController:Update()
	SoundController:UpdateOST()
	SoundController:UpdateAmbience()
end

data.OnStop = function(_)

	managedObj:Destroy()
	for _, v24Entry in data_2 do
		if v24Entry.Tween then
			v24Entry.Tween:Cancel()
		end

		if v24Entry.Model then
			v24Entry.Model:Destroy()
		end
	end
	table.clear(data_2)
end

data.OnLoad = function(_)

	eventServiceStarfallCreateStar.OnClientEvent:Connect(function(val1, val2, val3, val4)

		local managedObj_2 = script.Meteor:Clone()
		managedObj_2:PivotTo(CFrame.new(val2))
		managedObj_2.Parent = workspace
		local PrimaryPart = managedObj_2.PrimaryPart
		if not PrimaryPart then
			warn("Starfall meteor model is missing a PrimaryPart!")
			managedObj_2:Destroy()
			return
		else
			local tweenInfo = TweenInfo.new(val4, Enum.EasingStyle.Linear)
			local val5 = CFrame.lookAt(val3, val2)
			local tweenObj = TweenService:Create(PrimaryPart, tweenInfo, {
				CFrame = val5
			})
			tweenObj:Play()
			data_2[val1] = {
				Model = managedObj_2,
				Tween = tweenObj
			}
			tweenObj.Completed:Once(function()

				if data_2[val1] then
					data_2[val1].Tween = nil
				end
			end)
			return
		end
	end)
	eventServiceStarfallExplodeStar.OnClientEvent:Connect(function(val6, val7, flag_2)

		local data_2Data = data_2[val6]
		if data_2Data then
			task.spawn(function()

				SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Starfall.Impact, val7)
			end)

			if data_2Data.Tween then
				data_2Data.Tween:Cancel()
			end

			if data_2Data.Model then
				local Model = data_2Data.Model
				for _, descendant in Model:GetDescendants() do
					if descendant:IsA("ParticleEmitter") then
						descendant.Enabled = false
					elseif descendant:IsA("BasePart") then
						descendant.Transparency = 1
					end
				end
				Debris:AddItem(Model, 3)
			end
			data_2[val6] = nil
		end

		if flag_2 then
			ClientEventUtils.playBurst(script.StruckVFX, flag_2, {
				ReplicatedStorage.Sounds.Events.Starfall.BrainrotHit
			})
			return
		else
			local pivotToObj = script.Explosion:Clone()
			pivotToObj:PivotTo(CFrame.new(val7))
			pivotToObj.Parent = workspace
			for _, descendant_2 in pivotToObj:GetDescendants() do
				if descendant_2:IsA("ParticleEmitter") then
					task.delay(descendant_2:GetAttribute("EmitDelay") or 0, function()

						descendant_2:Emit(descendant_2:GetAttribute("EmitCount") or 1)
					end)
				end
			end
			Debris:AddItem(pivotToObj, 5)
			local flag = (workspace.CurrentCamera.CFrame.Position - val7).Magnitude
			if flag <= 150 then
				local amplitude = cloneObj:Clone()
				local val8 = math.pow(1 - flag / 150, 2)
				amplitude.Amplitude = amplitude.Amplitude * val8
				amplitude.RotationInfluence = amplitude.RotationInfluence * val8
				managedObj:Add(ShakePresets.BindShakeToCamera(amplitude))
				amplitude:Start()
			end
			return
		end
	end)
end

return data
