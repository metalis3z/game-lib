-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)
require(script.Parent.Types.Interface)

local v1 = Color3.fromRGB(255, 255, 255)
local t = {
	StepId = "StealEgg",
	IsSatisfied = function(p1) --[[ IsSatisfied | Line: 25 ]]
		return p1:HasStolenFirstEgg() and not p1:IsLocalPlayerInGameplay()
	end
}

function t.Bind(p1, p2) --[[ Bind | Line: 29 | Upvalues: t (copy), RunService (copy) ]]
	local v1 = 0
	local v2 = false

	local function refresh() --[[ refresh | Line: 33 | Upvalues: v2 (ref), t (ref), p1 (copy), p2 (copy) ]]
		if not v2 and t.IsSatisfied(p1) then
			v2 = true
			p2()
		end
	end

	local v3 = p1.Changed:Connect(refresh)
	local v4 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 43 | Upvalues: v1 (ref), v2 (ref), t (ref), p1 (copy), p2 (copy) ]]
		v1 = v1 + p12

		if v1 < 0.1 then
			return
		end

		v1 = 0

		if v2 then
			return
		end

		if not t.IsSatisfied(p1) then
			return
		end

		v2 = true
		p2()
	end)

	task.defer(refresh)

	return function() --[[ Line: 54 | Upvalues: v3 (copy), v4 (copy) ]]
		v3:Disconnect()
		v4:Disconnect()
	end
end
function t.Present(p1, p2) --[[ Present | Line: 60 | Upvalues: t (copy), v1 (copy), RunService (copy) ]]
	local function refreshPresentation() --[[ refreshPresentation | Line: 64 | Upvalues: t (ref), p2 (copy), p1 (copy), v1 (ref) ]]
		if t.IsSatisfied(p2) then
			p1:ClearAll()

			return
		end

		if p2:IsCarryingAreaEgg() or p2:HasStolenFirstEgg() then
			p1:ClearMessage()
			p1:UpdateBeamTarget(p2:GetGameplayExitTarget())

			return
		end

		local v12 = p2:GetClosestAreaEggTarget()

		if v12 == nil then
			p1:ClearBeam()
			p1:ShowAnimatedMessage("Steal an Egg!", v1)
		else
			p1:ShowAnimatedMessage("Steal an Egg!", v1)
			p1:UpdateBeamTarget(v12)
		end
	end

	local function refreshMovingExitTarget() --[[ refreshMovingExitTarget | Line: 87 | Upvalues: t (ref), p2 (copy), p1 (copy) ]]
		if t.IsSatisfied(p2) then
			p1:ClearAll()

			return
		end

		if p2:IsCarryingAreaEgg() or p2:HasStolenFirstEgg() then
			p1:ClearMessage()
			p1:UpdateBeamTarget(p2:GetGameplayExitTarget())
		end
	end

	local v12 = p2.Changed:Connect(refreshPresentation)
	local v2 = 0
	local v3 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 103 | Upvalues: v2 (ref), refreshMovingExitTarget (copy) ]]
		v2 = v2 + p1

		if not (v2 < 0.1) then
			v2 = 0
			refreshMovingExitTarget()
		end
	end)

	refreshPresentation()

	return function() --[[ Line: 114 | Upvalues: v12 (copy), v3 (copy), p1 (copy) ]]
		v12:Disconnect()
		v3:Disconnect()
		p1:ClearAll()
	end
end

return t