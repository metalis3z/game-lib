-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local Streamable = require(script.Parent.Streamable)
	local StreamableUtil = require(script.Parent.StreamableUtil)
	local v1 = nil

	local function CreateInstance(p1) --[[ CreateInstance | Line: 7 | Upvalues: v1 (ref) ]]
		local v12 = Instance.new("Folder")

		v12.Name = p1
		v12.Archivable = false
		v12.Parent = v1

		return v12
	end

	beforeAll(function() --[[ Line: 15 | Upvalues: v1 (ref) ]]
		v1 = Instance.new("Folder")
		v1.Name = "KnitTest"
		v1.Archivable = false
		v1.Parent = workspace
	end)
	afterEach(function() --[[ Line: 22 | Upvalues: v1 (ref) ]]
		v1:ClearAllChildren()
	end)
	afterAll(function() --[[ Line: 26 | Upvalues: v1 (ref) ]]
		v1:Destroy()
	end)
	describe("Compound", function() --[[ Line: 30 | Upvalues: Streamable (copy), v1 (ref), StreamableUtil (copy) ]]
		it("should capture multiple streams", function() --[[ Line: 31 | Upvalues: Streamable (ref), v1 (ref), StreamableUtil (ref) ]]
			local v12 = Streamable.new(v1, "ABC")
			local v2 = Streamable.new(v1, "XYZ")
			local v3 = 0
			local v4 = 0

			StreamableUtil.Compound({
				S1 = v12,
				S2 = v2
			}, function(p1, p2) --[[ Line: 36 | Upvalues: v3 (ref), v4 (ref) ]]
				v3 = v3 + 1
				p2:Add(function() --[[ Line: 38 | Upvalues: v4 (ref) ]]
					v4 = v4 + 1
				end)
			end)

			local ABC = Instance.new("Folder")

			ABC.Name = "ABC"
			ABC.Archivable = false
			ABC.Parent = v1

			local XYZ = Instance.new("Folder")

			XYZ.Name = "XYZ"
			XYZ.Archivable = false
			XYZ.Parent = v1
			task.wait()
			ABC.Parent = nil
			task.wait()
			ABC.Parent = v1
			task.wait()
			ABC.Parent = nil
			XYZ.Parent = nil
			task.wait()
			XYZ.Parent = v1
			task.wait()
			expect(v3).to.equal(2)
			expect(v4).to.equal(2)
			v12:Destroy()
			v2:Destroy()
		end)
	end)
end