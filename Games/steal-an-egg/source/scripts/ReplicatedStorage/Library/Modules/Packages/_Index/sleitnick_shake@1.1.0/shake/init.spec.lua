-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

local function AwaitStop(p1) --[[ AwaitStop | Line: 3 ]]
	local v1 = os.clock()

	p1:Update()

	while p1:IsShaking() do
		task.wait()
		p1:Update()
	end

	return os.clock() - v1
end

return function() --[[ Line: 13 | Upvalues: AwaitStop (copy), RunService (copy) ]]
	local v1 = require(script.Parent)

	describe("Construct", function() --[[ Line: 16 | Upvalues: v1 (copy) ]]
		it("should construct a new shake instance", function() --[[ Line: 17 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 18 | Upvalues: v1 (ref) ]]
				v1.new()
			end).to.never.throw()
		end)
	end)
	describe("Static Functions", function() --[[ Line: 24 | Upvalues: v1 (copy) ]]
		it("should get next render name", function() --[[ Line: 25 | Upvalues: v1 (ref) ]]
			local v12 = v1.NextRenderName()
			local v2 = v1.NextRenderName()
			local v3 = v1.NextRenderName()

			expect(v12).to.be.a("string")
			expect(v2).to.be.a("string")
			expect(v3).to.be.a("string")
			expect(v12).to.never.equal(v2)
			expect(v2).to.never.equal(v3)
			expect(v3).to.never.equal(v12)
		end)
		it("should perform inverse square", function() --[[ Line: 37 | Upvalues: v1 (ref) ]]
			local v12 = v1.InverseSquare(Vector3.new(10, 10, 10), 10)

			expect((typeof(v12))).to.equal("Vector3")
			expect(v12).to.equal(Vector3.new(0.099999994, 0.099999994, 0.099999994))
		end)
	end)
	describe("Cloning", function() --[[ Line: 48 | Upvalues: v1 (copy) ]]
		it("should clone a shake instance", function() --[[ Line: 49 | Upvalues: v1 (ref) ]]
			local v12 = v1.new()

			v12.Amplitude = 5
			v12.Frequency = 2
			v12.FadeInTime = 3
			v12.FadeOutTime = 4
			v12.SustainTime = 6
			v12.Sustain = true
			v12.PositionInfluence = Vector3.new(1, 2, 3)
			v12.RotationInfluence = Vector3.new(3, 2, 1)
			function v12.TimeFunction() --[[ Line: 59 ]]
				return os.clock()
			end

			local v2 = v12:Clone()

			expect(v2).to.be.a("table")
			expect((getmetatable(v2))).to.equal(v1)
			expect(v2).to.never.equal(v12)

			for i, v in ipairs({
				"Amplitude",
				"Frequency",
				"FadeInTime",
				"FadeOutTime",
				"SustainTime",
				"Sustain",
				"PositionInfluence",
				"RotationInfluence",
				"TimeFunction"
			}) do
				expect(v12[v]).to.equal(v2[v])
			end
		end)
		it("should clone a shake instance but ignore running state", function() --[[ Line: 82 | Upvalues: v1 (ref) ]]
			local v12 = v1.new()

			v12:Start()

			local v2 = v12:Clone()

			expect(v12:IsShaking()).to.equal(true)
			expect(v2:IsShaking()).to.equal(false)
		end)
	end)
	describe("Shaking", function() --[[ Line: 91 | Upvalues: v1 (copy), AwaitStop (ref), RunService (ref) ]]
		it("should start", function() --[[ Line: 92 | Upvalues: v1 (ref) ]]
			local v12 = v1.new()

			expect(v12:IsShaking()).to.equal(false)
			v12:Start()
			expect(v12:IsShaking()).to.equal(true)
		end)
		it("should stop", function() --[[ Line: 99 | Upvalues: v1 (ref) ]]
			local v12 = v1.new()

			v12:Start()
			expect(v12:IsShaking()).to.equal(true)
			v12:Stop()
			expect(v12:IsShaking()).to.equal(false)
		end)
		it("should shake for nearly no time", function() --[[ Line: 107 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0
			v12.SustainTime = 0
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0, 0.05)
		end)
		it("should shake for fade in time", function() --[[ Line: 117 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0.1
			v12.FadeOutTime = 0
			v12.SustainTime = 0
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.1, 0.05)
		end)
		it("should shake for fade out time", function() --[[ Line: 127 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.1, 0.05)
		end)
		it("should shake for sustain time", function() --[[ Line: 137 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0
			v12.SustainTime = 0.1
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.1, 0.05)
		end)
		it("should shake for fade in and sustain time", function() --[[ Line: 147 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0.1
			v12.FadeOutTime = 0
			v12.SustainTime = 0.1
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.2, 0.05)
		end)
		it("should shake for fade out and sustain time", function() --[[ Line: 157 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0.1
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.2, 0.05)
		end)
		it("should shake for fade in and fade out time", function() --[[ Line: 167 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0.1
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.2, 0.05)
		end)
		it("should shake for fading and sustain time", function() --[[ Line: 177 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0.1
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0.1
			v12:Start()
			expect((AwaitStop(v12))).to.be.near(0.3, 0.05)
		end)
		it("should shake indefinitely", function() --[[ Line: 187 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0
			v12.SustainTime = 0
			v12.Sustain = true
			v12:Start()
			task.delay(0.1, function() --[[ Line: 195 | Upvalues: v12 (copy) ]]
				v12:StopSustain()
			end)
			expect((AwaitStop(v12))).to.be.near(0.1, 0.05)
		end)
		it("should shake indefinitely and fade out", function() --[[ Line: 202 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0
			v12.Sustain = true
			v12:Start()
			task.delay(0.1, function() --[[ Line: 210 | Upvalues: v12 (copy) ]]
				v12:StopSustain()
			end)
			expect((AwaitStop(v12))).to.be.near(0.2, 0.05)
		end)
		it("should shake indefinitely and fade out with fade in time", function() --[[ Line: 217 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.FadeInTime = 0.1
			v12.FadeOutTime = 0.1
			v12.SustainTime = 0
			v12.Sustain = true
			v12:Start()
			task.delay(0.3, function() --[[ Line: 225 | Upvalues: v12 (copy) ]]
				v12:StopSustain()
			end)
			expect((AwaitStop(v12))).to.be.near(0.4, 0.05)
		end)
		it("should connect to signal", function() --[[ Line: 232 | Upvalues: v1 (ref), RunService (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.SustainTime = 0.1
			v12:Start()

			local v2 = false
			local v3 = v12:OnSignal(RunService.Heartbeat, function() --[[ Line: 237 | Upvalues: v2 (ref) ]]
				v2 = true
			end)

			expect((typeof(v3))).to.equal("RBXScriptConnection")
			expect(v3.Connected).to.equal(true)
			AwaitStop(v12)
			expect(v2).to.equal(true)
			expect(v3.Connected).to.equal(false)
		end)
		it("should bind to render step", function() --[[ Line: 247 | Upvalues: v1 (ref), AwaitStop (ref) ]]
			local v12 = v1.new()

			v12.SustainTime = 0.1
			v12:Start()

			local v2 = false

			v12:BindToRenderStep("ShakeTest", Enum.RenderPriority.Last.Value, function() --[[ Line: 252 | Upvalues: v2 (ref) ]]
				v2 = true
			end)
			AwaitStop(v12)
			expect(v2).to.equal(true)
		end)
	end)
end