-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:26
-- Luau version 6, Types version 3
-- Time taken: 0.005487 seconds

local function AwaitStop_upvr(arg1) -- Line 3, Named "AwaitStop"
	arg1:Update()
	while arg1:IsShaking() do
		task.wait()
		arg1:Update()
	end
	return os.clock() - os.clock()
end
local RunService_upvr = game:GetService("RunService")
return function() -- Line 13
	--[[ Upvalues[2]:
		[1]: AwaitStop_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	local Parent_upvr = require(script.Parent)
	describe("Construct", function() -- Line 16
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should construct a new shake instance", function() -- Line 17
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 18
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
			end).to.never.throw()
		end)
	end)
	describe("Static Functions", function() -- Line 24
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should get next render name", function() -- Line 25
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_NextRenderName_result1_3 = Parent_upvr.NextRenderName()
			local any_NextRenderName_result1 = Parent_upvr.NextRenderName()
			local any_NextRenderName_result1_2 = Parent_upvr.NextRenderName()
			expect(any_NextRenderName_result1_3).to.be.a("string")
			expect(any_NextRenderName_result1).to.be.a("string")
			expect(any_NextRenderName_result1_2).to.be.a("string")
			expect(any_NextRenderName_result1_3).to.never.equal(any_NextRenderName_result1)
			expect(any_NextRenderName_result1).to.never.equal(any_NextRenderName_result1_2)
			expect(any_NextRenderName_result1_2).to.never.equal(any_NextRenderName_result1_3)
		end)
		it("should perform inverse square", function() -- Line 37
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_InverseSquare_result1 = Parent_upvr.InverseSquare(Vector3.new(10, 10, 10), 10)
			expect(typeof(any_InverseSquare_result1)).to.equal("Vector3")
			expect(any_InverseSquare_result1).to.equal(Vector3.new(0.09999, 0.09999, 0.09999))
		end)
	end)
	describe("Cloning", function() -- Line 48
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should clone a shake instance", function() -- Line 49
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_14 = Parent_upvr.new()
			any_new_result1_14.Amplitude = 5
			any_new_result1_14.Frequency = 2
			any_new_result1_14.FadeInTime = 3
			any_new_result1_14.FadeOutTime = 4
			any_new_result1_14.SustainTime = 6
			any_new_result1_14.Sustain = true
			any_new_result1_14.PositionInfluence = Vector3.new(1, 2, 3)
			any_new_result1_14.RotationInfluence = Vector3.new(3, 2, 1)
			function any_new_result1_14.TimeFunction() -- Line 59
				return os.clock()
			end
			local clone = any_new_result1_14:Clone()
			expect(clone).to.be.a("table")
			expect(getmetatable(clone)).to.equal(Parent_upvr)
			expect(clone).to.never.equal(any_new_result1_14)
			for _, v in ipairs({"Amplitude", "Frequency", "FadeInTime", "FadeOutTime", "SustainTime", "Sustain", "PositionInfluence", "RotationInfluence", "TimeFunction"}) do
				expect(any_new_result1_14[v]).to.equal(clone[v])
			end
		end)
		it("should clone a shake instance but ignore running state", function() -- Line 82
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_7 = Parent_upvr.new()
			any_new_result1_7:Start()
			expect(any_new_result1_7:IsShaking()).to.equal(true)
			expect(any_new_result1_7:Clone():IsShaking()).to.equal(false)
		end)
	end)
	describe("Shaking", function() -- Line 91
		--[[ Upvalues[3]:
			[1]: Parent_upvr (readonly)
			[2]: AwaitStop_upvr (copied, readonly)
			[3]: RunService_upvr (copied, readonly)
		]]
		it("should start", function() -- Line 92
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_6 = Parent_upvr.new()
			expect(any_new_result1_6:IsShaking()).to.equal(false)
			any_new_result1_6:Start()
			expect(any_new_result1_6:IsShaking()).to.equal(true)
		end)
		it("should stop", function() -- Line 99
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_8 = Parent_upvr.new()
			any_new_result1_8:Start()
			expect(any_new_result1_8:IsShaking()).to.equal(true)
			any_new_result1_8:Stop()
			expect(any_new_result1_8:IsShaking()).to.equal(false)
		end)
		it("should shake for nearly no time", function() -- Line 107
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_2 = Parent_upvr.new()
			any_new_result1_2.FadeInTime = 0
			any_new_result1_2.FadeOutTime = 0
			any_new_result1_2.SustainTime = 0
			any_new_result1_2:Start()
			expect(AwaitStop_upvr(any_new_result1_2)).to.be.near(0, 0.05)
		end)
		it("should shake for fade in time", function() -- Line 117
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_10 = Parent_upvr.new()
			any_new_result1_10.FadeInTime = 0.1
			any_new_result1_10.FadeOutTime = 0
			any_new_result1_10.SustainTime = 0
			any_new_result1_10:Start()
			expect(AwaitStop_upvr(any_new_result1_10)).to.be.near(0.1, 0.05)
		end)
		it("should shake for fade out time", function() -- Line 127
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_16 = Parent_upvr.new()
			any_new_result1_16.FadeInTime = 0
			any_new_result1_16.FadeOutTime = 0.1
			any_new_result1_16.SustainTime = 0
			any_new_result1_16:Start()
			expect(AwaitStop_upvr(any_new_result1_16)).to.be.near(0.1, 0.05)
		end)
		it("should shake for sustain time", function() -- Line 137
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_12 = Parent_upvr.new()
			any_new_result1_12.FadeInTime = 0
			any_new_result1_12.FadeOutTime = 0
			any_new_result1_12.SustainTime = 0.1
			any_new_result1_12:Start()
			expect(AwaitStop_upvr(any_new_result1_12)).to.be.near(0.1, 0.05)
		end)
		it("should shake for fade in and sustain time", function() -- Line 147
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_11 = Parent_upvr.new()
			any_new_result1_11.FadeInTime = 0.1
			any_new_result1_11.FadeOutTime = 0
			any_new_result1_11.SustainTime = 0.1
			any_new_result1_11:Start()
			expect(AwaitStop_upvr(any_new_result1_11)).to.be.near(0.2, 0.05)
		end)
		it("should shake for fade out and sustain time", function() -- Line 157
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_9 = Parent_upvr.new()
			any_new_result1_9.FadeInTime = 0
			any_new_result1_9.FadeOutTime = 0.1
			any_new_result1_9.SustainTime = 0.1
			any_new_result1_9:Start()
			expect(AwaitStop_upvr(any_new_result1_9)).to.be.near(0.2, 0.05)
		end)
		it("should shake for fade in and fade out time", function() -- Line 167
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_15 = Parent_upvr.new()
			any_new_result1_15.FadeInTime = 0.1
			any_new_result1_15.FadeOutTime = 0.1
			any_new_result1_15.SustainTime = 0
			any_new_result1_15:Start()
			expect(AwaitStop_upvr(any_new_result1_15)).to.be.near(0.2, 0.05)
		end)
		it("should shake for fading and sustain time", function() -- Line 177
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1 = Parent_upvr.new()
			any_new_result1.FadeInTime = 0.1
			any_new_result1.FadeOutTime = 0.1
			any_new_result1.SustainTime = 0.1
			any_new_result1:Start()
			expect(AwaitStop_upvr(any_new_result1)).to.be.near(0.3, 0.05)
		end)
		it("should shake indefinitely", function() -- Line 187
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_4_upvr = Parent_upvr.new()
			any_new_result1_4_upvr.FadeInTime = 0
			any_new_result1_4_upvr.FadeOutTime = 0
			any_new_result1_4_upvr.SustainTime = 0
			any_new_result1_4_upvr.Sustain = true
			any_new_result1_4_upvr:Start()
			task.delay(0.1, function() -- Line 195
				--[[ Upvalues[1]:
					[1]: any_new_result1_4_upvr (readonly)
				]]
				any_new_result1_4_upvr:StopSustain()
			end)
			expect(AwaitStop_upvr(any_new_result1_4_upvr)).to.be.near(0.1, 0.05)
		end)
		it("should shake indefinitely and fade out", function() -- Line 202
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_upvr = Parent_upvr.new()
			any_new_result1_upvr.FadeInTime = 0
			any_new_result1_upvr.FadeOutTime = 0.1
			any_new_result1_upvr.SustainTime = 0
			any_new_result1_upvr.Sustain = true
			any_new_result1_upvr:Start()
			task.delay(0.1, function() -- Line 210
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr (readonly)
				]]
				any_new_result1_upvr:StopSustain()
			end)
			expect(AwaitStop_upvr(any_new_result1_upvr)).to.be.near(0.2, 0.05)
		end)
		it("should shake indefinitely and fade out with fade in time", function() -- Line 217
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_13_upvr = Parent_upvr.new()
			any_new_result1_13_upvr.FadeInTime = 0.1
			any_new_result1_13_upvr.FadeOutTime = 0.1
			any_new_result1_13_upvr.SustainTime = 0
			any_new_result1_13_upvr.Sustain = true
			any_new_result1_13_upvr:Start()
			task.delay(0.3, function() -- Line 225
				--[[ Upvalues[1]:
					[1]: any_new_result1_13_upvr (readonly)
				]]
				any_new_result1_13_upvr:StopSustain()
			end)
			expect(AwaitStop_upvr(any_new_result1_13_upvr)).to.be.near(0.4, 0.05)
		end)
		it("should connect to signal", function() -- Line 232
			--[[ Upvalues[3]:
				[1]: Parent_upvr (copied, readonly)
				[2]: RunService_upvr (copied, readonly)
				[3]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_3 = Parent_upvr.new()
			any_new_result1_3.SustainTime = 0.1
			any_new_result1_3:Start()
			local var61_upvw = false
			local any_OnSignal_result1 = any_new_result1_3:OnSignal(RunService_upvr.Heartbeat, function() -- Line 237
				--[[ Upvalues[1]:
					[1]: var61_upvw (read and write)
				]]
				var61_upvw = true
			end)
			expect(typeof(any_OnSignal_result1)).to.equal("RBXScriptConnection")
			expect(any_OnSignal_result1.Connected).to.equal(true)
			AwaitStop_upvr(any_new_result1_3)
			expect(var61_upvw).to.equal(true)
			expect(any_OnSignal_result1.Connected).to.equal(false)
		end)
		it("should bind to render step", function() -- Line 247
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitStop_upvr (copied, readonly)
			]]
			local any_new_result1_5 = Parent_upvr.new()
			any_new_result1_5.SustainTime = 0.1
			any_new_result1_5:Start()
			local var66_upvw = false
			any_new_result1_5:BindToRenderStep("ShakeTest", Enum.RenderPriority.Last.Value, function() -- Line 252
				--[[ Upvalues[1]:
					[1]: var66_upvw (read and write)
				]]
				var66_upvw = true
			end)
			AwaitStop_upvr(any_new_result1_5)
			expect(var66_upvw).to.equal(true)
		end)
	end)
end