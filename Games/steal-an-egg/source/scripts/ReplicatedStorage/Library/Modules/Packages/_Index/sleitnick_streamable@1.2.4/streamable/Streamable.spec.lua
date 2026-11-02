-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local Streamable = require(script.Parent.Streamable)
	local v1 = nil
	local v2 = nil

	local function CreateInstance(p1) --[[ CreateInstance | Line: 7 | Upvalues: v1 (ref) ]]
		local v12 = Instance.new("Folder")

		v12.Name = p1
		v12.Archivable = false
		v12.Parent = v1

		return v12
	end

	local function CreatePrimary() --[[ CreatePrimary | Line: 15 | Upvalues: v2 (ref) ]]
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.Parent = v2
		v2.PrimaryPart = Part

		return Part
	end

	beforeAll(function() --[[ Line: 23 | Upvalues: v1 (ref), v2 (ref) ]]
		v1 = Instance.new("Folder")
		v1.Name = "KnitTestFolder"
		v1.Archivable = false
		v1.Parent = workspace
		v2 = Instance.new("Model")
		v2.Name = "KnitTestModel"
		v2.Archivable = false
		v2.Parent = workspace
	end)
	afterEach(function() --[[ Line: 34 | Upvalues: v1 (ref), v2 (ref) ]]
		v1:ClearAllChildren()
		v2:ClearAllChildren()
	end)
	afterAll(function() --[[ Line: 39 | Upvalues: v1 (ref), v2 (ref) ]]
		v1:Destroy()
		v2:Destroy()
	end)
	describe("Streamable", function() --[[ Line: 44 | Upvalues: v1 (ref), Streamable (copy), v2 (ref) ]]
		it("should detect instance that is immediately available", function() --[[ Line: 45 | Upvalues: v1 (ref), Streamable (ref) ]]
			local TestImmediate = Instance.new("Folder")

			TestImmediate.Name = "TestImmediate"
			TestImmediate.Archivable = false
			TestImmediate.Parent = v1

			local v12 = Streamable.new(v1, "TestImmediate")
			local v2 = 0
			local v3 = 0

			v12:Observe(function(p1, p2) --[[ Line: 50 | Upvalues: v2 (ref), v3 (ref) ]]
				v2 = v2 + 1
				p2:Add(function() --[[ Line: 52 | Upvalues: v3 (ref) ]]
					v3 = v3 + 1
				end)
			end)
			task.wait()
			TestImmediate.Parent = nil
			task.wait()
			TestImmediate.Parent = v1
			task.wait()
			v12:Destroy()
			task.wait()
			expect(v2).to.equal(2)
			expect(v3).to.equal(2)
		end)
		it("should detect instance that is not immediately available", function() --[[ Line: 67 | Upvalues: Streamable (ref), v1 (ref) ]]
			local v12 = Streamable.new(v1, "TestImmediate")
			local v2 = 0
			local v3 = 0

			v12:Observe(function(p1, p2) --[[ Line: 71 | Upvalues: v2 (ref), v3 (ref) ]]
				v2 = v2 + 1
				p2:Add(function() --[[ Line: 73 | Upvalues: v3 (ref) ]]
					v3 = v3 + 1
				end)
			end)
			task.wait(0.1)

			local TestImmediate = Instance.new("Folder")

			TestImmediate.Name = "TestImmediate"
			TestImmediate.Archivable = false
			TestImmediate.Parent = v1
			task.wait()
			TestImmediate.Parent = nil
			task.wait()
			TestImmediate.Parent = v1
			task.wait()
			v12:Destroy()
			task.wait()
			expect(v2).to.equal(2)
			expect(v3).to.equal(2)
		end)
		it("should detect primary part that is immediately available", function() --[[ Line: 90 | Upvalues: v2 (ref), Streamable (ref) ]]
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.Parent = v2
			v2.PrimaryPart = Part

			local v1 = Streamable.primary(v2)
			local v22 = 0
			local v3 = 0

			v1:Observe(function(p1, p2) --[[ Line: 95 | Upvalues: v22 (ref), v3 (ref) ]]
				v22 = v22 + 1
				p2:Add(function() --[[ Line: 97 | Upvalues: v3 (ref) ]]
					v3 = v3 + 1
				end)
			end)
			task.wait()
			Part.Parent = nil
			task.wait()
			Part.Parent = v2
			v2.PrimaryPart = Part
			task.wait()
			v1:Destroy()
			task.wait()
			expect(v22).to.equal(2)
			expect(v3).to.equal(2)
		end)
		it("should detect primary part that is not immediately available", function() --[[ Line: 113 | Upvalues: Streamable (ref), v2 (ref) ]]
			local v1 = Streamable.primary(v2)
			local v22 = 0
			local v3 = 0

			v1:Observe(function(p1, p2) --[[ Line: 117 | Upvalues: v22 (ref), v3 (ref) ]]
				v22 = v22 + 1
				p2:Add(function() --[[ Line: 119 | Upvalues: v3 (ref) ]]
					v3 = v3 + 1
				end)
			end)
			task.wait(0.1)

			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.Parent = v2
			v2.PrimaryPart = Part
			task.wait()
			Part.Parent = nil
			task.wait()
			Part.Parent = v2
			v2.PrimaryPart = Part
			task.wait()
			v1:Destroy()
			task.wait()
			expect(v22).to.equal(2)
			expect(v3).to.equal(2)
		end)
	end)
end