-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)

local StepUtils = require(script.Parent.Parent.StepUtils)

require(script.Parent.Types.Interface)

local v1 = Color3.fromRGB(255, 255, 255)
local t = {
	StepId = "PlaceEgg",
	IsSatisfied = function(p1) --[[ IsSatisfied | Line: 24 ]]
		return p1:HasPlacedEgg()
	end
}

function t.Bind(p1, p2) --[[ Bind | Line: 28 | Upvalues: StepUtils (copy), t (copy) ]]
	return StepUtils.BindOnAdapterChanged(p1, t.IsSatisfied, p2)
end
function t.Present(p1, p2) --[[ Present | Line: 32 | Upvalues: t (copy), v1 (copy) ]]
	local function refreshPresentation() --[[ refreshPresentation | Line: 36 | Upvalues: t (ref), p2 (copy), p1 (copy), v1 (ref) ]]
		if t.IsSatisfied(p2) then
			p1:ClearAll()

			return
		end

		p1:ShowAnimatedMessage("Place your Egg!", v1)

		local v12 = p2:GetEggPlacementBillboardCFrame()

		if v12 == nil then
			return
		end

		p1:ShowBillboardClick(v12)
	end

	local v12 = p2.Changed:Connect(refreshPresentation)

	if t.IsSatisfied(p2) then
		p1:ClearAll()
	else
		p1:ShowAnimatedMessage("Place your Egg!", v1)

		local v2 = p2:GetEggPlacementBillboardCFrame()

		if v2 ~= nil then
			p1:ShowBillboardClick(v2)
		end
	end

	return function() --[[ Line: 52 | Upvalues: v12 (copy), p1 (copy) ]]
		v12:Disconnect()
		p1:ClearAll()
	end
end

return t