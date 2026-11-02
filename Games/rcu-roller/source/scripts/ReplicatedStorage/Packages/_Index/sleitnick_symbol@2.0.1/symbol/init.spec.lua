-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:15
-- Luau version 6, Types version 3
-- Time taken: 0.001723 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	describe("Constructor", function() -- Line 4
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should create a new symbol", function() -- Line 5
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local Parent_upvr_result1_2 = Parent_upvr("Test")
			local expect_result1 = expect(Parent_upvr_result1_2)
			expect_result1.to.be.a("userdata")
			if Parent_upvr_result1_2 ~= Parent_upvr_result1_2 then
				expect_result1 = false
			else
				expect_result1 = true
			end
			expect(expect_result1).to.equal(true)
			expect(tostring(Parent_upvr_result1_2)).to.equal("Symbol(Test)")
		end)
		it("should create a new symbol with no name", function() -- Line 12
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var3_result1 = Parent_upvr()
			local expect_result1_2 = expect(var3_result1)
			expect_result1_2.to.be.a("userdata")
			if var3_result1 ~= var3_result1 then
				expect_result1_2 = false
			else
				expect_result1_2 = true
			end
			expect(expect_result1_2).to.equal(true)
			expect(tostring(var3_result1)).to.equal("Symbol()")
		end)
		it("should be unique regardless of the name", function() -- Line 19
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 26 start (CF ANALYSIS FAILED)
			local var11
			if Parent_upvr("Test") ~= Parent_upvr("Test") then
				var11 = false
			else
				var11 = true
			end
			expect(var11).to.equal(false)
			if Parent_upvr() ~= Parent_upvr() then
				var11 = false
				-- KONSTANTWARNING: GOTO [29] #24
			end
			-- KONSTANTERROR: [0] 1. Error Block 26 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [28] 23. Error Block 29 start (CF ANALYSIS FAILED)
			var11 = true
			expect(var11).to.equal(false)
			if Parent_upvr("Test") ~= Parent_upvr() then
				var11 = false
				-- KONSTANTWARNING: GOTO [47] #38
			end
			-- KONSTANTERROR: [28] 23. Error Block 29 end (CF ANALYSIS FAILED)
		end)
		it("should be useable as a table key", function() -- Line 26
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local Parent_upvr_result1 = Parent_upvr()
			expect(({
				[Parent_upvr_result1] = 100;
			})[Parent_upvr_result1]).to.equal(100)
		end)
	end)
end