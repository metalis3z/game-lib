-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:52
-- Luau version 6, Types version 3
-- Time taken: 0.007969 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	local CollectionService_upvr = game:GetService("CollectionService")
	local var4_upvw
	local function _() -- Line 11, Named "CreateTaggedInstance"
		--[[ Upvalues[2]:
			[1]: CollectionService_upvr (readonly)
			[2]: var4_upvw (read and write)
		]]
		local Folder_5 = Instance.new("Folder")
		CollectionService_upvr:AddTag(Folder_5, "__KnitTestComponent__")
		Folder_5.Name = "ComponentTest"
		Folder_5.Archivable = false
		Folder_5.Parent = var4_upvw
		return Folder_5
	end
	local tbl = {}
	local function ShouldConstruct(arg1) -- Line 21
		return true
	end
	tbl.ShouldConstruct = ShouldConstruct
	local function Constructing(arg1) -- Line 24
		arg1.Data = 'a'
		arg1.DidHeartbeat = false
		arg1.DidStepped = false
		arg1.DidRenderStepped = false
	end
	tbl.Constructing = Constructing
	function tbl.Constructed(arg1) -- Line 30
		arg1.Data ..= 'c'
	end
	function tbl.Starting(arg1) -- Line 33
		arg1.Data ..= 'd'
	end
	function tbl.Started(arg1) -- Line 36
		arg1.Data ..= 'f'
	end
	function tbl.Stopping(arg1) -- Line 39
		arg1.Data ..= 'g'
	end
	function tbl.Stopped(arg1) -- Line 42
		arg1.Data ..= 'i'
	end
	local any_new_result1_upvr = Parent_upvr.new({
		Tag = "__KnitTestComponent__";
		Ancestors = {workspace, game:GetService("Lighting")};
		Extensions = {tbl};
	})
	local any_new_result1_upvr_3 = Parent_upvr.new({
		Tag = "__KnitTestComponent__";
	})
	function any_new_result1_upvr_3.GetData(arg1) -- Line 53
		return true
	end
	local function Construct(arg1) -- Line 57
		arg1.Data ..= 'b'
	end
	any_new_result1_upvr.Construct = Construct
	function any_new_result1_upvr.Start(arg1) -- Line 61
		--[[ Upvalues[1]:
			[1]: any_new_result1_upvr_3 (readonly)
		]]
		arg1.Another = arg1:GetComponent(any_new_result1_upvr_3)
		arg1.Data ..= 'e'
	end
	function any_new_result1_upvr.Stop(arg1) -- Line 66
		arg1.Data ..= 'h'
	end
	function any_new_result1_upvr.HeartbeatUpdate(arg1, arg2) -- Line 70
		arg1.DidHeartbeat = true
	end
	function any_new_result1_upvr.SteppedUpdate(arg1, arg2) -- Line 74
		arg1.DidStepped = true
	end
	function any_new_result1_upvr.RenderSteppedUpdate(arg1, arg2) -- Line 78
		arg1.DidRenderStepped = true
	end
	beforeAll(function() -- Line 82
		--[[ Upvalues[1]:
			[1]: var4_upvw (read and write)
		]]
		var4_upvw = Instance.new("Folder")
		var4_upvw.Name = "KnitComponentTest"
		var4_upvw.Archivable = false
		var4_upvw.Parent = workspace
	end)
	afterEach(function() -- Line 89
		--[[ Upvalues[1]:
			[1]: var4_upvw (read and write)
		]]
		var4_upvw:ClearAllChildren()
	end)
	afterAll(function() -- Line 93
		--[[ Upvalues[2]:
			[1]: var4_upvw (read and write)
			[2]: any_new_result1_upvr (readonly)
		]]
		var4_upvw:Destroy()
		any_new_result1_upvr:Destroy()
	end)
	local RunService_upvr = game:GetService("RunService")
	describe("Component", function() -- Line 98
		--[[ Upvalues[5]:
			[1]: any_new_result1_upvr (readonly)
			[2]: CollectionService_upvr (readonly)
			[3]: var4_upvw (read and write)
			[4]: RunService_upvr (readonly)
			[5]: Parent_upvr (readonly)
		]]
		it("should capture start and stop events", function() -- Line 99
			--[[ Upvalues[3]:
				[1]: any_new_result1_upvr (copied, readonly)
				[2]: CollectionService_upvr (copied, readonly)
				[3]: var4_upvw (copied, read and write)
			]]
			local var19_upvw = 0
			local var20_upvw = 0
			local Folder_4 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_4, "__KnitTestComponent__")
			Folder_4.Name = "ComponentTest"
			Folder_4.Archivable = false
			Folder_4.Parent = var4_upvw
			task.wait()
			Folder_4:Destroy()
			task.wait()
			any_new_result1_upvr.Started:Connect(function() -- Line 102
				--[[ Upvalues[1]:
					[1]: var19_upvw (read and write)
				]]
				var19_upvw += 1
			end):Disconnect()
			any_new_result1_upvr.Stopped:Connect(function() -- Line 105
				--[[ Upvalues[1]:
					[1]: var20_upvw (read and write)
				]]
				var20_upvw += 1
			end):Disconnect()
			expect(var19_upvw).to.equal(1)
			expect(var20_upvw).to.equal(1)
		end)
		it("should be able to get component from the instance", function() -- Line 118
			--[[ Upvalues[3]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: var4_upvw (copied, read and write)
				[3]: any_new_result1_upvr (copied, readonly)
			]]
			local Folder_13 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_13, "__KnitTestComponent__")
			Folder_13.Name = "ComponentTest"
			Folder_13.Archivable = false
			Folder_13.Parent = var4_upvw
			task.wait()
			expect(any_new_result1_upvr:FromInstance(Folder_13)).to.be.ok()
		end)
		it("should be able to get all component instances existing", function() -- Line 125
			--[[ Upvalues[3]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: var4_upvw (copied, read and write)
				[3]: any_new_result1_upvr (copied, readonly)
			]]
			local table_create_result1 = table.create(3)
			local Folder_14 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_14, "__KnitTestComponent__")
			Folder_14.Name = "ComponentTest"
			Folder_14.Archivable = false
			Folder_14.Parent = var4_upvw
			table_create_result1[1] = Folder_14
			local Folder_7 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_7, "__KnitTestComponent__")
			Folder_7.Name = "ComponentTest"
			Folder_7.Archivable = false
			Folder_7.Parent = var4_upvw
			table_create_result1[2] = Folder_7
			local Folder_2 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_2, "__KnitTestComponent__")
			Folder_2.Name = "ComponentTest"
			Folder_2.Archivable = false
			Folder_2.Parent = var4_upvw
			table_create_result1[3] = Folder_2
			task.wait()
			local any_GetAll_result1 = any_new_result1_upvr:GetAll()
			expect(any_GetAll_result1).to.be.a("table")
			expect(#any_GetAll_result1).to.equal(3)
			for _, v in ipairs(any_GetAll_result1) do
				expect(table.find(table_create_result1, v.Instance)).to.be.ok()
			end
		end)
		it("should call lifecycle methods and extension functions", function() -- Line 141
			--[[ Upvalues[4]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: var4_upvw (copied, read and write)
				[3]: any_new_result1_upvr (copied, readonly)
				[4]: RunService_upvr (copied, readonly)
			]]
			local Folder_9 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_9, "__KnitTestComponent__")
			Folder_9.Name = "ComponentTest"
			Folder_9.Archivable = false
			Folder_9.Parent = var4_upvw
			local var41 = Folder_9
			task.wait(0.2)
			local any_FromInstance_result1_4 = any_new_result1_upvr:FromInstance(var41)
			expect(any_FromInstance_result1_4).to.be.ok()
			expect(any_FromInstance_result1_4.Data).to.equal("abcdef")
			expect(any_FromInstance_result1_4.DidHeartbeat).to.equal(true)
			expect(any_FromInstance_result1_4.DidStepped).to.equal(RunService_upvr:IsRunning())
			expect(any_FromInstance_result1_4.DidRenderStepped).to.never.equal(true)
			var41:Destroy()
			task.wait()
			expect(any_FromInstance_result1_4.Data).to.equal("abcdefghi")
		end)
		it("should get another component linked to the same instance", function() -- Line 155
			--[[ Upvalues[3]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: var4_upvw (copied, read and write)
				[3]: any_new_result1_upvr (copied, readonly)
			]]
			local Folder_12 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_12, "__KnitTestComponent__")
			Folder_12.Name = "ComponentTest"
			Folder_12.Archivable = false
			Folder_12.Parent = var4_upvw
			task.wait()
			local any_FromInstance_result1_3 = any_new_result1_upvr:FromInstance(Folder_12)
			expect(any_FromInstance_result1_3).to.be.ok()
			expect(any_FromInstance_result1_3.Another).to.be.ok()
			expect(any_FromInstance_result1_3.Another:GetData()).to.equal(true)
		end)
		it("should use extension to decide whether or not to construct", function() -- Line 164
			--[[ Upvalues[3]:
				[1]: Parent_upvr (copied, readonly)
				[2]: CollectionService_upvr (copied, readonly)
				[3]: var4_upvw (copied, read and write)
			]]
			local tbl_upvr = {
				c = true;
			}
			local function ShouldConstruct(arg1) -- Line 166
				--[[ Upvalues[1]:
					[1]: tbl_upvr (readonly)
				]]
				return tbl_upvr.c
			end
			tbl_upvr.ShouldConstruct = ShouldConstruct
			local tbl_upvr_3 = {
				c = true;
			}
			local function ShouldConstruct(arg1) -- Line 171
				--[[ Upvalues[1]:
					[1]: tbl_upvr_3 (readonly)
				]]
				return tbl_upvr_3.c
			end
			tbl_upvr_3.ShouldConstruct = ShouldConstruct
			local tbl_upvr_2 = {
				c = true;
			}
			function tbl_upvr_2.ShouldConstruct(arg1) -- Line 176
				--[[ Upvalues[1]:
					[1]: tbl_upvr_2 (readonly)
				]]
				return tbl_upvr_2.c
			end
			local any_new_result1_upvr_4 = Parent_upvr.new({
				Tag = "__KnitTestComponent__";
				Extensions = {tbl_upvr};
			})
			local any_new_result1_upvr_5 = Parent_upvr.new({
				Tag = "__KnitTestComponent__";
				Extensions = {tbl_upvr, tbl_upvr_3};
			})
			local any_new_result1_upvr_2 = Parent_upvr.new({
				Tag = "__KnitTestComponent__";
				Extensions = {tbl_upvr, tbl_upvr_3, tbl_upvr_2};
			})
			local function _(arg1, arg2, arg3) -- Line 184, Named "SetE"
				--[[ Upvalues[3]:
					[1]: tbl_upvr (readonly)
					[2]: tbl_upvr_3 (readonly)
					[3]: tbl_upvr_2 (readonly)
				]]
				tbl_upvr.c = arg1
				tbl_upvr_3.c = arg2
				tbl_upvr_2.c = arg3
			end
			local function Check_upvr(arg1, arg2, arg3) -- Line 190, Named "Check"
				local any_FromInstance_result1_2 = arg2:FromInstance(arg1)
				if arg3 then
					expect(any_FromInstance_result1_2).to.be.ok()
				else
					expect(any_FromInstance_result1_2).to.never.be.ok()
				end
			end
			local function _(arg1, arg2, arg3) -- Line 199, Named "CreateAndCheckAll"
				--[[ Upvalues[6]:
					[1]: CollectionService_upvr (copied, readonly)
					[2]: var4_upvw (copied, read and write)
					[3]: Check_upvr (readonly)
					[4]: any_new_result1_upvr_4 (readonly)
					[5]: any_new_result1_upvr_5 (readonly)
					[6]: any_new_result1_upvr_2 (readonly)
				]]
				local Folder_3 = Instance.new("Folder")
				CollectionService_upvr:AddTag(Folder_3, "__KnitTestComponent__")
				Folder_3.Name = "ComponentTest"
				Folder_3.Archivable = false
				Folder_3.Parent = var4_upvw
				local var61 = Folder_3
				task.wait()
				Check_upvr(var61, any_new_result1_upvr_4, arg1)
				Check_upvr(var61, any_new_result1_upvr_5, arg2)
				Check_upvr(var61, any_new_result1_upvr_2, arg3)
			end
			tbl_upvr.c = true
			tbl_upvr_3.c = true
			tbl_upvr_2.c = true
			local Folder = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder, "__KnitTestComponent__")
			Folder.Name = "ComponentTest"
			Folder.Archivable = false
			Folder.Parent = var4_upvw
			local var63 = Folder
			task.wait()
			Check_upvr(var63, any_new_result1_upvr_4, true)
			Check_upvr(var63, any_new_result1_upvr_5, true)
			Check_upvr(var63, any_new_result1_upvr_2, true)
			tbl_upvr.c = false
			tbl_upvr_3.c = false
			tbl_upvr_2.c = false
			local Folder_11 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_11, "__KnitTestComponent__")
			Folder_11.Name = "ComponentTest"
			Folder_11.Archivable = false
			Folder_11.Parent = var4_upvw
			local var65 = Folder_11
			task.wait()
			Check_upvr(var65, any_new_result1_upvr_4, false)
			Check_upvr(var65, any_new_result1_upvr_5, false)
			Check_upvr(var65, any_new_result1_upvr_2, false)
			tbl_upvr.c = true
			tbl_upvr_3.c = false
			tbl_upvr_2.c = true
			local Folder_8 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_8, "__KnitTestComponent__")
			Folder_8.Name = "ComponentTest"
			Folder_8.Archivable = false
			Folder_8.Parent = var4_upvw
			local var67 = Folder_8
			task.wait()
			Check_upvr(var67, any_new_result1_upvr_4, true)
			Check_upvr(var67, any_new_result1_upvr_5, false)
			Check_upvr(var67, any_new_result1_upvr_2, false)
			tbl_upvr.c = false
			tbl_upvr_3.c = false
			tbl_upvr_2.c = true
			local Folder_10 = Instance.new("Folder")
			CollectionService_upvr:AddTag(Folder_10, "__KnitTestComponent__")
			Folder_10.Name = "ComponentTest"
			Folder_10.Archivable = false
			Folder_10.Parent = var4_upvw
			local var69 = Folder_10
			task.wait()
			Check_upvr(var69, any_new_result1_upvr_4, false)
			Check_upvr(var69, any_new_result1_upvr_5, false)
			Check_upvr(var69, any_new_result1_upvr_2, false)
		end)
		it("should decide whether or not to use extend", function() -- Line 224
			--[[ Upvalues[3]:
				[1]: Parent_upvr (copied, readonly)
				[2]: CollectionService_upvr (copied, readonly)
				[3]: var4_upvw (copied, read and write)
			]]
			local tbl_upvr_5 = {
				extend = true;
			}
			local function ShouldExtend(arg1) -- Line 226
				--[[ Upvalues[1]:
					[1]: tbl_upvr_5 (readonly)
				]]
				return tbl_upvr_5.extend
			end
			tbl_upvr_5.ShouldExtend = ShouldExtend
			local function Constructing(arg1) -- Line 229
				arg1.E1 = true
			end
			tbl_upvr_5.Constructing = Constructing
			local tbl_upvr_4 = {
				extend = true;
			}
			function tbl_upvr_4.ShouldExtend(arg1) -- Line 234
				--[[ Upvalues[1]:
					[1]: tbl_upvr_4 (readonly)
				]]
				return tbl_upvr_4.extend
			end
			function tbl_upvr_4.Constructing(arg1) -- Line 237
				arg1.E2 = true
			end
			local any_new_result1_upvr_6 = Parent_upvr.new({
				Tag = "__KnitTestComponent__";
				Extensions = {tbl_upvr_5, tbl_upvr_4};
			})
			local function SetAndCheck(arg1, arg2) -- Line 243
				--[[ Upvalues[5]:
					[1]: tbl_upvr_5 (readonly)
					[2]: tbl_upvr_4 (readonly)
					[3]: CollectionService_upvr (copied, readonly)
					[4]: var4_upvw (copied, read and write)
					[5]: any_new_result1_upvr_6 (readonly)
				]]
				tbl_upvr_5.extend = arg1
				tbl_upvr_4.extend = arg2
				local Folder_6 = Instance.new("Folder")
				CollectionService_upvr:AddTag(Folder_6, "__KnitTestComponent__")
				Folder_6.Name = "ComponentTest"
				Folder_6.Archivable = false
				Folder_6.Parent = var4_upvw
				task.wait()
				local any_FromInstance_result1 = any_new_result1_upvr_6:FromInstance(Folder_6)
				expect(any_FromInstance_result1).to.be.ok()
				if arg1 then
					expect(any_FromInstance_result1.E1).to.equal(true)
				else
					expect(any_FromInstance_result1.E1).to.never.be.ok()
				end
				if arg2 then
					expect(any_FromInstance_result1.E2).to.equal(true)
				else
					expect(any_FromInstance_result1.E2).to.never.be.ok()
				end
			end
			SetAndCheck(true, true)
			SetAndCheck(false, false)
			SetAndCheck(true, false)
			SetAndCheck(false, true)
		end)
		it("should allow yielding within construct", function() -- Line 268
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: CollectionService_upvr (copied, readonly)
			]]
			local var80_upvw = 0
			Parent_upvr.new({
				Tag = "CustomTag";
			}).Construct = function(arg1) -- Line 275, Named "Construct"
				--[[ Upvalues[1]:
					[1]: var80_upvw (read and write)
				]]
				var80_upvw += 1
				task.wait(0.5)
			end
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.Parent = game:GetService("ReplicatedStorage")
			CollectionService_upvr:AddTag(Part, "CustomTag")
			local clone = Part:Clone()
			clone.Parent = workspace
			task.wait(0.6)
			expect(var80_upvw).to.equal(1)
			Part:Destroy()
			clone:Destroy()
		end)
		it("should wait for instance", function() -- Line 294
			--[[ Upvalues[2]:
				[1]: CollectionService_upvr (copied, readonly)
				[2]: any_new_result1_upvr (copied, readonly)
			]]
			local Part_upvr = Instance.new("Part")
			Part_upvr.Anchored = true
			Part_upvr.Parent = workspace
			task.delay(0.1, function() -- Line 298
				--[[ Upvalues[2]:
					[1]: CollectionService_upvr (copied, readonly)
					[2]: Part_upvr (readonly)
				]]
				CollectionService_upvr:AddTag(Part_upvr, "__KnitTestComponent__")
			end)
			local any_await_result1, any_await_result2 = any_new_result1_upvr:WaitForInstance(Part_upvr):timeout(1):await()
			expect(any_await_result1).to.equal(true)
			expect(any_await_result2).to.be.a("table")
			expect(any_await_result2.Instance).to.equal(Part_upvr)
			Part_upvr:Destroy()
		end)
	end)
end