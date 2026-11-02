-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:05
-- Luau version 6, Types version 3
-- Time taken: 0.005136 seconds

local function AwaitCondition_upvr(arg1, arg2) -- Line 1, Named "AwaitCondition"
	while true do
		if arg1() then
			return true
		end
		if (arg2 or 10) < os.clock() - os.clock() then
			return false
		end
		task.wait()
	end
end
return function() -- Line 15
	--[[ Upvalues[1]:
		[1]: AwaitCondition_upvr (readonly)
	]]
	local Parent_upvr = require(script.Parent)
	local var3_upvw
	local function _(arg1) -- Line 20, Named "NumConns"
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		local var4 = arg1
		if not var4 then
			var4 = var3_upvw
		end
		return #var4:GetConnections()
	end
	beforeEach(function() -- Line 25
		--[[ Upvalues[2]:
			[1]: var3_upvw (read and write)
			[2]: Parent_upvr (readonly)
		]]
		var3_upvw = Parent_upvr.new()
	end)
	afterEach(function() -- Line 29
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		var3_upvw:Destroy()
	end)
	describe("Constructor", function() -- Line 33
		--[[ Upvalues[3]:
			[1]: Parent_upvr (readonly)
			[2]: var3_upvw (read and write)
			[3]: AwaitCondition_upvr (copied, readonly)
		]]
		it("should create a new signal and fire it", function() -- Line 34
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: var3_upvw (copied, read and write)
			]]
			expect(Parent_upvr.Is(var3_upvw)).to.equal(true)
			task.defer(function() -- Line 36
				--[[ Upvalues[1]:
					[1]: var3_upvw (copied, read and write)
				]]
				var3_upvw:Fire(10, 20)
			end)
			local any_Wait_result1, any_Wait_result2_2 = var3_upvw:Wait()
			expect(any_Wait_result1).to.equal(10)
			expect(any_Wait_result2_2).to.equal(20)
		end)
		it("should create a proxy signal and connect to it", function() -- Line 44
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: AwaitCondition_upvr (copied, readonly)
			]]
			local any_Wrap_result1 = Parent_upvr.Wrap(game:GetService("RunService").Heartbeat)
			expect(Parent_upvr.Is(any_Wrap_result1)).to.equal(true)
			local var14_upvw = false
			any_Wrap_result1:Connect(function() -- Line 48
				--[[ Upvalues[1]:
					[1]: var14_upvw (read and write)
				]]
				var14_upvw = true
			end)
			expect(AwaitCondition_upvr(function() -- Line 51
				--[[ Upvalues[1]:
					[1]: var14_upvw (read and write)
				]]
				return var14_upvw
			end, 2)).to.equal(true)
			any_Wrap_result1:Destroy()
		end)
	end)
	describe("FireDeferred", function() -- Line 58
		--[[ Upvalues[2]:
			[1]: var3_upvw (read and write)
			[2]: AwaitCondition_upvr (copied, readonly)
		]]
		it("should be able to fire primitive argument", function() -- Line 59
			--[[ Upvalues[2]:
				[1]: var3_upvw (copied, read and write)
				[2]: AwaitCondition_upvr (copied, readonly)
			]]
			local var19_upvw
			var3_upvw:Connect(function(arg1) -- Line 62
				--[[ Upvalues[1]:
					[1]: var19_upvw (read and write)
				]]
				var19_upvw = arg1
			end)
			var3_upvw:FireDeferred(10)
			expect(AwaitCondition_upvr(function() -- Line 66
				--[[ Upvalues[1]:
					[1]: var19_upvw (read and write)
				]]
				local var22
				if var19_upvw ~= 10 then
					var22 = false
				else
					var22 = true
				end
				return var22
			end, 1)).to.equal(true)
		end)
		it("should be able to fire a reference based argument", function() -- Line 71
			--[[ Upvalues[2]:
				[1]: var3_upvw (copied, read and write)
				[2]: AwaitCondition_upvr (copied, readonly)
			]]
			local tbl_2_upvr = {10, 20}
			local var25_upvw
			var3_upvw:Connect(function(arg1) -- Line 74
				--[[ Upvalues[1]:
					[1]: var25_upvw (read and write)
				]]
				var25_upvw = arg1
			end)
			var3_upvw:FireDeferred(tbl_2_upvr)
			expect(AwaitCondition_upvr(function() -- Line 78
				--[[ Upvalues[2]:
					[1]: tbl_2_upvr (readonly)
					[2]: var25_upvw (read and write)
				]]
				local var28
				if tbl_2_upvr ~= var25_upvw then
					var28 = false
				else
					var28 = true
				end
				return var28
			end, 1)).to.equal(true)
		end)
	end)
	describe("Fire", function() -- Line 84
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		it("should be able to fire primitive argument", function() -- Line 85
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			local var31_upvw
			var3_upvw:Connect(function(arg1) -- Line 88
				--[[ Upvalues[1]:
					[1]: var31_upvw (read and write)
				]]
				var31_upvw = arg1
			end)
			var3_upvw:Fire(10)
			expect(var31_upvw).to.equal(10)
		end)
		it("should be able to fire a reference based argument", function() -- Line 95
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			local tbl = {10, 20}
			local var35_upvw
			var3_upvw:Connect(function(arg1) -- Line 98
				--[[ Upvalues[1]:
					[1]: var35_upvw (read and write)
				]]
				var35_upvw = arg1
			end)
			var3_upvw:Fire(tbl)
			expect(var35_upvw).to.equal(tbl)
		end)
	end)
	describe("ConnectOnce", function() -- Line 106
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		it("should only capture first fire", function() -- Line 107
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			local var39_upvw
			local any_ConnectOnce_result1 = var3_upvw:ConnectOnce(function(arg1) -- Line 109
				--[[ Upvalues[1]:
					[1]: var39_upvw (read and write)
				]]
				var39_upvw = arg1
			end)
			expect(any_ConnectOnce_result1.Connected).to.equal(true)
			var3_upvw:Fire(10)
			expect(any_ConnectOnce_result1.Connected).to.equal(false)
			var3_upvw:Fire(20)
			expect(var39_upvw).to.equal(10)
		end)
	end)
	describe("Wait", function() -- Line 120
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		it("should be able to wait for a signal to fire", function() -- Line 121
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			task.defer(function() -- Line 122
				--[[ Upvalues[1]:
					[1]: var3_upvw (copied, read and write)
				]]
				var3_upvw:Fire(10, 20, 30)
			end)
			local any_Wait_result1_2, any_Wait_result2, any_Wait_result3 = var3_upvw:Wait()
			expect(any_Wait_result1_2).to.equal(10)
			expect(any_Wait_result2).to.equal(20)
			expect(any_Wait_result3).to.equal(30)
		end)
	end)
	describe("DisconnectAll", function() -- Line 132
		--[[ Upvalues[1]:
			[1]: var3_upvw (read and write)
		]]
		it("should disconnect all connections", function() -- Line 133
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			var3_upvw:Connect(function() -- Line 134
			end)
			var3_upvw:Connect(function() -- Line 135
			end)
			local var52
			if not var52 then
				var52 = var3_upvw
			end
			expect(#var52:GetConnections()).to.equal(2)
			var3_upvw:DisconnectAll()
			local var53
			if not var53 then
				var53 = var3_upvw
			end
			expect(#var53:GetConnections()).to.equal(0)
		end)
	end)
	describe("Disconnect", function() -- Line 142
		--[[ Upvalues[2]:
			[1]: var3_upvw (read and write)
			[2]: AwaitCondition_upvr (copied, readonly)
		]]
		it("should disconnect connection", function() -- Line 143
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			local var57
			if not var57 then
				var57 = var3_upvw
			end
			expect(#var57:GetConnections()).to.equal(1)
			var3_upvw:Connect(function() -- Line 144
			end):Disconnect()
			local var58
			if not var58 then
				var58 = var3_upvw
			end
			expect(#var58:GetConnections()).to.equal(0)
		end)
		it("should still work if connections disconnected while firing", function() -- Line 150
			--[[ Upvalues[1]:
				[1]: var3_upvw (copied, read and write)
			]]
			local var60_upvw = 0
			var3_upvw:Connect(function() -- Line 153
				--[[ Upvalues[1]:
					[1]: var60_upvw (read and write)
				]]
				var60_upvw += 1
			end)
			local var63_upvw
			var63_upvw = var3_upvw:Connect(function() -- Line 156
				--[[ Upvalues[2]:
					[1]: var63_upvw (read and write)
					[2]: var60_upvw (read and write)
				]]
				var63_upvw:Disconnect()
				var60_upvw += 1
			end)
			var3_upvw:Connect(function() -- Line 160
				--[[ Upvalues[1]:
					[1]: var60_upvw (read and write)
				]]
				var60_upvw += 1
			end)
			var3_upvw:Fire()
			expect(var60_upvw).to.equal(3)
		end)
		it("should still work if connections disconnected while firing deferred", function() -- Line 167
			--[[ Upvalues[2]:
				[1]: var3_upvw (copied, read and write)
				[2]: AwaitCondition_upvr (copied, readonly)
			]]
			local var66_upvw = 0
			var3_upvw:Connect(function() -- Line 170
				--[[ Upvalues[1]:
					[1]: var66_upvw (read and write)
				]]
				var66_upvw += 1
			end)
			local var69_upvw
			var69_upvw = var3_upvw:Connect(function() -- Line 173
				--[[ Upvalues[2]:
					[1]: var69_upvw (read and write)
					[2]: var66_upvw (read and write)
				]]
				var69_upvw:Disconnect()
				var66_upvw += 1
			end)
			var3_upvw:Connect(function() -- Line 177
				--[[ Upvalues[1]:
					[1]: var66_upvw (read and write)
				]]
				var66_upvw += 1
			end)
			var3_upvw:FireDeferred()
			expect(AwaitCondition_upvr(function() -- Line 181
				--[[ Upvalues[1]:
					[1]: var66_upvw (read and write)
				]]
				local var72
				if var66_upvw ~= 3 then
					var72 = false
				else
					var72 = true
				end
				return var72
			end)).to.equal(true)
		end)
	end)
end