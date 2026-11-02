--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local RopeConstraint = require(script.Parent:WaitForChild("RopeConstraint"))

local function CreateBone(p1, p2, p3) --[[ CreateBone | Line: 3 ]]
	return {
		Position = p1,
		FreeLength = p2,
		ParentIndex = p3
	}
end

return function() --[[ Line: 11 | Upvalues: RopeConstraint (copy) ]]
	local t = {
		Bones = {
			{
				Position = Vector3.new(0, 0, 0),
				FreeLength = 3,
				ParentIndex = 0
			},
			{
				Position = Vector3.new(0, 10, 0),
				FreeLength = 3,
				ParentIndex = 1
			}
		}
	}

	describe("Rope Constraint", function() --[[ Line: 19 | Upvalues: t (copy), RopeConstraint (ref) ]]
		local v1 = t.Bones[2]
		local v2 = 0
		local v3 = nil

		local function LimitCallback() --[[ LimitCallback | Line: 25 | Upvalues: RopeConstraint (ref), v1 (copy), t (ref), v3 (ref) ]]
			expect(RopeConstraint(v1, v1.Position, t).Magnitude).to.equal(v1.FreeLength)
			v1.FreeLength = math.random(1, 20)
			v3()
		end

		local function SameCallback() --[[ SameCallback | Line: 35 | Upvalues: RopeConstraint (ref), v1 (copy), t (ref), v3 (ref) ]]
			expect(RopeConstraint(v1, v1.Position, t).Magnitude).to.equal(v1.Position.Magnitude)
			v1.FreeLength = math.random(1, 20)
			v3()
		end

		v3 = function() --[[ Line: 45 | Upvalues: v2 (ref), v1 (copy), SameCallback (copy), LimitCallback (copy) ]]
			if v2 >= 10 then
				return
			end

			v2 = v2 + 1

			if v1.Position.Magnitude < v1.FreeLength then
				it(("Should stay the same #%*"):format(v2), SameCallback)
			else
				it(("Should limit to %* studs #%*"):format(v1.FreeLength, v2), LimitCallback)
			end
		end
		v3()
	end)
end