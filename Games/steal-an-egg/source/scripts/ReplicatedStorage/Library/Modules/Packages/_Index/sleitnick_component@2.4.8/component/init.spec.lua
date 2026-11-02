-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)
	local CollectionService = game:GetService("CollectionService")
	local RunService = game:GetService("RunService")
	local v2 = nil

	local function CreateTaggedInstance() --[[ CreateTaggedInstance | Line: 11 | Upvalues: CollectionService (copy), v2 (ref) ]]
		local ComponentTest = Instance.new("Folder")

		CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
		ComponentTest.Name = "ComponentTest"
		ComponentTest.Archivable = false
		ComponentTest.Parent = v2

		return ComponentTest
	end

	local t = {
		ShouldConstruct = function(p1) --[[ ShouldConstruct | Line: 21 ]]
			return true
		end,
		Constructing = function(p1) --[[ Constructing | Line: 24 ]]
			p1.Data = "a"
			p1.DidHeartbeat = false
			p1.DidStepped = false
			p1.DidRenderStepped = false
		end,
		Constructed = function(p1) --[[ Constructed | Line: 30 ]]
			p1.Data = p1.Data .. "c"
		end,
		Starting = function(p1) --[[ Starting | Line: 33 ]]
			p1.Data = p1.Data .. "d"
		end,
		Started = function(p1) --[[ Started | Line: 36 ]]
			p1.Data = p1.Data .. "f"
		end,
		Stopping = function(p1) --[[ Stopping | Line: 39 ]]
			p1.Data = p1.Data .. "g"
		end,
		Stopped = function(p1) --[[ Stopped | Line: 42 ]]
			p1.Data = p1.Data .. "i"
		end
	}
	local v3 = v1.new({
		Tag = "__KnitTestComponent__",
		Ancestors = { workspace, game:GetService("Lighting") },
		Extensions = { t }
	})
	local v4 = v1.new({
		Tag = "__KnitTestComponent__"
	})

	function v4.GetData(p1) --[[ GetData | Line: 53 ]]
		return true
	end
	function v3.Construct(p1) --[[ Construct | Line: 57 ]]
		p1.Data = p1.Data .. "b"
	end
	function v3.Start(p1) --[[ Start | Line: 61 | Upvalues: v4 (copy) ]]
		p1.Another = p1:GetComponent(v4)
		p1.Data = p1.Data .. "e"
	end
	function v3.Stop(p1) --[[ Stop | Line: 66 ]]
		p1.Data = p1.Data .. "h"
	end
	function v3.HeartbeatUpdate(p1, p2) --[[ HeartbeatUpdate | Line: 70 ]]
		p1.DidHeartbeat = true
	end
	function v3.SteppedUpdate(p1, p2) --[[ SteppedUpdate | Line: 74 ]]
		p1.DidStepped = true
	end
	function v3.RenderSteppedUpdate(p1, p2) --[[ RenderSteppedUpdate | Line: 78 ]]
		p1.DidRenderStepped = true
	end
	beforeAll(function() --[[ Line: 82 | Upvalues: v2 (ref) ]]
		v2 = Instance.new("Folder")
		v2.Name = "KnitComponentTest"
		v2.Archivable = false
		v2.Parent = workspace
	end)
	afterEach(function() --[[ Line: 89 | Upvalues: v2 (ref) ]]
		v2:ClearAllChildren()
	end)
	afterAll(function() --[[ Line: 93 | Upvalues: v2 (ref), v3 (copy) ]]
		v2:Destroy()
		v3:Destroy()
	end)
	describe("Component", function() --[[ Line: 98 | Upvalues: v3 (copy), CollectionService (copy), v2 (ref), RunService (copy), v1 (copy) ]]
		it("should capture start and stop events", function() --[[ Line: 99 | Upvalues: v3 (ref), CollectionService (ref), v2 (ref) ]]
			local v1 = 0
			local v22 = 0
			local v32 = v3.Started:Connect(function() --[[ Line: 102 | Upvalues: v1 (ref) ]]
				v1 = v1 + 1
			end)
			local v4 = v3.Stopped:Connect(function() --[[ Line: 105 | Upvalues: v22 (ref) ]]
				v22 = v22 + 1
			end)
			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			task.wait()
			ComponentTest:Destroy()
			task.wait()
			v32:Disconnect()
			v4:Disconnect()
			expect(v1).to.equal(1)
			expect(v22).to.equal(1)
		end)
		it("should be able to get component from the instance", function() --[[ Line: 118 | Upvalues: CollectionService (ref), v2 (ref), v3 (ref) ]]
			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			task.wait()
			expect((v3:FromInstance(ComponentTest))).to.be.ok()
		end)
		it("should be able to get all component instances existing", function() --[[ Line: 125 | Upvalues: CollectionService (ref), v2 (ref), v3 (ref) ]]
			local v1 = table.create(3)
			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			v1[1] = ComponentTest

			local ComponentTest2 = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest2, "__KnitTestComponent__")
			ComponentTest2.Name = "ComponentTest"
			ComponentTest2.Archivable = false
			ComponentTest2.Parent = v2
			v1[2] = ComponentTest2

			local ComponentTest3 = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest3, "__KnitTestComponent__")
			ComponentTest3.Name = "ComponentTest"
			ComponentTest3.Archivable = false
			ComponentTest3.Parent = v2
			v1[3] = ComponentTest3
			task.wait()

			local v22 = v3:GetAll()

			expect(v22).to.be.a("table")
			expect(#v22).to.equal(3)

			for i, v in ipairs(v22) do
				expect(table.find(v1, v.Instance)).to.be.ok()
			end
		end)
		it("should call lifecycle methods and extension functions", function() --[[ Line: 141 | Upvalues: CollectionService (ref), v2 (ref), v3 (ref), RunService (ref) ]]
			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			task.wait(0.2)

			local v1 = v3:FromInstance(ComponentTest)

			expect(v1).to.be.ok()
			expect(v1.Data).to.equal("abcdef")
			expect(v1.DidHeartbeat).to.equal(true)
			expect(v1.DidStepped).to.equal(RunService:IsRunning())
			expect(v1.DidRenderStepped).to.never.equal(true)
			ComponentTest:Destroy()
			task.wait()
			expect(v1.Data).to.equal("abcdefghi")
		end)
		it("should get another component linked to the same instance", function() --[[ Line: 155 | Upvalues: CollectionService (ref), v2 (ref), v3 (ref) ]]
			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			task.wait()

			local v1 = v3:FromInstance(ComponentTest)

			expect(v1).to.be.ok()
			expect(v1.Another).to.be.ok()
			expect(v1.Another:GetData()).to.equal(true)
		end)
		it("should use extension to decide whether or not to construct", function() --[[ Line: 164 | Upvalues: v1 (ref), CollectionService (ref), v2 (ref) ]]
			local t = {
				c = true
			}

			function t.ShouldConstruct(p1) --[[ ShouldConstruct | Line: 166 | Upvalues: t (copy) ]]
				return t.c
			end

			local t2 = {
				c = true
			}

			function t2.ShouldConstruct(p1) --[[ ShouldConstruct | Line: 171 | Upvalues: t2 (copy) ]]
				return t2.c
			end

			local t3 = {
				c = true
			}

			function t3.ShouldConstruct(p1) --[[ ShouldConstruct | Line: 176 | Upvalues: t3 (copy) ]]
				return t3.c
			end

			local v12 = v1.new({
				Tag = "__KnitTestComponent__",
				Extensions = { t }
			})
			local v22 = v1.new({
				Tag = "__KnitTestComponent__",
				Extensions = { t, t2 }
			})
			local v3 = v1.new({
				Tag = "__KnitTestComponent__",
				Extensions = { t, t2, t3 }
			})

			local function SetE(p1, p2, p3) --[[ SetE | Line: 184 | Upvalues: t (copy), t2 (copy), t3 (copy) ]]
				t.c = p1
				t2.c = p2
				t3.c = p3
			end

			local function Check(p1, p2, p3) --[[ Check | Line: 190 ]]
				local v1 = p2:FromInstance(p1)

				if p3 then
					expect(v1).to.be.ok()
				else
					expect(v1).to.never.be.ok()
				end
			end

			local function CreateAndCheckAll(p1, p2, p3) --[[ CreateAndCheckAll | Line: 199 | Upvalues: CollectionService (ref), v2 (ref), Check (copy), v12 (copy), v22 (copy), v3 (copy) ]]
				local ComponentTest = Instance.new("Folder")

				CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
				ComponentTest.Name = "ComponentTest"
				ComponentTest.Archivable = false
				ComponentTest.Parent = v2
				task.wait()
				Check(ComponentTest, v12, p1)
				Check(ComponentTest, v22, p2)
				Check(ComponentTest, v3, p3)
			end

			t.c = true
			t2.c = true
			t3.c = true

			local ComponentTest = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
			ComponentTest.Name = "ComponentTest"
			ComponentTest.Archivable = false
			ComponentTest.Parent = v2
			task.wait()
			expect((v12:FromInstance(ComponentTest))).to.be.ok()
			expect((v22:FromInstance(ComponentTest))).to.be.ok()
			expect((v3:FromInstance(ComponentTest))).to.be.ok()
			t.c = false
			t2.c = false
			t3.c = false

			local ComponentTest2 = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest2, "__KnitTestComponent__")
			ComponentTest2.Name = "ComponentTest"
			ComponentTest2.Archivable = false
			ComponentTest2.Parent = v2
			task.wait()
			expect((v12:FromInstance(ComponentTest2))).to.never.be.ok()
			expect((v22:FromInstance(ComponentTest2))).to.never.be.ok()
			expect((v3:FromInstance(ComponentTest2))).to.never.be.ok()
			t.c = true
			t2.c = false
			t3.c = true

			local ComponentTest3 = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest3, "__KnitTestComponent__")
			ComponentTest3.Name = "ComponentTest"
			ComponentTest3.Archivable = false
			ComponentTest3.Parent = v2
			task.wait()
			expect((v12:FromInstance(ComponentTest3))).to.be.ok()
			expect((v22:FromInstance(ComponentTest3))).to.never.be.ok()
			expect((v3:FromInstance(ComponentTest3))).to.never.be.ok()
			t.c = false
			t2.c = false
			t3.c = true

			local ComponentTest4 = Instance.new("Folder")

			CollectionService:AddTag(ComponentTest4, "__KnitTestComponent__")
			ComponentTest4.Name = "ComponentTest"
			ComponentTest4.Archivable = false
			ComponentTest4.Parent = v2
			task.wait()
			expect((v12:FromInstance(ComponentTest4))).to.never.be.ok()
			expect((v22:FromInstance(ComponentTest4))).to.never.be.ok()
			expect((v3:FromInstance(ComponentTest4))).to.never.be.ok()
		end)
		it("should decide whether or not to use extend", function() --[[ Line: 224 | Upvalues: v1 (ref), CollectionService (ref), v2 (ref) ]]
			local t = {
				extend = true
			}

			function t.ShouldExtend(p1) --[[ ShouldExtend | Line: 226 | Upvalues: t (copy) ]]
				return t.extend
			end
			function t.Constructing(p1) --[[ Constructing | Line: 229 ]]
				p1.E1 = true
			end

			local t2 = {
				extend = true
			}

			function t2.ShouldExtend(p1) --[[ ShouldExtend | Line: 234 | Upvalues: t2 (copy) ]]
				return t2.extend
			end
			function t2.Constructing(p1) --[[ Constructing | Line: 237 ]]
				p1.E2 = true
			end

			local v12 = v1.new({
				Tag = "__KnitTestComponent__",
				Extensions = { t, t2 }
			})

			local function SetAndCheck(p1, p2) --[[ SetAndCheck | Line: 243 | Upvalues: t (copy), t2 (copy), CollectionService (ref), v2 (ref), v12 (copy) ]]
				t.extend = p1
				t2.extend = p2

				local ComponentTest = Instance.new("Folder")

				CollectionService:AddTag(ComponentTest, "__KnitTestComponent__")
				ComponentTest.Name = "ComponentTest"
				ComponentTest.Archivable = false
				ComponentTest.Parent = v2
				task.wait()

				local v1 = v12:FromInstance(ComponentTest)

				expect(v1).to.be.ok()

				if p1 then
					expect(v1.E1).to.equal(true)
				else
					expect(v1.E1).to.never.be.ok()
				end

				if p2 then
					expect(v1.E2).to.equal(true)
				else
					expect(v1.E2).to.never.be.ok()
				end
			end

			SetAndCheck(true, true)
			SetAndCheck(false, false)
			SetAndCheck(true, false)
			SetAndCheck(false, true)
		end)
		it("should allow yielding within construct", function() --[[ Line: 268 | Upvalues: v1 (ref), CollectionService (ref) ]]
			local v2 = 0

			v1.new({
				Tag = "CustomTag"
			}).Construct = function(p1) --[[ Construct | Line: 275 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
				task.wait(0.5)
			end

			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.Parent = game:GetService("ReplicatedStorage")
			CollectionService:AddTag(Part, "CustomTag")

			local v3 = Part:Clone()

			v3.Parent = workspace
			task.wait(0.6)
			expect(v2).to.equal(1)
			Part:Destroy()
			v3:Destroy()
		end)
		it("should wait for instance", function() --[[ Line: 294 | Upvalues: CollectionService (ref), v3 (ref) ]]
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.Parent = workspace
			task.delay(0.1, function() --[[ Line: 298 | Upvalues: CollectionService (ref), Part (copy) ]]
				CollectionService:AddTag(Part, "__KnitTestComponent__")
			end)

			local v1, v2 = v3:WaitForInstance(Part):timeout(1):await()

			expect(v1).to.equal(true)
			expect(v2).to.be.a("table")
			expect(v2.Instance).to.equal(Part)
			Part:Destroy()
		end)
	end)
end