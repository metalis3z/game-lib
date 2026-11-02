-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:13
-- Luau version 6, Types version 3
-- Time taken: 0.001437 seconds

return function() -- Line 1
	local var2_upvw
	local function _(arg1) -- Line 7, Named "CreateInstance"
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		local Folder_3 = Instance.new("Folder")
		Folder_3.Name = arg1
		Folder_3.Archivable = false
		Folder_3.Parent = var2_upvw
		return Folder_3
	end
	beforeAll(function() -- Line 15
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		var2_upvw = Instance.new("Folder")
		var2_upvw.Name = "KnitTest"
		var2_upvw.Archivable = false
		var2_upvw.Parent = workspace
	end)
	afterEach(function() -- Line 22
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		var2_upvw:ClearAllChildren()
	end)
	afterAll(function() -- Line 26
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		var2_upvw:Destroy()
	end)
	local Streamable_upvr = require(script.Parent.Streamable)
	local StreamableUtil_upvr = require(script.Parent.StreamableUtil)
	describe("Compound", function() -- Line 30
		--[[ Upvalues[3]:
			[1]: Streamable_upvr (readonly)
			[2]: var2_upvw (read and write)
			[3]: StreamableUtil_upvr (readonly)
		]]
		it("should capture multiple streams", function() -- Line 31
			--[[ Upvalues[3]:
				[1]: Streamable_upvr (copied, readonly)
				[2]: var2_upvw (copied, read and write)
				[3]: StreamableUtil_upvr (copied, readonly)
			]]
			local any_new_result1 = Streamable_upvr.new(var2_upvw, "ABC")
			local any_new_result1_2 = Streamable_upvr.new(var2_upvw, "XYZ")
			local var13_upvw = 0
			local var14_upvw = 0
			StreamableUtil_upvr.Compound({
				S1 = any_new_result1;
				S2 = any_new_result1_2;
			}, function(arg1, arg2) -- Line 36
				--[[ Upvalues[2]:
					[1]: var13_upvw (read and write)
					[2]: var14_upvw (read and write)
				]]
				var13_upvw += 1
				arg2:Add(function() -- Line 38
					--[[ Upvalues[1]:
						[1]: var14_upvw (copied, read and write)
					]]
					var14_upvw += 1
				end)
			end)
			local Folder = Instance.new("Folder")
			Folder.Name = "ABC"
			Folder.Archivable = false
			Folder.Parent = var2_upvw
			local var19 = Folder
			local Folder_2 = Instance.new("Folder")
			Folder_2.Name = "XYZ"
			Folder_2.Archivable = false
			Folder_2.Parent = var2_upvw
			local var21 = Folder_2
			task.wait()
			var19.Parent = nil
			task.wait()
			var19.Parent = var2_upvw
			task.wait()
			var19.Parent = nil
			var21.Parent = nil
			task.wait()
			var21.Parent = var2_upvw
			task.wait()
			expect(var13_upvw).to.equal(2)
			expect(var14_upvw).to.equal(2)
			any_new_result1:Destroy()
			any_new_result1_2:Destroy()
		end)
	end)
end