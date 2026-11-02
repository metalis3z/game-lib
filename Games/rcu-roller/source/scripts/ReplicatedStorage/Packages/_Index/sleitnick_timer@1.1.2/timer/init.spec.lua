-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:20
-- Luau version 6, Types version 3
-- Time taken: 0.001748 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	describe("Timer", function() -- Line 4
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		local var4_upvw
		beforeEach(function() -- Line 7
			--[[ Upvalues[2]:
				[1]: var4_upvw (read and write)
				[2]: Parent_upvr (copied, readonly)
			]]
			var4_upvw = Parent_upvr.new(0.1)
			var4_upvw.TimeFunction = os.clock
		end)
		afterEach(function() -- Line 12
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			if var4_upvw then
				var4_upvw:Destroy()
				var4_upvw = nil
			end
		end)
		it("should create a new timer", function() -- Line 19
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: var4_upvw (read and write)
			]]
			expect(Parent_upvr.Is(var4_upvw)).to.equal(true)
		end)
		it("should tick appropriately", function() -- Line 23
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			var4_upvw:Start()
			var4_upvw.Tick:Wait()
			local var9 = os.clock() - os.clock()
			expect(var9).to.be.near(var9, 0.02)
		end)
		it("should start immediately", function() -- Line 31
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local var11_upvw
			var4_upvw.Tick:Connect(function() -- Line 34
				--[[ Upvalues[1]:
					[1]: var11_upvw (read and write)
				]]
				if not var11_upvw then
					var11_upvw = os.clock()
				end
			end)
			var4_upvw:StartNow()
			var4_upvw.Tick:Wait()
			expect(var11_upvw).to.be.a("number")
			expect(var11_upvw - os.clock()).to.be.near(0, 0.02)
		end)
		it("should stop", function() -- Line 46
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local var14_upvw = 0
			var4_upvw.Tick:Connect(function() -- Line 48
				--[[ Upvalues[1]:
					[1]: var14_upvw (read and write)
				]]
				var14_upvw += 1
			end)
			var4_upvw:StartNow()
			var4_upvw:Stop()
			task.wait(1)
			expect(var14_upvw).to.equal(1)
		end)
		it("should detect if running", function() -- Line 57
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			expect(var4_upvw:IsRunning()).to.equal(false)
			var4_upvw:Start()
			expect(var4_upvw:IsRunning()).to.equal(true)
			var4_upvw:Stop()
			expect(var4_upvw:IsRunning()).to.equal(false)
			var4_upvw:StartNow()
			expect(var4_upvw:IsRunning()).to.equal(true)
			var4_upvw:Stop()
			expect(var4_upvw:IsRunning()).to.equal(false)
		end)
	end)
end