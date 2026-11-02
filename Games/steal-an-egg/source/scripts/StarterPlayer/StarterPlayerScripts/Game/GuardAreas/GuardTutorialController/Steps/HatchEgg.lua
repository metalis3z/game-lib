-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)

local StepUtils = require(script.Parent.Parent.StepUtils)

require(script.Parent.Types.Interface)

local v1 = Color3.fromRGB(255, 255, 255)
local t = {
	StepId = "HatchEgg",
	IsSatisfied = function(p1) --[[ IsSatisfied | Line: 26 ]]
		return p1:HasHatchedEgg()
	end
}

function t.Bind(p1, p2) --[[ Bind | Line: 30 | Upvalues: StepUtils (copy), t (copy) ]]
	return StepUtils.BindOnAdapterChanged(p1, t.IsSatisfied, p2)
end
function t.Present(p1, p2) --[[ Present | Line: 34 | Upvalues: t (copy), v1 (copy), RunService (copy) ]]
	local function refreshPresentation() --[[ refreshPresentation | Line: 38 | Upvalues: t (ref), p2 (copy), p1 (copy), v1 (ref) ]]
		if t.IsSatisfied(p2) then
			p1:ClearAll()

			return
		end

		if not p2:HasHatchableEgg() then
			p1:ClearAll()

			return
		end

		p1:ShowAnimatedMessage("Hatch the Egg!", v1)

		local v12 = p2:GetNearestHatchableEggTarget()

		if v12 == nil then
			p1:ClearBeam()
		else
			p1:UpdateBeamTarget(v12)
		end
	end

	local v12 = p2.Changed:Connect(refreshPresentation)
	local v2 = 0
	local v3 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 60 | Upvalues: v2 (ref), refreshPresentation (copy) ]]
		v2 = v2 + p1

		if not (v2 < 0.25) then
			v2 = 0
			refreshPresentation()
		end
	end)

	refreshPresentation()

	return function() --[[ Line: 71 | Upvalues: v12 (copy), v3 (copy), p1 (copy) ]]
		v12:Disconnect()
		v3:Disconnect()
		p1:ClearAll()
	end
end

return t