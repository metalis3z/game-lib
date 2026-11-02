local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local VFX = require(ReplicatedStorage.Shared.VFX)

local Name = script.Name
local onClientEventObj = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))

local managedObj = Trove.new()

local function _(loadAnimationObj, val1, val2)
	local v18Track = loadAnimationObj:LoadAnimation(val1)
	if val2 then end
	(val2 or managedObj):Add(function()

		v18Track:Stop(0)
		v18Track:Destroy()
	end)

	return v18Track
end

data.OnStart = function(_)

	assert((EventController:GetActiveEventData(Name)))
	ReplicatedStorage:SetAttribute("MeowlEvent", true)
	managedObj:Add(function()
		ReplicatedStorage:SetAttribute("MeowlEvent", nil)
	end)
	local isTsunamiServerText = nil
	isTsunamiServerText = managedObj:Clone(script.Map)
	isTsunamiServerText.Parent = workspace
	local Atmosphere = Lighting:FindFirstChild("Atmosphere")
	if Atmosphere then
		Atmosphere.Parent = script
		managedObj:Add(function()

			Atmosphere.Parent = Lighting
		end)
	end
	managedObj:Clone(script.AtmosphereMeowl).Parent = Lighting
	managedObj:Add(Observers.observeTag("HideInMeowl", function(ref1)
		local Parent = ref1.Parent
		ref1.Parent = script

		return function()

			pcall(function()

				ref1.Parent = Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	managedObj:Add(task.spawn(function()

		local flag = false
		local nextNumberObj = Random.new(912341342)
		local data_2 = {}
		local _unused = @native function(val3)

			for _, v29Entry in data_2 do
				if (val3 - v29Entry).Magnitude < 20 then

					return false
				end
			end

			return true
		end
		local val4 = {
			script.Trees["1"],
			script.Trees["2"],
			script.Trees["3"]
		}
		local children = workspace.Events.Matteo:GetChildren()
		table.sort(children, function(ref2, ref3)
			local Position = ref2.Position
			local val5 = Position.X + Position.Y + Position.Z
			local Position_2 = ref3.Position

			return Position_2.X + Position_2.Y + Position_2.Z < val5
		end)

		for _, l_Children_0Entry in children do
			local Positionl_Children_0Entry = l_Children_0Entry.Position
			local Size = l_Children_0Entry.Size
			for _ = 1, math.floor(Size.X * Size.Z * 7.0E-4) do
				local val6 = 0
				while val6 < 10 do
					val6 = val6 + 1
					local val7 = Vector3.new(Positionl_Children_0Entry.X + nextNumberObj:NextNumber(-Size.X * 0.5, Size.X * 0.5), Positionl_Children_0Entry.Y + Size.Y * 0.5, Positionl_Children_0Entry.Z + nextNumberObj:NextNumber(-Size.Z * 0.5, Size.Z * 0.5))
					local pivotToObj
					for _, v29Entry_2 in data_2 do
						if (val7 - v29Entry_2).Magnitude < 20 then
							pivotToObj = false
							flag = true
						end

						if flag then
							break
						end
					end

					if not flag then
						pivotToObj = true
					end
					flag = false
					if pivotToObj then
						pivotToObj = managedObj:Clone(val4[nextNumberObj:NextInteger(1, #val4)])
						pivotToObj:PivotTo(CFrame.new(val7 + Vector3.new(0, pivotToObj:GetExtentsSize().Y * 0.5, 0)) * CFrame.Angles(0, nextNumberObj:NextNumber(0, 6.283185307179586), 0))
						pivotToObj.Parent = workspace
						table.insert(data_2, val7)
						break
					end
				end
			end
		end
	end))
	managedObj:Add(Observers.observeTag("MeowlEventMeowl", function(part1)

		local addObj = Trove.new()
		local part0 = addObj:Clone(script.Meowl)
		part0.Parent = workspace
		local weld = Instance.new("Weld")
		weld.Part0 = part0.PrimaryPart
		weld.Part1 = part1
		weld.C0 = part0.PrimaryPart.PivotOffset
		weld.Parent = part0.PrimaryPart
		local managedObj_2 = part0.AnimationController.Animator:LoadAnimation(script.Idle)
		managedObj:Add(function()

			managedObj_2:Stop(0)
			managedObj_2:Destroy()
		end)
		local v55 = managedObj_2
		v55.Priority = Enum.AnimationPriority.Idle
		v55.Looped = true
		v55:Play()
		local managedObj_3 = part0.AnimationController.Animator:LoadAnimation(script.Fly)
		managedObj:Add(function()

			managedObj_3:Stop(0)
			managedObj_3:Destroy()
		end)
		local v57 = managedObj_3
		v57.Priority = Enum.AnimationPriority.Action
		v57.Looped = true
		local managedObj_4 = part0.AnimationController.Animator:LoadAnimation(script.Attack)
		managedObj:Add(function()

			managedObj_4:Stop(0)
			managedObj_4:Destroy()
		end)
		local v59 = managedObj_4
		v59.Priority = Enum.AnimationPriority.Action2
		v59.Looped = false
		addObj:Add(Observers.observeAttribute(part1, "Flying", function(flag_2)

			if flag_2 then
				v57:Play()
			else
				v57:Stop()
			end

			return nil
		end))
		addObj:Add(part1:GetAttributeChangedSignal("Attack"):Connect(function()

			v59:Play()
		end))

		return addObj:WrapClean()
	end, {
		workspace
	}))
	EffectController:Activate("Blink")
	EffectController:Run("MeowlEvent", "GrassRecolor")
	EffectController:Run("MeowlEvent", "WallRecolor")
	EffectController:Run("MeowlEvent", "WallBottomRecolor")
	managedObj:Add(function()

		EffectController:Stop("MeowlEvent", "GrassRecolor")
		EffectController:Stop("MeowlEvent", "WallRecolor")
		EffectController:Stop("MeowlEvent", "WallBottomRecolor")
		EffectController:Activate("Blink")
	end)
end

data.OnStop = function(_)
	managedObj:Destroy()
end

data.OnLoad = function(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	onClientEventObj.OnClientEvent:Connect(function(val8)
		local val9 = {
			ReplicatedStorage.Sounds.Events.Meowl.BrainrotHit,
			ReplicatedStorage.Sounds.Events.Meowl.Flap
		}
		managedObj:Add(ClientEventUtils.playBurst(script.Burst, val8, val9))
	end)
end

return data