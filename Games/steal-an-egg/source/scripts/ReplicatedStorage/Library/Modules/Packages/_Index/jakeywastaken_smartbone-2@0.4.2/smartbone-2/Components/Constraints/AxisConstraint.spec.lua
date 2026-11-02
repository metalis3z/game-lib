-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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