-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Constructor", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		it("should create a new symbol", function() --[[ Line: 5 | Upvalues: v1 (ref) ]]
			local v12 = v1("Test")

			expect(v12).to.be.a("userdata")
			expect(v12 == v12).to.equal(true)
			expect((tostring(v12))).to.equal("Symbol(Test)")
		end)
		it("should create a new symbol with no name", function() --[[ Line: 12 | Upvalues: v1 (ref) ]]
			local v12 = v1()

			expect(v12).to.be.a("userdata")
			expect(v12 == v12).to.equal(true)
			expect((tostring(v12))).to.equal("Symbol()")
		end)
		it("should be unique regardless of the name", function() --[[ Line: 19 | Upvalues: v1 (ref) ]]
			local v12 = expect

			v12(v1("Test") == v1("Test")).to.equal(false)

			local v3 = expect

			v3(v1() == v1()).to.equal(false)

			local v5 = expect

			v5(v1("Test") == v1()).to.equal(false)

			local v7 = expect

			v7(v1("Test1") == v1("Test2")).to.equal(false)
		end)
		it("should be useable as a table key", function() --[[ Line: 26 | Upvalues: v1 (ref) ]]
			local v12 = v1()

			expect(({
				[v12] = 100
			})[v12]).to.equal(100)
		end)
	end)
end