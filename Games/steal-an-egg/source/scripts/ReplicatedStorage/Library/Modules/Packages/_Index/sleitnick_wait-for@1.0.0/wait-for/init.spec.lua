-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)
	local Promise = require(script.Parent.Parent.Promise)
	local t = {}

	local function Create(p1, p2) --[[ Create | Line: 7 | Upvalues: t (copy) ]]
		local v1 = Instance.new("Folder")

		v1.Name = p1
		v1.Parent = p2
		table.insert(t, v1)

		return v1
	end

	afterEach(function() --[[ Line: 15 | Upvalues: t (copy) ]]
		for i, v in ipairs(t) do
			task.delay(0, function() --[[ Line: 17 | Upvalues: v (copy) ]]
				v:Destroy()
			end)
		end

		table.clear(t)
	end)
	describe("WaitFor", function() --[[ Line: 24 | Upvalues: Create (copy), v1 (copy), t (copy), Promise (copy) ]]
		it("should wait for child", function() --[[ Line: 25 | Upvalues: Create (ref), v1 (ref) ]]
			local v12 = workspace

			task.delay(0.1, Create, "TestChild", v12)

			local v2, v3 = v1.Child(v12, "TestChild"):await()

			expect(v2).to.equal(true)
			expect((typeof(v3))).to.equal("Instance")
			expect(v3.Name).to.equal("TestChild")
			expect(v3.Parent).to.equal(v12)
		end)
		it("should stop waiting for child if parent is unparented", function() --[[ Line: 38 | Upvalues: t (ref), v1 (ref) ]]
			local v12 = workspace
			local SomeParent = Instance.new("Folder")

			SomeParent.Name = "SomeParent"
			SomeParent.Parent = v12
			table.insert(t, SomeParent)

			local v3 = SomeParent

			task.delay(0.1, function() --[[ Line: 42 | Upvalues: v3 (copy) ]]
				v3:Destroy()
			end)

			local v4, v5 = v1.Child(v3, "TestChild"):await()

			expect(v4).to.equal(false)
			expect(v5).to.equal(v1.Error.Unparented)
		end)
		it("should stop waiting for child if timeout is reached", function() --[[ Line: 51 | Upvalues: v1 (ref), Promise (ref) ]]
			local v12, v2 = v1.Child(workspace, "InstanceThatDoesNotExist", 0.1):await()

			expect(v12).to.equal(false)
			expect(Promise.Error.isKind(v2, Promise.Error.Kind.TimedOut)).to.equal(true)
		end)
		it("should wait for children", function() --[[ Line: 57 | Upvalues: Create (ref), v1 (ref) ]]
			local v12 = workspace
			local t = { "TestChild01", "TestChild02", "TestChild03" }

			task.delay(0.1, Create, t[1], v12)
			task.delay(0.2, Create, t[2], v12)
			task.delay(0.05, Create, t[3], v12)

			local v2, v3 = v1.Children(v12, t):await()

			expect(v2).to.equal(true)

			for i, v in ipairs(v3) do
				expect((typeof(v))).to.equal("Instance")
				expect(v.Name).to.equal(t[i])
				expect(v.Parent).to.equal(v12)
			end
		end)
		it("should fail if any children are no longer parented in parent", function() --[[ Line: 74 | Upvalues: Create (ref), t (ref), v1 (ref) ]]
			local v12 = workspace
			local t2 = { "TestChild04", "TestChild05", "TestChild06" }
			local v2 = nil

			task.delay(0.1, Create, t2[1], v12)
			task.delay(0.2, Create, t2[2], v12)
			task.delay(0.05, function() --[[ Line: 82 | Upvalues: v2 (ref), t2 (copy), v12 (copy), t (ref) ]]
				local v3 = Instance.new("Folder")

				v3.Name = t2[3]
				v3.Parent = v12
				table.insert(t, v3)
				v2 = v3
			end)
			task.delay(0.1, function() --[[ Line: 85 | Upvalues: v2 (ref) ]]
				v2:Destroy()
			end)

			local v3, v4 = v1.Children(v12, t2):await()

			expect(v3).to.equal(false)
			expect(v4).to.equal(v1.Error.ParentChanged)
		end)
		it("should wait for descendant", function() --[[ Line: 94 | Upvalues: Create (ref), t (ref), v1 (ref) ]]
			local v12 = workspace
			local v2 = task.delay
			local TestFolder = Instance.new("Folder")

			TestFolder.Name = "TestFolder"
			TestFolder.Parent = v12
			table.insert(t, TestFolder)
			v2(0.1, Create, "TestDescendant", TestFolder)

			local v5, v6 = v1.Descendant(v12, "TestDescendant"):await()

			expect(v5).to.equal(true)
			expect((typeof(v6))).to.equal("Instance")
			expect(v6.Name).to.equal("TestDescendant")
			expect(v6:IsDescendantOf(v12)).to.equal(true)
		end)
		it("should wait for many descendants", function() --[[ Line: 107 | Upvalues: Create (ref), t (ref), v1 (ref) ]]
			local v12 = workspace
			local t2 = { "TestDescendant01", "TestDescendant02", "TestDescendant03" }
			local v2 = task.delay
			local TestFolder1 = Instance.new("Folder")

			TestFolder1.Name = "TestFolder1"
			TestFolder1.Parent = v12
			table.insert(t, TestFolder1)
			v2(0.1, Create, t2[1], TestFolder1)

			local v6 = task.delay
			local TestFolder2 = Instance.new("Folder")

			TestFolder2.Name = "TestFolder2"
			TestFolder2.Parent = v12
			table.insert(t, TestFolder2)
			v6(0.05, Create, t2[2], TestFolder2)

			local v10 = task.delay
			local TestFolder3 = Instance.new("Folder")

			TestFolder3.Name = "TestFolder3"
			TestFolder3.Parent = v12
			table.insert(t, TestFolder3)

			local TestFolder4 = Instance.new("Folder")

			TestFolder4.Name = "TestFolder4"
			TestFolder4.Parent = TestFolder3
			table.insert(t, TestFolder4)
			v10(0.2, Create, t2[3], TestFolder4)

			local v15, v16 = v1.Descendants(v12, t2):await()

			expect(v15).to.equal(true)

			for i, v in ipairs(v16) do
				expect((typeof(v))).to.equal("Instance")

				local v17 = expect

				v17(if v.Name == t2[i] then true else false).to.equal(true)
				expect(v:IsDescendantOf(v12)).to.equal(true)
			end
		end)
		it("should wait for primarypart", function() --[[ Line: 124 | Upvalues: v1 (ref) ]]
			local Model = Instance.new("Model")
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.Parent = Model
			Model.Parent = workspace
			task.delay(0.1, function() --[[ Line: 132 | Upvalues: Model (copy), Part (copy) ]]
				Model.PrimaryPart = Part
			end)

			local v12, v2 = v1.PrimaryPart(Model):await()

			expect(v12).to.equal(true)
			expect((typeof(v2))).to.equal("Instance")
			expect(v2).to.equal(Part)
			expect(Model.PrimaryPart).to.equal(v2)
			Model:Destroy()
		end)
		it("should wait for objectvalue", function() --[[ Line: 145 | Upvalues: t (ref), v1 (ref) ]]
			local v12 = Instance.new("ObjectValue")

			v12.Parent = workspace

			local v2 = workspace
			local SomeInstance = Instance.new("Folder")

			SomeInstance.Name = "SomeInstance"
			SomeInstance.Parent = v2
			table.insert(t, SomeInstance)

			local v4 = SomeInstance

			task.delay(0.1, function() --[[ Line: 151 | Upvalues: v12 (copy), v4 (copy) ]]
				v12.Value = v4
			end)

			local v5, v6 = v1.ObjectValue(v12):await()

			expect(v5).to.equal(true)
			expect((typeof(v6))).to.equal("Instance")
			expect(v6).to.equal(v4)

			local v7 = expect

			v7(v12.Value == v6)
			v12:Destroy()
		end)
		it("should wait for custom predicate", function() --[[ Line: 164 | Upvalues: t (ref), v1 (ref) ]]
			local v12 = nil

			task.delay(0.1, function() --[[ Line: 166 | Upvalues: v12 (ref), t (ref) ]]
				local v1 = workspace
				local CustomInstance = Instance.new("Folder")

				CustomInstance.Name = "CustomInstance"
				CustomInstance.Parent = v1
				table.insert(t, CustomInstance)
				v12 = CustomInstance
			end)

			local v2, v3 = v1.Custom(function() --[[ Line: 170 | Upvalues: v12 (ref) ]]
				return v12
			end):await()

			expect(v2).to.equal(true)
			expect((typeof(v3))).to.equal("Instance")
			expect(v3).to.equal(v12)
		end)
	end)
end