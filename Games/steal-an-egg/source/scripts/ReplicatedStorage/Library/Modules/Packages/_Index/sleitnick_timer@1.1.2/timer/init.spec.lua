-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Timer", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		local v12 = nil

		beforeEach(function() --[[ Line: 7 | Upvalues: v12 (ref), v1 (ref) ]]
			v12 = v1.new(0.1)
			v12.TimeFunction = os.clock
		end)
		afterEach(function() --[[ Line: 12 | Upvalues: v12 (ref) ]]
			if not v12 then
				return
			end

			v12:Destroy()
			v12 = nil
		end)
		it("should create a new timer", function() --[[ Line: 19 | Upvalues: v1 (ref), v12 (ref) ]]
			expect(v1.Is(v12)).to.equal(true)
		end)
		it("should tick appropriately", function() --[[ Line: 23 | Upvalues: v12 (ref) ]]
			local v1 = os.clock()

			v12:Start()
			v12.Tick:Wait()

			local v2 = os.clock() - v1

			expect(v2).to.be.near(v2, 0.02)
		end)
		it("should start immediately", function() --[[ Line: 31 | Upvalues: v12 (ref) ]]
			local v1 = os.clock()
			local v2 = nil

			v12.Tick:Connect(function() --[[ Line: 34 | Upvalues: v2 (ref) ]]
				if v2 then
					return
				end

				v2 = os.clock()
			end)
			v12:StartNow()
			v12.Tick:Wait()
			expect(v2).to.be.a("number")

			local v3 = v2 - v1

			expect(v3).to.be.near(0, 0.02)
		end)
		it("should stop", function() --[[ Line: 46 | Upvalues: v12 (ref) ]]
			local v1 = 0

			v12.Tick:Connect(function() --[[ Line: 48 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			v12:StartNow()
			v12:Stop()
			task.wait(1)
			expect(v1).to.equal(1)
		end)
		it("should detect if running", function() --[[ Line: 57 | Upvalues: v12 (ref) ]]
			expect(v12:IsRunning()).to.equal(false)
			v12:Start()
			expect(v12:IsRunning()).to.equal(true)
			v12:Stop()
			expect(v12:IsRunning()).to.equal(false)
			v12:StartNow()
			expect(v12:IsRunning()).to.equal(true)
			v12:Stop()
			expect(v12:IsRunning()).to.equal(false)
		end)
	end)
end