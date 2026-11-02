-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}
local t2 = {}

local function cframeInFrontOfRootClampedToArea(p1, p2) --[[ cframeInFrontOfRootClampedToArea | Line: 30 ]]
	local LookVector = p1.LookVector
	local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)

	assert(if v1.Magnitude > 0 then true else false, "Asset front placement requires a horizontal root facing direction")

	local Unit = v1.Unit
	local Size = p2.Size
	local v4 = math.max(Size.X * 0.5 - 1.75, 0)
	local v6 = math.max(Size.Z * 0.5 - 1.75, 0)
	local v8 = p2.CFrame:PointToObjectSpace(p1.Position + Unit * 6)
	local Position = (p2.CFrame * CFrame.new((Vector3.new(math.clamp(v8.X, -v4, v4), 0, (math.clamp(v8.Z, -v6, v6)))))).Position

	return CFrame.lookAt(Position, Position + Unit)
end

function t2.SetFrontPlacement(p1, p2) --[[ SetFrontPlacement | Line: 52 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.string(p1)
	Asserts.CFrame(p2)
	t[p1] = {
		RootCFrame = p2,
		ExpiresAt = os.clock() + 10
	}
end
function t2.ConsumeFrontPlacement(p1, p2) --[[ ConsumeFrontPlacement | Line: 62 | Upvalues: Asserts (copy), t (copy), cframeInFrontOfRootClampedToArea (copy) ]]
	Asserts.string(p1)
	Asserts.BasePart(p2)

	local v1 = t[p1]

	t[p1] = nil

	if v1 == nil or v1.ExpiresAt < os.clock() then
		return nil
	end

	return cframeInFrontOfRootClampedToArea(v1.RootCFrame, p2)
end
function t2.ClearFrontPlacement(p1) --[[ ClearFrontPlacement | Line: 75 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.string(p1)
	t[p1] = nil
end

return t2