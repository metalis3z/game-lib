-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent.Parent)
	local t = {
		profile = {
			Deploy = 0
		},
		Achievements = {
			Deploy = 0
		},
		__master = {
			Deploy = 0
		}
	}
	local testezinspecdtbootrsapperrunnigncurrentecosystem = v1.create_yield_structure({
		Graphics_Profile = {
			Deploy = function(p1) --[[ Deploy | Line: 10 | Upvalues: t (copy) ]]
				local profile = t.profile

				profile.Deploy = profile.Deploy + 1

				local __master = t.__master

				__master.Deploy = __master.Deploy + 1
				print("[Deployign graphics]:State:", t)
				expect(p1).to.be.a("table")
			end
		},
		Graphics_Achievements = {
			Deploy = function(p1) --[[ Deploy | Line: 18 | Upvalues: t (copy) ]]
				local Achievements = t.Achievements

				Achievements.Deploy = Achievements.Deploy + 1

				local __master = t.__master

				__master.Deploy = __master.Deploy + 1
				print("[Deployign graphics]:State:", t)
				expect(p1).to.be.a("table")
			end
		}
	})

	print("TEST EZ INSPECDT BOOTRSAPPER RUNNIGN [:] Current ecosystem:", testezinspecdtbootrsapperrunnigncurrentecosystem)
	describe("FIRST TEST", function() --[[ Line: 28 | Upvalues: v1 (copy), testezinspecdtbootrsapperrunnigncurrentecosystem (copy) ]]
		local v12 = v1.new(testezinspecdtbootrsapperrunnigncurrentecosystem, nil, "DYNAMIC")

		expect(v12).to.be.a("table")
		it("should perfectly bootsrtappe the directory", function() --[[ Line: 31 | Upvalues: v12 (copy) ]]
			v12:Bootstrap()
			print("compoentn compoenent bootsrapped", v12)
			expect(v12.Group_Id).to.be.a("string")
			expect(v12.Lifecycle).to.be.a("string")
			expect(v12.__ecosystem).to.be.a("table")
		end)
	end)
	describe("DYNAMIC TEST", function() --[[ Line: 40 | Upvalues: v1 (copy), testezinspecdtbootrsapperrunnigncurrentecosystem (copy), t (copy) ]]
		local v12 = v1.new(testezinspecdtbootrsapperrunnigncurrentecosystem, nil, "DYNAMIC")

		expect(v12).to.be.a("table")
		it("should perfectly bootsrtappe the directory", function() --[[ Line: 43 | Upvalues: v12 (copy), testezinspecdtbootrsapperrunnigncurrentecosystem (ref), t (ref) ]]
			v12:Bootstrap()
			print("compoentn compoenent bootsrapped", v12, "ecsoystem:", testezinspecdtbootrsapperrunnigncurrentecosystem, "Counters:", t)
			expect(v12.Group_Id).to.be.equal("new_group")
			expect(v12.Lifecycle).to.be.equal("DYNAMIC")
			expect(v12.__ecosystem).to.be.a("table")
			expect(t.profile.Deploy).to.be.equal(1)
			expect(t.Achievements.Deploy).to.be.equal(1)
		end)
	end)
end