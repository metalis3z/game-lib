-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)
	local Option = require(script.Parent.Parent.Option)

	describe("SerializeArgs", function() --[[ Line: 5 | Upvalues: Option (copy), v1 (copy) ]]
		it("should serialize an option", function() --[[ Line: 6 | Upvalues: Option (ref), v1 (ref) ]]
			local v2 = table.unpack(v1.SerializeArgs((Option.Some(32))))

			expect(v2.ClassName).to.equal("Option")
			expect(v2.Value).to.equal(32)
		end)
	end)
	describe("SerializeArgsAndUnpack", function() --[[ Line: 14 | Upvalues: Option (copy), v1 (copy) ]]
		it("should serialize an option", function() --[[ Line: 15 | Upvalues: Option (ref), v1 (ref) ]]
			local v2 = v1.SerializeArgsAndUnpack((Option.Some(32)))

			expect(v2.ClassName).to.equal("Option")
			expect(v2.Value).to.equal(32)
		end)
	end)
	describe("DeserializeArgs", function() --[[ Line: 23 | Upvalues: v1 (copy), Option (copy) ]]
		it("should deserialize args to option", function() --[[ Line: 24 | Upvalues: v1 (ref), Option (ref) ]]
			local v12 = table.unpack(v1.DeserializeArgs({
				ClassName = "Option",
				Value = 32
			}))

			expect(Option.Is(v12)).to.equal(true)
			expect(v12:Contains(32)).to.equal(true)
		end)
	end)
	describe("DeserializeArgsAndUnpack", function() --[[ Line: 35 | Upvalues: v1 (copy), Option (copy) ]]
		it("should deserialize args to option", function() --[[ Line: 36 | Upvalues: v1 (ref), Option (ref) ]]
			local v12 = v1.DeserializeArgsAndUnpack({
				ClassName = "Option",
				Value = 32
			})

			expect(Option.Is(v12)).to.equal(true)
			expect(v12:Contains(32)).to.equal(true)
		end)
	end)
end