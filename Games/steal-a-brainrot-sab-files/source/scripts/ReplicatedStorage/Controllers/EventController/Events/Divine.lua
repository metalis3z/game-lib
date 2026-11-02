local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)

local Name = script.Name

local eventServiceDivineHit = Net:RemoteEvent("EventService/Divine/Hit")

local managedObj = Trove.new()

data.OnStart = function(_)

	assert((EventController:GetActiveEventData(Name)))
	local Atmosphere = Lighting:FindFirstChild("Atmosphere")
	if Atmosphere then
		Atmosphere.Parent = script
		managedObj:Add(function()

			Atmosphere.Parent = Lighting
		end)
	end
	managedObj:Clone(script.AtmosphereDivine).Parent = Lighting
	EffectController:Activate("Blink")
	managedObj:Add(function()

		EffectController:Activate("Blink")
	end)
	EffectController:Run("DivineEvent", "GrassRecolor")
	managedObj:Add(function()

		EffectController:Stop("DivineEvent", "GrassRecolor")
	end)
	EffectController:Run("DivineEvent", "WallRecolor")
	managedObj:Add(function()

		EffectController:Stop("DivineEvent", "WallRecolor")
	end)
	EffectController:Run("DivineEvent", "WallBottomRecolor")
	managedObj:Add(function()

		EffectController:Stop("DivineEvent", "WallBottomRecolor")
	end)
	managedObj:Add(eventServiceDivineHit.OnClientEvent:Connect(function(val1)

		ClientEventUtils.playBurst(script.Burst, val1, {
			ReplicatedStorage.Sounds.Events.Divine.Hit
		})
	end))

	if ServerData.IsTsunamiServer() then
		managedObj:Clone(script.DivineMapTsunami).Parent = workspace
	else
		local val2 = nil
		local parent = if ServerData.IsBiggerServer() then managedObj:Clone(script.DivineMapBigger) else managedObj:Clone(script.DivineMap)
		local ref1 = managedObj:Add(parent.Decor.Stairs)
		local ref2 = managedObj:Add(parent.Gate)
		local ref3 = managedObj:Add(parent.Fill)
		local val3 = nil
		do
			local flag, flag_2 = val2, val3

			local function updateFill()

				local attribute = ReplicatedStorage:GetAttribute("DivineStairsEnabled") == true
				if flag_2 == attribute then
					return
				else
					flag_2 = attribute
					if flag then
						flag()
						flag = nil
					end

					if attribute then
						flag = Observers.observeTag("HideInDivineTiedToStairs", function(ref4)
							local Parent = ref4.Parent
							ref4.Parent = script

							return function()

								pcall(function()

									ref4.Parent = Parent
								end)
							end
						end, {
							workspace,
							script
						})
						pcall(function()

							ref1.Parent = parent.Decor
						end)
						pcall(function()

							ref3.Parent = script
						end)
						return
					else
						pcall(function()

							ref1.Parent = script
						end)
						pcall(function()

							ref3.Parent = parent
						end)
						return
					end
				end
			end
			managedObj:Add(ReplicatedStorage:GetAttributeChangedSignal("DivineStairsEnabled"):Connect(updateFill))
			managedObj:Add(parent.Decor.ChildAdded:Connect(updateFill))
			managedObj:Add(parent.Decor.ChildRemoved:Connect(updateFill))
			managedObj:Add(task.spawn(updateFill))
			parent.Parent = workspace
			local tweenObj = ref2.AnimationController.Animator:LoadAnimation(ref2.Animation)
			tweenObj.Looped = false
			managedObj:Add(function()
				tweenObj:Stop(0)
				tweenObj:Destroy()
			end)

			local gateIsOpen = false
			local gateFrozen = false

			managedObj:Add(tweenObj:GetMarkerReachedSignal("Freeze"):Connect(function()
				tweenObj:AdjustSpeed(0)
				gateFrozen = true
				gateIsOpen = true
			end))

			managedObj:Add(Timer.Simple(0.25, function()
				local gatePos = ref2:IsA("Model") and ref2:GetPivot().Position or ref2.Position

				local anyAnimalInRangeToOpen = false
				local anyAnimalInRangeToKeepOpen = false

				for _, animal in AnimalController:GetAnimals() do
					local instance = animal.Instance
					if not instance or not instance.Parent then continue end
					if instance:GetAttribute("Mutation") ~= "Divine" then continue end

					local ok, pivot = pcall(function() return instance:GetPivot().Position end)
					if not ok then continue end

					local dist = (gatePos - pivot).Magnitude

					if dist <= 40 then
						anyAnimalInRangeToOpen = true
					end

					if dist <= 80 then
						anyAnimalInRangeToKeepOpen = true
					end
				end

				if not gateIsOpen then
					if anyAnimalInRangeToOpen then
						gateIsOpen = true
						gateFrozen = false
						ReplicatedStorage.Sounds.Sfx.Divine.GateClose:Stop()
						ReplicatedStorage.Sounds.Sfx.Divine.GateOpen:Play()
						tweenObj:AdjustSpeed(1)
						if not tweenObj.IsPlaying then
							tweenObj:Play()
						end
					end
				else
					if not anyAnimalInRangeToKeepOpen then
						gateIsOpen = false
						gateFrozen = false
						ReplicatedStorage.Sounds.Sfx.Divine.GateOpen:Stop()
						ReplicatedStorage.Sounds.Sfx.Divine.GateClose:Play()
						tweenObj:AdjustSpeed(1) 
					end
				end
			end, true))
		end
	end
	managedObj:Add(Observers.observeTag("HideInDivine", function(ref5)
		local Parent_2 = ref5.Parent
		ref5.Parent = script

		return function()

			pcall(function()

				ref5.Parent = Parent_2
			end)
		end
	end, {
		workspace,
		script
	}))
	managedObj:Add(Observers.observeTag("ShowInDivine", function(managedObj_2)
		local Parent_3 = managedObj_2.Parent
		local flag_4 = false
		local eventObj = Parent_3.Destroying:Once(function()

			flag_4 = true
			managedObj_2:Destroy()
		end)
		managedObj_2.Parent = script

		return function()

			eventObj:Disconnect()
			if not flag_4 then
				pcall(function()

					managedObj_2.Parent = Parent_3
				end)
			end
		end
	end, {
		workspace,
		script
	}))
	CycleController:Update()
	SoundController:UpdateOST()
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

end

return data
