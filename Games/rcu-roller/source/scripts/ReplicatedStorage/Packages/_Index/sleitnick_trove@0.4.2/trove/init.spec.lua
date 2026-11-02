-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:22
-- Luau version 6, Types version 3
-- Time taken: 0.004323 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	describe("Trove", function() -- Line 4
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		local var4_upvw
		beforeEach(function() -- Line 7
			--[[ Upvalues[2]:
				[1]: var4_upvw (read and write)
				[2]: Parent_upvr (copied, readonly)
			]]
			var4_upvw = Parent_upvr.new()
		end)
		afterEach(function() -- Line 11
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			if var4_upvw then
				var4_upvw:Destroy()
				var4_upvw = nil
			end
		end)
		it("should add and clean up roblox instance", function() -- Line 18
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local Part_4 = Instance.new("Part")
			Part_4.Parent = workspace
			var4_upvw:Add(Part_4)
			var4_upvw:Destroy()
			expect(Part_4.Parent).to.equal(nil)
		end)
		it("should add and clean up roblox connection", function() -- Line 26
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local any_Connect_result1 = workspace.Changed:Connect(function() -- Line 27
			end)
			var4_upvw:Add(any_Connect_result1)
			var4_upvw:Destroy()
			expect(any_Connect_result1.Connected).to.equal(false)
		end)
		it("should add and clean up a table with a destroy method", function() -- Line 33
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local tbl_2 = {
				Destroyed = false;
			}
			local function Destroy(arg1) -- Line 35
				arg1.Destroyed = true
			end
			tbl_2.Destroy = Destroy
			var4_upvw:Add(tbl_2)
			var4_upvw:Destroy()
			expect(tbl_2.Destroyed).to.equal(true)
		end)
		it("should add and clean up a table with a disconnect method", function() -- Line 43
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local tbl = {
				Connected = true;
				Disconnect = function(arg1) -- Line 45, Named "Disconnect"
					arg1.Connected = false
				end;
			}
			var4_upvw:Add(tbl)
			var4_upvw:Destroy()
			expect(tbl.Connected).to.equal(false)
		end)
		it("should add and clean up a function", function() -- Line 53
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local var17_upvw = false
			var4_upvw:Add(function() -- Line 55
				--[[ Upvalues[1]:
					[1]: var17_upvw (read and write)
				]]
				var17_upvw = true
			end)
			var4_upvw:Destroy()
			expect(var17_upvw).to.equal(true)
		end)
		it("should allow a custom cleanup method", function() -- Line 62
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local tbl_3 = {
				Cleaned = false;
				Cleanup = function(arg1) -- Line 64, Named "Cleanup"
					arg1.Cleaned = true
				end;
			}
			var4_upvw:Add(tbl_3, "Cleanup")
			var4_upvw:Destroy()
			expect(tbl_3.Cleaned).to.equal(true)
		end)
		it("should return the object passed to add", function() -- Line 72
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local Part = Instance.new("Part")
			expect(Part).to.equal(var4_upvw:Add(Part))
			var4_upvw:Destroy()
		end)
		it("should fail to add object without proper cleanup method", function() -- Line 79
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local tbl_4_upvr = {}
			expect(function() -- Line 81
				--[[ Upvalues[2]:
					[1]: var4_upvw (copied, read and write)
					[2]: tbl_4_upvr (readonly)
				]]
				var4_upvw:Add(tbl_4_upvr)
			end).to.throw()
		end)
		it("should construct an object and add it", function() -- Line 86
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local tbl_upvr = {}
			tbl_upvr.__index = tbl_upvr
			function tbl_upvr.new(arg1) -- Line 89
				--[[ Upvalues[1]:
					[1]: tbl_upvr (readonly)
				]]
				local setmetatable_result1 = setmetatable({}, tbl_upvr)
				setmetatable_result1._msg = arg1
				setmetatable_result1._destroyed = false
				return setmetatable_result1
			end
			function tbl_upvr.Destroy(arg1) -- Line 95
				arg1._destroyed = true
			end
			local any_Construct_result1 = var4_upvw:Construct(tbl_upvr, "abc")
			expect(typeof(any_Construct_result1)).to.equal("table")
			expect(getmetatable(any_Construct_result1)).to.equal(tbl_upvr)
			expect(any_Construct_result1._msg).to.equal("abc")
			expect(any_Construct_result1._destroyed).to.equal(false)
			var4_upvw:Destroy()
			expect(any_Construct_result1._destroyed).to.equal(true)
		end)
		it("should connect to a signal", function() -- Line 108
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local any_Connect_result1_4 = var4_upvw:Connect(workspace.Changed, function() -- Line 109
			end)
			expect(typeof(any_Connect_result1_4)).to.equal("RBXScriptConnection")
			expect(any_Connect_result1_4.Connected).to.equal(true)
			var4_upvw:Destroy()
			expect(any_Connect_result1_4.Connected).to.equal(false)
		end)
		it("should remove an object", function() -- Line 116
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local any_Connect_result1_2 = var4_upvw:Connect(workspace.Changed, function() -- Line 117
			end)
			expect(var4_upvw:Remove(any_Connect_result1_2)).to.equal(true)
			expect(any_Connect_result1_2.Connected).to.equal(false)
		end)
		it("should not remove an object not in the trove", function() -- Line 122
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local any_Connect_result1_3 = workspace.Changed:Connect(function() -- Line 123
			end)
			expect(var4_upvw:Remove(any_Connect_result1_3)).to.equal(false)
			expect(any_Connect_result1_3.Connected).to.equal(true)
			any_Connect_result1_3:Disconnect()
		end)
		it("should attach to instance", function() -- Line 129
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local Part_3 = Instance.new("Part")
			Part_3.Parent = workspace
			local any_AttachToInstance_result1 = var4_upvw:AttachToInstance(Part_3)
			expect(any_AttachToInstance_result1.Connected).to.equal(true)
			Part_3:Destroy()
			expect(any_AttachToInstance_result1.Connected).to.equal(false)
		end)
		it("should fail to attach to instance not in hierarchy", function() -- Line 138
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local Part_2_upvr = Instance.new("Part")
			expect(function() -- Line 140
				--[[ Upvalues[2]:
					[1]: var4_upvw (copied, read and write)
					[2]: Part_2_upvr (readonly)
				]]
				var4_upvw:AttachToInstance(Part_2_upvr)
			end).to.throw()
		end)
		it("should extend itself", function() -- Line 145
			--[[ Upvalues[2]:
				[1]: var4_upvw (read and write)
				[2]: Parent_upvr (copied, readonly)
			]]
			local any_Extend_result1 = var4_upvw:Extend()
			local var47_upvw = false
			any_Extend_result1:Add(function() -- Line 148
				--[[ Upvalues[1]:
					[1]: var47_upvw (read and write)
				]]
				var47_upvw = true
			end)
			expect(any_Extend_result1).to.be.a("table")
			expect(getmetatable(any_Extend_result1)).to.equal(Parent_upvr)
			var4_upvw:Clean()
			expect(var47_upvw).to.equal(true)
		end)
		it("should clone an instance", function() -- Line 157
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local any_Construct_result1_2 = var4_upvw:Construct(Instance.new, "Part")
			any_Construct_result1_2.Name = "TroveCloneTest"
			local clone = var4_upvw:Clone(any_Construct_result1_2)
			expect(typeof(clone)).to.equal("Instance")
			expect(clone).to.never.equal(any_Construct_result1_2)
			expect(clone.Name).to.equal("TroveCloneTest")
			expect(any_Construct_result1_2.Name).to.equal(clone.Name)
		end)
		it("should clean up a thread", function() -- Line 168
			--[[ Upvalues[1]:
				[1]: var4_upvw (read and write)
			]]
			local coroutine_create_result1 = coroutine.create(function() -- Line 169
			end)
			var4_upvw:Add(coroutine_create_result1)
			expect(coroutine.status(coroutine_create_result1)).to.equal("suspended")
			var4_upvw:Clean()
			expect(coroutine.status(coroutine_create_result1)).to.equal("dead")
		end)
	end)
end