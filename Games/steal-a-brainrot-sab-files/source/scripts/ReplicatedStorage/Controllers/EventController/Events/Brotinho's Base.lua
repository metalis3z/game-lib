local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

require(ReplicatedStorage.Shared.EventTypes)

local BrotinhoBaseController = {}

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Observers = require(ReplicatedStorage.Packages.Observers)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)

local EventModule = require(script.Parent.Parent)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)

local SCRIPT_NAME = script.Name
local ScriptTrove = Trove.new()

local STEP_STAGGER_DELAY = 0.25
local TWEEN_DURATION = 0.5

function BrotinhoBaseController.OnStart(_)
	SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammy's Base"].Stairs, nil, true)

	local eventData = EventModule:GetActiveEventData(SCRIPT_NAME)
	assert(eventData, "Failed to load Event Data for " .. SCRIPT_NAME)

	ScriptTrove:Add(Observers.observeTag("SammyBaseStep", function(stepPart)
		local stepIndex = stepPart:GetAttribute("Index") or 0
		local targetPosition = stepPart.Position
		local xOffset = -(stepIndex % 1 * 2 - 1) * 2

		stepPart.Transparency = 1
		stepPart.Position = targetPosition + Vector3.new(xOffset, 0, 0)

		task.delay(stepIndex * STEP_STAGGER_DELAY, function()
			if stepPart and stepPart.Parent then
				CreateTween(stepPart, TweenInfo.new(TWEEN_DURATION, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					["Transparency"] = 0,
					["Position"] = targetPosition
				})
			end
		end)

		return nil
	end))

	ScriptTrove:Add(Observers.observeTag("HideInSammysBase", function(objectToHide)
		local originalParent = objectToHide.Parent
		objectToHide.Parent = script

		return function()
			pcall(function()
				objectToHide.Parent = originalParent
			end)
		end
	end, { workspace, script }))
end

function BrotinhoBaseController.OnStop(_)
	ScriptTrove:Destroy()
end

return BrotinhoBaseController