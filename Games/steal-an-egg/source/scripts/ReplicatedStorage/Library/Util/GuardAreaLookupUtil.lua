-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script.Types.Interface)

local t = {}

local function signedDistanceFromLine(p1, p2) --[[ signedDistanceFromLine | Line: 17 ]]
	return p1.CFrame.LookVector:Dot(p2 - p1.Position)
end

function t.GetSignedDistanceFromLinePart(p1, p2) --[[ GetSignedDistanceFromLinePart | Line: 25 | Upvalues: Asserts (copy), signedDistanceFromLine (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Vector3(p2)

	return signedDistanceFromLine(p1, p2)
end
function t.IsInGameplaySide(p1, p2) --[[ IsInGameplaySide | Line: 32 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Vector3(p2)

	return p1.CFrame.LookVector:Dot(p2 - p1.Position) > 0
end
function t.IsWorldPositionInsideXZBounds(p1, p2) --[[ IsWorldPositionInsideXZBounds | Line: 39 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Vector3(p2)

	local v1 = p1.CFrame:PointToObjectSpace(p2)
	local v2 = p1.Size * 0.5

	return if math.abs(v1.X) <= v2.X then math.abs(v1.Z) <= v2.Z else false
end
function t.ResolveAreaBoundsEntries(p1) --[[ ResolveAreaBoundsEntries | Line: 49 | Upvalues: Asserts (copy) ]]
	Asserts.Instance(p1)
	assert(p1:IsA("Folder"), "GuardAreas must be a Folder")

	local t = {}

	for i, v in ipairs(p1:GetChildren()) do
		local v2 = v:IsA("Model")

		assert(v2, (("%* must be a Model"):format((v:GetFullName()))))

		local Bounds = v.Bounds
		local v4 = Bounds:IsA("BasePart")

		assert(v4, (("%*.Bounds must be a BasePart"):format((v:GetFullName()))))
		t[#t + 1] = {
			AreaId = v.Name,
			Bounds = Bounds
		}
	end

	assert(#t > 0, "Expected at least one guard area")

	return t
end
function t.HasCrossedGameplayEntryBoundary(p1, p2, p3) --[[ HasCrossedGameplayEntryBoundary | Line: 70 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Vector3(p2)
	Asserts.Vector3(p3)

	return if p1.CFrame.LookVector:Dot(p2 - p1.Position) <= 0 then p1.CFrame.LookVector:Dot(p3 - p1.Position) > 0 else false
end
function t.HasCrossedGameplayExitBoundary(p1, p2, p3) --[[ HasCrossedGameplayExitBoundary | Line: 83 | Upvalues: Asserts (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Vector3(p2)
	Asserts.Vector3(p3)

	return if p1.CFrame.LookVector:Dot(p2 - p1.Position) > 0 then p1.CFrame.LookVector:Dot(p3 - p1.Position) <= 0 else false
end

return t