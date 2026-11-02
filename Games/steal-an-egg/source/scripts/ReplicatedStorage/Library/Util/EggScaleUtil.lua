-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local t = {
	ClampSavedScale = function(p1) --[[ ClampSavedScale | Line: 25 | Upvalues: Asserts (copy) ]]
		Asserts.finite(p1)

		return math.clamp(p1, 0.002, 200)
	end
}

function t.GetFitScaleForContainer(p1, p2) --[[ GetFitScaleForContainer | Line: 31 | Upvalues: Asserts (copy), BBFromModelVisibleOnly (copy), t (copy) ]]
	Asserts.Model(p1)
	Asserts.finiteVector3(p2)

	local _, v1 = BBFromModelVisibleOnly(p1)
	local v5 = math.min(p2.X / math.max(v1.X, 0.002), p2.Y / math.max(v1.Y, 0.002), p2.Z / math.max(v1.Z, 0.002)) * 0.92

	return t.ClampSavedScale(p1:GetScale() * v5)
end
function t.GetRawVisualScale(p1, p2) --[[ GetRawVisualScale | Line: 45 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p1)
	Asserts.finite(p2)

	return p1 * math.max(p2, 0.002)
end
function t.ClampRenderedScale(p1, p2) --[[ ClampRenderedScale | Line: 52 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p1)
	Asserts.finite(p2)

	return math.max(p1 * 0.6, p2)
end
function t.GetPreGrowthVisualScale(p1, p2) --[[ GetPreGrowthVisualScale | Line: 59 | Upvalues: t (copy) ]]
	return math.clamp(t.GetRawVisualScale(p1, p2), p1 * 0.6, p1 * 8)
end
function t.GetPlacedStartScale(p1, p2) --[[ GetPlacedStartScale | Line: 68 | Upvalues: t (copy) ]]
	return t.GetPreGrowthVisualScale(p1, p2)
end
function t.GetPlacedTargetScale(p1, p2) --[[ GetPlacedTargetScale | Line: 72 | Upvalues: t (copy) ]]
	local v1 = t.GetRawVisualScale(p1, p2)
	local v2 = p1 * 0.6

	if v1 < v2 then
		return v2
	end

	return v1 * 3
end

return t