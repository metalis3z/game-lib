-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)
require(script.Parent.Types.Interface)

local v1 = Color3.fromRGB(255, 255, 255)

return {
	StepId = "TreadmillIntro",
	IsSatisfied = function(p1) --[[ IsSatisfied | Line: 24 ]]
		return p1:HasFinishedTreadmillIntro()
	end,
	Bind = function(p1, p2) --[[ Bind | Line: 28 ]]
		local v1 = false

		task.delay(7, function() --[[ Line: 30 | Upvalues: v1 (ref), p1 (copy), p2 (copy) ]]
			if not v1 then
				p1:MarkTreadmillIntroFinished()
				p2()
			end
		end)

		return function() --[[ Line: 38 | Upvalues: v1 (ref) ]]
			v1 = true
		end
	end,
	Present = function(p1, p2) --[[ Present | Line: 43 | Upvalues: v1 (copy) ]]
		p1:ShowAnimatedMessage("Use your treadmill to become faster!", v1)

		return function() --[[ Line: 49 | Upvalues: p1 (copy) ]]
			p1:ClearAll()
		end
	end
}