-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:54
-- Luau version 6, Types version 3
-- Time taken: 0.002751 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	describe("Constructor", function() -- Line 4
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should create a new enumlist", function() -- Line 5
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 6
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.new("Test", {"ABC", "XYZ"})
			end).never.to.throw()
		end)
		it("should fail to create a new enumlist with no name", function() -- Line 11
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 12
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.new(nil, {"ABC", "XYZ"})
			end).to.throw()
		end)
		it("should fail to create a new enumlist with no enums", function() -- Line 17
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 18
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.new("Test")
			end).to.throw()
		end)
		it("should fail to create a new enumlist with non string enums", function() -- Line 23
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 24
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.new("Test", {true, false, 32, "ABC"})
			end).to.throw()
		end)
	end)
	describe("Access", function() -- Line 30
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should be able to access enum items", function() -- Line 31
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_upvr_2 = Parent_upvr.new("Test", {"ABC", "XYZ"})
			expect(function() -- Line 33
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr_2 (readonly)
				]]
			end).never.to.throw()
			expect(any_new_result1_upvr_2:BelongsTo(any_new_result1_upvr_2.ABC)).to.equal(true)
		end)
		it("should throw if trying to modify the enumlist", function() -- Line 39
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_upvr_3 = Parent_upvr.new("Test", {"ABC", "XYZ"})
			expect(function() -- Line 41
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr_3 (readonly)
				]]
				any_new_result1_upvr_3.Hello = 32
			end).to.throw()
			expect(function() -- Line 44
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr_3 (readonly)
				]]
				any_new_result1_upvr_3.ABC = 32
			end).to.throw()
		end)
		it("should throw if trying to modify an enumitem", function() -- Line 49
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_upvr = Parent_upvr.new("Test", {"ABC", "XYZ"})
			expect(function() -- Line 51
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr (readonly)
				]]
				any_new_result1_upvr.ABC.XYZ = 32
			end).to.throw()
			expect(function() -- Line 55
				--[[ Upvalues[1]:
					[1]: any_new_result1_upvr (readonly)
				]]
				any_new_result1_upvr.ABC.Name = "NewName"
			end).to.throw()
		end)
		it("should get the name", function() -- Line 61
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.new("Test", {"ABC", "XYZ"}):GetName()).to.equal("Test")
		end)
	end)
	describe("Get Items", function() -- Line 68
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should be able to get all enum items", function() -- Line 69
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1 = Parent_upvr.new("Test", {"ABC", "XYZ"})
			local any_GetEnumItems_result1 = any_new_result1:GetEnumItems()
			expect(any_GetEnumItems_result1).to.be.a("table")
			expect(#any_GetEnumItems_result1).to.equal(2)
			for i, v in ipairs(any_GetEnumItems_result1) do
				expect(v).to.be.a("table")
				expect(v.Name).to.be.a("string")
				expect(v.Value).to.be.a("number")
				expect(v.Value).to.equal(i)
				expect(v.EnumType).to.equal(any_new_result1)
			end
		end)
	end)
end