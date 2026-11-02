-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)

local StepUtils = require(script.Parent.Parent.StepUtils)

require(script.Parent.Types.Interface)

local t = {
	StepId = "EquipEgg",
	IsSatisfied = function(p1) --[[ IsSatisfied | Line: 21 ]]
		return p1:HasEquippedEgg()
	end
}

function t.Bind(p1, p2) --[[ Bind | Line: 25 | Upvalues: StepUtils (copy), t (copy) ]]
	return StepUtils.BindOnAdapterChanged(p1, t.IsSatisfied, p2)
end
function t.Present(p1, p2) --[[ Present | Line: 29 | Upvalues: t (copy) ]]
	local function refreshPresentation() --[[ refreshPresentation | Line: 33 | Upvalues: t (ref), p2 (copy), p1 (copy) ]]
		if t.IsSatisfied(p2) then
			p1:ClearAll()

			return
		end

		local v1 = p2:ForceBestEggIntoHotbar() or p2:GetEggHotbarTarget()

		if v1 == nil then
			p1:ClearHighlight()
		else
			p1:ShowHighlight(v1)
		end
	end

	local v1 = p2.Changed:Connect(refreshPresentation)

	refreshPresentation()

	return function() --[[ Line: 50 | Upvalues: v1 (copy), p1 (copy) ]]
		v1:Disconnect()
		p1:ClearAll()
	end
end

return t