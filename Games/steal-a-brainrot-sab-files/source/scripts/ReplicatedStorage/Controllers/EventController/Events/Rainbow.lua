
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

require(ReplicatedStorage.Shared.EventTypes)

local RainbowEvent = {}

require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(ReplicatedStorage.Packages.Net)

local VFX = require(ReplicatedStorage.Shared.VFX)
local ScriptName = script.Name
local RainbowModel = workspace.Events.Rainbow

if ServerData.IsBiggerServer() then
	RainbowModel:PivotTo(CFrame.new(-385.131, 18.845, -292.449) * CFrame.fromOrientation(0.0586954227445693, -1.0170033551370958, 0.4295604355008444))
end

local EventTrove = Trove.new()

function RainbowEvent.OnStart(_)
	CycleController:Update()
	SoundController:UpdateOST()

	VFX.emit(RainbowModel.Emit)

	EventTrove:Add(task.spawn(function()
		SoundController:PlaySound("Sounds.Sfx.RainbowActivatedEffect", RainbowModel.SoundParts.RainbowActivatedEffect.Position)
	end))

	EventTrove:Add(task.spawn(function()
		SoundController:PlaySound("Sounds.Sfx.RainbowMachineEnabled", RainbowModel.SoundParts.RainbowMachineEnabled.Position)
	end))

	EventTrove:Add(Observers.observeTag("RainbowEventAttachment", function(attachment)
		local fullTransparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) })
		local children = attachment:GetChildren()

		for _, child in children do
			child.Transparency = fullTransparency
			child.Enabled = true
		end

		local startTime = workspace:GetServerTimeNow()

		while attachment:IsDescendantOf(workspace) do
			local currentTime = workspace:GetServerTimeNow()
			local progress = (currentTime - startTime) % 3.5 / 3.5

			local fadeSequence = NumberSequence.new({ 
				NumberSequenceKeypoint.new(0, 1), 
				NumberSequenceKeypoint.new(1 - progress, 1), 
				NumberSequenceKeypoint.new(1, 0) 
			})

			if currentTime - startTime >= 3.5 then
				for _, child in children do
					child.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
				end
				break
			end

			for _, child in children do
				child.Transparency = fadeSequence
			end
			task.wait()
		end
		return nil
	end, { workspace }))

	EventTrove:Add(Observers.observeChildren(RainbowModel.Enabled, function(vfxInstance)
		VFX.enable(vfxInstance)
		return function()
			VFX.disable(vfxInstance)
		end
	end))
end

function RainbowEvent.OnStop(_)
	EventTrove:Destroy()
end

function RainbowEvent.OnLoad(_) 
end

return RainbowEvent