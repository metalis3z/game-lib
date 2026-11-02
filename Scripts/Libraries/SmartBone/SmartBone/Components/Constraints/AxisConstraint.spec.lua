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
local AxisConstraint = require(script.Parent:WaitForChild("AxisConstraint"))

return function() --[[ Line: 3 | Upvalues: AxisConstraint (copy) ]]
	local t = {
		Radius = 0,
		XAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		YAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		ZAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
		AxisLocked = { false, false, false },
		ClipVelocity = function() --[[ ClipVelocity | Line: 10 ]] end
	}

	afterEach(function() --[[ Line: 13 | Upvalues: t (copy) ]]
		t.AxisLocked = { false, false, false }
	end)
	describe("Axis Lock", function() --[[ Line: 17 | Upvalues: t (copy), AxisConstraint (ref) ]]
		it("Should lock X Axis", function() --[[ Line: 18 | Upvalues: t (ref), AxisConstraint (ref) ]]
			t.AxisLocked = { true, false, false }
			expect(AxisConstraint(t, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity).X).to.equal(0)
		end)
		it("Should lock Y Axis", function() --[[ Line: 26 | Upvalues: t (ref), AxisConstraint (ref) ]]
			t.AxisLocked = { false, true, false }
			expect(AxisConstraint(t, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity).Y).to.equal(0)
		end)
		it("Should lock Z Axis", function() --[[ Line: 34 | Upvalues: t (ref), AxisConstraint (ref) ]]
			t.AxisLocked = { false, false, true }
			expect(AxisConstraint(t, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity).Z).to.equal(0)
		end)
	end)
	describe("Axis Limit", function() --[[ Line: 43 | Upvalues: t (copy), AxisConstraint (ref) ]]
		describe("Should limit X Axis", function() --[[ Line: 44 | Upvalues: t (ref), AxisConstraint (ref) ]]
			it("Min Limit", function() --[[ Line: 45 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.XAxisLimits = NumberRange.new(-5, (1 / 0))
				expect(AxisConstraint(t, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity).X).to.equal(-5)
			end)
			it("Max Limit", function() --[[ Line: 53 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.XAxisLimits = NumberRange.new((-1 / 0), 5)
				expect(AxisConstraint(t, Vector3.new(10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity).X).to.equal(5)
			end)
		end)
		describe("Should limit Y Axis", function() --[[ Line: 62 | Upvalues: t (ref), AxisConstraint (ref) ]]
			it("Min Limit", function() --[[ Line: 63 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.YAxisLimits = NumberRange.new(-5, (1 / 0))
				expect(AxisConstraint(t, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity).Y).to.equal(-5)
			end)
			it("Max Limit", function() --[[ Line: 71 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.YAxisLimits = NumberRange.new((-1 / 0), 5)
				expect(AxisConstraint(t, Vector3.new(0, 10, 0), Vector3.new(0, 0, 0), CFrame.identity).Y).to.equal(5)
			end)
		end)
		describe("Should limit Z Axis", function() --[[ Line: 80 | Upvalues: t (ref), AxisConstraint (ref) ]]
			it("Min Limit", function() --[[ Line: 81 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.ZAxisLimits = NumberRange.new(-5, (1 / 0))
				expect(AxisConstraint(t, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity).Z).to.equal(-5)
			end)
			it("Max Limit", function() --[[ Line: 89 | Upvalues: t (ref), AxisConstraint (ref) ]]
				t.ZAxisLimits = NumberRange.new((-1 / 0), 5)
				expect(AxisConstraint(t, Vector3.new(0, 0, 10), Vector3.new(0, 0, 0), CFrame.identity).Z).to.equal(5)
			end)
		end)
	end)
end