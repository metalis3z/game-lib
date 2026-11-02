-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:11
-- Luau version 6, Types version 3
-- Time taken: 0.002692 seconds

return function() -- Line 1
	local var2_upvw
	local var3_upvw
	local function _(arg1) -- Line 7, Named "CreateInstance"
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		local Folder = Instance.new("Folder")
		Folder.Name = arg1
		Folder.Archivable = false
		Folder.Parent = var2_upvw
		return Folder
	end
	local function _() -- Line 15, Named "CreatePrimary"
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		local Part_2 = Instance.new("Part")
		Part_2.Anchored = true
		Part_2.Parent = var3_upvw
		var3_upvw.PrimaryPart = Part_2
		return Part_2
	end
	beforeAll(function() -- Line 23
		--[[ Upvalues[2]:
			[1]: var2_upvw (read and write)
			[2]: var3_upvw (read and write)
		]]
		var2_upvw = Instance.new("Folder")
		var2_upvw.Name = "KnitTestFolder"
		var2_upvw.Archivable = false
		var2_upvw.Parent = workspace
		var3_upvw = Instance.new("Model")
		var3_upvw.Name = "KnitTestModel"
		var3_upvw.Archivable = false
		var3_upvw.Parent = workspace
	end)
	afterEach(function() -- Line 34
		--[[ Upvalues[2]:
			[1]: var2_upvw (read and write)
			[2]: var3_upvw (read and write)
		]]
		var2_upvw:ClearAllChildren()
		var3_upvw:ClearAllChildren()
	end)
	afterAll(function() -- Line 39
		--[[ Upvalues[2]:
			[1]: var2_upvw (read and write)
			[2]: var3_upvw (read and write)
		]]
		var2_upvw:Destroy()
		var3_upvw:Destroy()
	end)
	local Streamable_upvr = require(script.Parent.Streamable)
	describe("Streamable", function() -- Line 44
		--[[ Upvalues[3]:
			[1]: var2_upvw (read and write)
			[2]: Streamable_upvr (readonly)
			[3]: var3_upvw (read and write)
		]]
		it("should detect instance that is immediately available", function() -- Line 45
			--[[ Upvalues[2]:
				[1]: var2_upvw (copied, read and write)
				[2]: Streamable_upvr (copied, readonly)
			]]
			local Folder_2 = Instance.new("Folder")
			Folder_2.Name = "TestImmediate"
			Folder_2.Archivable = false
			Folder_2.Parent = var2_upvw
			local var13 = Folder_2
			local any_new_result1 = Streamable_upvr.new(var2_upvw, "TestImmediate")
			local var15_upvw = 0
			local var16_upvw = 0
			any_new_result1:Observe(function(arg1, arg2) -- Line 50
				--[[ Upvalues[2]:
					[1]: var15_upvw (read and write)
					[2]: var16_upvw (read and write)
				]]
				var15_upvw += 1
				arg2:Add(function() -- Line 52
					--[[ Upvalues[1]:
						[1]: var16_upvw (copied, read and write)
					]]
					var16_upvw += 1
				end)
			end)
			task.wait()
			var13.Parent = nil
			task.wait()
			var13.Parent = var2_upvw
			task.wait()
			any_new_result1:Destroy()
			task.wait()
			expect(var15_upvw).to.equal(2)
			expect(var16_upvw).to.equal(2)
		end)
		it("should detect instance that is not immediately available", function() -- Line 67
			--[[ Upvalues[2]:
				[1]: Streamable_upvr (copied, readonly)
				[2]: var2_upvw (copied, read and write)
			]]
			local any_new_result1_2 = Streamable_upvr.new(var2_upvw, "TestImmediate")
			local var21_upvw = 0
			local var22_upvw = 0
			any_new_result1_2:Observe(function(arg1, arg2) -- Line 71
				--[[ Upvalues[2]:
					[1]: var21_upvw (read and write)
					[2]: var22_upvw (read and write)
				]]
				var21_upvw += 1
				arg2:Add(function() -- Line 73
					--[[ Upvalues[1]:
						[1]: var22_upvw (copied, read and write)
					]]
					var22_upvw += 1
				end)
			end)
			task.wait(0.1)
			local Folder_3 = Instance.new("Folder")
			Folder_3.Name = "TestImmediate"
			Folder_3.Archivable = false
			Folder_3.Parent = var2_upvw
			local var26 = Folder_3
			task.wait()
			var26.Parent = nil
			task.wait()
			var26.Parent = var2_upvw
			task.wait()
			any_new_result1_2:Destroy()
			task.wait()
			expect(var21_upvw).to.equal(2)
			expect(var22_upvw).to.equal(2)
		end)
		it("should detect primary part that is immediately available", function() -- Line 90
			--[[ Upvalues[2]:
				[1]: var3_upvw (copied, read and write)
				[2]: Streamable_upvr (copied, readonly)
			]]
			local Part_3 = Instance.new("Part")
			Part_3.Anchored = true
			Part_3.Parent = var3_upvw
			var3_upvw.PrimaryPart = Part_3
			local var29 = Part_3
			local any_primary_result1_2 = Streamable_upvr.primary(var3_upvw)
			local var31_upvw = 0
			local var32_upvw = 0
			any_primary_result1_2:Observe(function(arg1, arg2) -- Line 95
				--[[ Upvalues[2]:
					[1]: var31_upvw (read and write)
					[2]: var32_upvw (read and write)
				]]
				var31_upvw += 1
				arg2:Add(function() -- Line 97
					--[[ Upvalues[1]:
						[1]: var32_upvw (copied, read and write)
					]]
					var32_upvw += 1
				end)
			end)
			task.wait()
			var29.Parent = nil
			task.wait()
			var29.Parent = var3_upvw
			var3_upvw.PrimaryPart = var29
			task.wait()
			any_primary_result1_2:Destroy()
			task.wait()
			expect(var31_upvw).to.equal(2)
			expect(var32_upvw).to.equal(2)
		end)
		it("should detect primary part that is not immediately available", function() -- Line 113
			--[[ Upvalues[2]:
				[1]: Streamable_upvr (copied, readonly)
				[2]: var3_upvw (copied, read and write)
			]]
			local any_primary_result1 = Streamable_upvr.primary(var3_upvw)
			local var37_upvw = 0
			local var38_upvw = 0
			any_primary_result1:Observe(function(arg1, arg2) -- Line 117
				--[[ Upvalues[2]:
					[1]: var37_upvw (read and write)
					[2]: var38_upvw (read and write)
				]]
				var37_upvw += 1
				arg2:Add(function() -- Line 119
					--[[ Upvalues[1]:
						[1]: var38_upvw (copied, read and write)
					]]
					var38_upvw += 1
				end)
			end)
			task.wait(0.1)
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.Parent = var3_upvw
			var3_upvw.PrimaryPart = Part
			local var42 = Part
			task.wait()
			var42.Parent = nil
			task.wait()
			var42.Parent = var3_upvw
			var3_upvw.PrimaryPart = var42
			task.wait()
			any_primary_result1:Destroy()
			task.wait()
			expect(var37_upvw).to.equal(2)
			expect(var38_upvw).to.equal(2)
		end)
	end)
end