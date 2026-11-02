-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local v1 = require(script.Parent)
	local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

	describe("testing the main functions", function() --[[ Line: 8 | Upvalues: v1 (copy), Trove (copy) ]]
		local t = {}
		local t2 = {}

		expect(function() --[[ Line: 11 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
			v1({
				removeFrom = t,
				object = t2
			})
		end).to.throw("Bad trove configuration inside removed object. If no trove intended then opt for creating one via config.")
		expect(function() --[[ Line: 15 | Upvalues: v1 (ref) ]]
			v1({
				removeFrom = 33,
				object = 333
			})
		end).to.throw()
		it("Shouldl be able to handle a tabel with no trove", function() --[[ Line: 19 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
			local sucessfullytransformedtheinitialobject = v1({
				createTroveIfNotExists = true,
				removeFrom = t,
				object = t2
			})

			print("sucessfully transformed the initial object", sucessfullytransformedtheinitialobject, t)
			expect(sucessfullytransformedtheinitialobject).to.be.a("table")
			expect(sucessfullytransformedtheinitialobject._trove).to.be.a("table")
			expect(t[1]).to.be.a("table")
			sucessfullytransformedtheinitialobject._trove:Destroy()
			print("sucessfully cleaed up the table from the initial object", t)
			expect(t[1]).never.to.be.a("table")
		end)
		it("Should be abel to handle the requests even if hte trove have been created internally", function() --[[ Line: 31 | Upvalues: Trove (ref), v1 (ref), t (copy) ]]
			local v12 = Trove.new()
			local sucessfullytransformedtheinitalinernaltrove = v1({
				removeFrom = t,
				object = {
					_trove = v12
				}
			})

			print("sucessfully transformed the inital. (Inernal trove)", sucessfullytransformedtheinitalinernaltrove, t)
			expect(sucessfullytransformedtheinitalinernaltrove).to.be.a("table")
			expect(sucessfullytransformedtheinitalinernaltrove._trove).to.be.a("table")
			v12:Destroy()
			print("sucessfully cleaed up the table from the initial object", t)
			expect(t[1]).never.to.be.a("table")
		end)
		it("Should be abel to seutp the index override method", function() --[[ Line: 42 | Upvalues: Trove (ref), v1 (ref), t (copy) ]]
			local v12 = Trove.new()
			local sucessfullytransformedtheinitialwithindexoverrideexternaltrove = v1({
				indexOverride = "overrideindex",
				removeFrom = t,
				object = {},
				overrideObjectTrove = v12
			})

			print("sucessfully transformed the initial with (Index override)+(External trove)", sucessfullytransformedtheinitialwithindexoverrideexternaltrove, t)
			expect(t.overrideindex).to.be.a("table")
			expect(sucessfullytransformedtheinitialwithindexoverrideexternaltrove._trove).never.be.a("table")
			v12:Destroy()
			print("sucessfully cleaed up the table from the initial object", t)
			expect(t.overrideindex).never.to.be.a("table")
		end)
	end)
end