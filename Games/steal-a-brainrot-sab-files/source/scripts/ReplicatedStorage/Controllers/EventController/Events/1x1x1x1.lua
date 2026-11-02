local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local LocalPlayer = Players.LocalPlayer

local CurrentCamera = workspace.CurrentCamera

local val1 = CFrame.new(-410.5, -8, -228.54) + if ServerData.IsBiggerServer() then Vector3.new(0, 0, -251, 0) else Vector3.new(0, 0, 0, 0)

local Name = script.Name

local managedObj = Trove.new()

local function initActivationVisual()

	local subCollector = managedObj:Extend()
	local connections = table.create(4)
	subCollector:Add(function()

		table.clear(connections)
	end)
	local val2 = 0
	subCollector:Add(RunService.PreRender:Connect(function(val3)

		debug.profilebegin("1x1x1x1 Event")
		val2 = val2 + val3
		for v36EntryId, v36Entry in connections do
			if v36Entry.target and v36Entry.targetAttachment then
				v36Entry.beam.First.Enabled = true
				v36Entry.beam.Second.Enabled = true
				local val4 = math.clamp(val2 - v36EntryId + 1, 0, 1)
				local WorldPosition = v36Entry.beam.WorldPosition
				v36Entry.targetAttachment.Position = WorldPosition + (v36Entry.target:GetPivot().Position - WorldPosition) * val4
			end
		end
		debug.profileend()
	end))
	subCollector:Add(Observers.observeTag("1x1x1x1PlayerVFX", function(parent)

		local attribute = parent:GetAttribute("1x1x1x1PlayerVFXVariant") or "Green"
		local beamObj = script[("PlayerVFX_%*"):format(attribute)]
		local position = beamObj.Beam:Clone()
		position.Parent = parent
		local managedObj_2 = beamObj.Torso:Clone()
		managedObj_2.Parent = parent
		local l_v43_Attribute_0 = parent:GetAttribute("1x1x1x1Index")
		connections[l_v43_Attribute_0] = {
			beam = position,
			target = nil
		}
		local val5 = Observers.observeTag("1x1x1x1PlayerVFX", function(getAttributeObj)

			if getAttributeObj == parent then

				return nil
			elseif getAttributeObj:GetAttribute("1x1x1x1Index") ~= parent:GetAttribute("1x1x1x1Index") % 4 + 1 then

				return nil
			else
				local attachment = Instance.new("Attachment")
				attachment.Position = position.WorldPosition
				attachment.Parent = workspace.Terrain
				local attribute_2 = connections[parent:GetAttribute("1x1x1x1Index")]
				attribute_2.target = getAttributeObj
				attribute_2.beam.First.Attachment0 = attachment
				attribute_2.beam.Second.Attachment0 = attachment
				attribute_2.targetAttachment = attachment

				return function()

					attachment:Destroy()
				end
			end
		end)
		val2 = 0

		return function()

			managedObj_2:Destroy()
			position:Destroy()
			val5()
			connections[l_v43_Attribute_0] = nil
		end
	end))
end

local function _(loadAnimationObj, val6, val7)

	local v55Track = loadAnimationObj:LoadAnimation(val6);
	(val7 or managedObj):Add(function()

		v55Track:Stop(0)
		v55Track:Destroy()
	end)

	return v55Track
end

data.OnStart = function(_)

	assert((EventController:GetActiveEventData(Name)))
	managedObj:Add(task.spawn(initActivationVisual))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	Observers.observeTag("1x1x1x1Map", function(val8)

		local addObj = Trove.new()
		addObj:Add(Observers.observeTag("HideIn1x1x1x1", function(ref1)
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
		local flag = nil
		addObj:Add(Timer.Simple(0.25, function()

			if not LocalPlayer.Character then
				return
			else
				if MathUtils.isPointInVolume(CurrentCamera.CFrame.Position, val1, (Vector3.new(129, 52, 169.26400756835938, 0))) then
					if not flag then
						flag = Observers.observeTag("MapVFX", function(ref2)
							local Parent_2 = ref2.Parent
							ref2.Parent = script

							return function()

								pcall(function()

									ref2.Parent = Parent_2
								end)
							end
						end, {
							workspace,
							script
						})
						return
					end
				elseif flag then
					flag()
					flag = nil
				end
				return
			end
		end))
		addObj:Add(function()

			if flag then
				flag()
				flag = nil
			end
		end)
		addObj:Add(Observers.observeTag("1x1x1x1Latch", function(getPivotObj)

			local l_v69_Pivot_0 = getPivotObj:GetPivot()

			return Observers.observeAttribute(getPivotObj, "Open", function(flag_2)

				if not flag_2 then
					Spr.target(getPivotObj, 0.75, 3.5, {
						Pivot = l_v69_Pivot_0
					})
					SoundController:PlaySound(script.Door, l_v69_Pivot_0.Position, false)
				else
					Spr.target(getPivotObj, 0.75, 3.5, {
						Pivot = l_v69_Pivot_0 * CFrame.Angles(0, -1.5707963267948966, 0)
					})
					SoundController:PlaySound(script.Door, l_v69_Pivot_0.Position, false)
				end

				return function()

					if getPivotObj:IsDescendantOf(workspace) then
						Spr.target(getPivotObj, 0.75, 3.5, {
							Pivot = l_v69_Pivot_0
						})
						SoundController:PlaySound(script.Door, l_v69_Pivot_0.Position, false)
					end
				end
			end)
		end, {
			val8
		}))

		return addObj:WrapClean()
	end)
end

return data
