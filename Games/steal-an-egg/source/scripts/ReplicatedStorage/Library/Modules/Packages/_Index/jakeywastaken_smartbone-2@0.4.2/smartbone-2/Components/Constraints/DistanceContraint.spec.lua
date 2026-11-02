-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DistanceConstraint = require(script.Parent:WaitForChild("DistanceConstraint"))

local function CreateBone(p1, p2, p3) --[[ CreateBone | Line: 3 ]]
	return {
		Position = p1,
		FreeLength = p2,
		ParentIndex = p3
	}
end

return function() --[[ Line: 11 | Upvalues: DistanceConstraint (copy) ]]
	local t = {
		Bones = {
			{
				Position = Vector3.new(0, 0, 0),
				FreeLength = 3,
				ParentIndex = 0
			},
			{
				Position = Vector3.new(0, 1, 0),
				FreeLength = 3,
				ParentIndex = 1
			}
		}
	}

	describe("Distance Constraint", function() --[[ Line: 19 | Upvalues: t (copy), DistanceConstraint (ref) ]]
		local v1 = t.Bones[2]

		local function Callback() --[[ Callback | Line: 22 | Upvalues: DistanceConstraint (ref), v1 (copy), t (ref) ]]
			local v12 = DistanceConstraint(v1, v1.Position, t)

			expect(v12.Magnitude).to.equal(v1.FreeLength)
			v1.Position = v12
		end

		for i = 1, 10 do
			it(("Should limit to %* studs #%*"):format(v1.FreeLength, i), Callback)
			v1.FreeLength = math.random(1, 20)
		end
	end)
end