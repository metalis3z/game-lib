-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Constructor", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		it("should create a new enumlist", function() --[[ Line: 5 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 6 | Upvalues: v1 (ref) ]]
				v1.new("Test", { "ABC", "XYZ" })
			end).never.to.throw()
		end)
		it("should fail to create a new enumlist with no name", function() --[[ Line: 11 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 12 | Upvalues: v1 (ref) ]]
				v1.new(nil, { "ABC", "XYZ" })
			end).to.throw()
		end)
		it("should fail to create a new enumlist with no enums", function() --[[ Line: 17 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 18 | Upvalues: v1 (ref) ]]
				v1.new("Test")
			end).to.throw()
		end)
		it("should fail to create a new enumlist with non string enums", function() --[[ Line: 23 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 24 | Upvalues: v1 (ref) ]]
				v1.new("Test", { true, false, 32, "ABC" })
			end).to.throw()
		end)
	end)
	describe("Access", function() --[[ Line: 30 | Upvalues: v1 (copy) ]]
		it("should be able to access enum items", function() --[[ Line: 31 | Upvalues: v1 (ref) ]]
			local v12 = v1.new("Test", { "ABC", "XYZ" })

			expect(function() --[[ Line: 33 | Upvalues: v12 (copy) ]]
				local ABC = v12.ABC
			end).never.to.throw()
			expect(v12:BelongsTo(v12.ABC)).to.equal(true)
		end)
		it("should throw if trying to modify the enumlist", function() --[[ Line: 39 | Upvalues: v1 (ref) ]]
			local v12 = v1.new("Test", { "ABC", "XYZ" })

			expect(function() --[[ Line: 41 | Upvalues: v12 (copy) ]]
				v12.Hello = 32
			end).to.throw()
			expect(function() --[[ Line: 44 | Upvalues: v12 (copy) ]]
				v12.ABC = 32
			end).to.throw()
		end)
		it("should throw if trying to modify an enumitem", function() --[[ Line: 49 | Upvalues: v1 (ref) ]]
			local v12 = v1.new("Test", { "ABC", "XYZ" })

			expect(function() --[[ Line: 51 | Upvalues: v12 (copy) ]]
				v12.ABC.XYZ = 32
			end).to.throw()
			expect(function() --[[ Line: 55 | Upvalues: v12 (copy) ]]
				v12.ABC.Name = "NewName"
			end).to.throw()
		end)
		it("should get the name", function() --[[ Line: 61 | Upvalues: v1 (ref) ]]
			expect((v1.new("Test", { "ABC", "XYZ" }):GetName())).to.equal("Test")
		end)
	end)
	describe("Get Items", function() --[[ Line: 68 | Upvalues: v1 (copy) ]]
		it("should be able to get all enum items", function() --[[ Line: 69 | Upvalues: v1 (ref) ]]
			local v12 = v1.new("Test", { "ABC", "XYZ" })
			local v2 = v12:GetEnumItems()

			expect(v2).to.be.a("table")
			expect(#v2).to.equal(2)

			for i, v in ipairs(v2) do
				expect(v).to.be.a("table")
				expect(v.Name).to.be.a("string")
				expect(v.Value).to.be.a("number")
				expect(v.Value).to.equal(i)
				expect(v.EnumType).to.equal(v12)
			end
		end)
	end)
end