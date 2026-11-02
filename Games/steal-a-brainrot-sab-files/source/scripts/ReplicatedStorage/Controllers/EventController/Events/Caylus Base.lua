
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}

require(ReplicatedStorage.Packages.Net)

local Trove = require(ReplicatedStorage.Packages.Trove)
local Observers = require(ReplicatedStorage.Packages.Observers)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Parent = require(script.Parent.Parent)
local WorldBrainrotController = require(ReplicatedStorage.Controllers.WorldBrainrotController)
local scriptName = script.Name
local v9 = Trove.new()
local STEP_STAGGER_DELAY = 0.25
local TWEEN_DURATION = 0.5

function t1.OnStart(_)
	assert((Parent:GetActiveEventData(scriptName)))
	v9:Add(Observers.observeTag("SammyBaseStep", function(stepPart)
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
	v9:Add(Observers.observeTag("HideInSteaksBase", function(p3)
		local p3Parent = p3.Parent

		p3.Parent = script

		return function()
			pcall(function()
				p3.Parent = p3Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	v9:Add(WorldBrainrotController:RenderPool({
		PoolId = "CaylusBase",
		ReplicatorId = "CaylusBase",
		ShowTimer = false,
		ShowDropButton = false,
		GrabHoldDuration = 1.5,
		GrabMaxDistance = 10,
		KeepWhenGrabbed = true
	}))
end
function t1.OnStop(_)
	v9:Destroy()
end
function t1.OnLoad(_)
end

return t1
