-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:32
-- Luau version 6, Types version 3
-- Time taken: 0.046786 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	Parent_upvr.TEST = true
	local BindableEvent_upvr_5 = Instance.new("BindableEvent")
	Parent_upvr._timeEvent = BindableEvent_upvr_5.Event
	local var4_upvw = 0
	function Parent_upvr._getTime() -- Line 12
		--[[ Upvalues[1]:
			[1]: var4_upvw (read and write)
		]]
		return var4_upvw
	end
	local function advanceTime_upvw(arg1) -- Line 16, Named "advanceTime"
		--[[ Upvalues[2]:
			[1]: var4_upvw (read and write)
			[2]: BindableEvent_upvr_5 (readonly)
		]]
		local var6 = arg1 or (1/60)
		var4_upvw += var6
		BindableEvent_upvr_5:Fire(var6)
	end
	local function pack_upvr(...) -- Line 24, Named "pack"
		return select('#', ...), {...}
	end
	describe("Promise.Status", function() -- Line 30
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should error if indexing nil value", function() -- Line 31
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 32
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
			end).to.throw()
		end)
	end)
	describe("Unhandled rejection signal", function() -- Line 38
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should call unhandled rejection callbacks", function() -- Line 39
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local var14_upvw = 0
			local any_new_result1_30_upvr = Parent_upvr.new(function(arg1, arg2) -- Line 40
				arg2(1, 2)
			end)
			advanceTime_upvw()
			expect(var14_upvw).to.equal(1)
			Parent_upvr.onUnhandledRejection(function(arg1, arg2, arg3) -- Line 46, Named "callback"
				--[[ Upvalues[2]:
					[1]: var14_upvw (read and write)
					[2]: any_new_result1_30_upvr (readonly)
				]]
				var14_upvw += 1
				expect(arg1).to.equal(any_new_result1_30_upvr)
				expect(arg2).to.equal(1)
				expect(arg3).to.equal(2)
			end)()
			Parent_upvr.new(function(arg1, arg2) -- Line 62
				arg2(3, 4)
			end)
			advanceTime_upvw()
			expect(var14_upvw).to.equal(1)
		end)
	end)
	describe("Promise.new", function() -- Line 72
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should instantiate with a callback", function() -- Line 73
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.new(function() -- Line 74
			end)).to.be.ok()
		end)
		it("should invoke the given callback with resolve and reject", function() -- Line 79
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var21_upvw = 0
			local var22_upvw
			local var23_upvw
			local any_new_result1_8 = Parent_upvr.new(function(arg1, arg2) -- Line 84
				--[[ Upvalues[3]:
					[1]: var21_upvw (read and write)
					[2]: var22_upvw (read and write)
					[3]: var23_upvw (read and write)
				]]
				var21_upvw += 1
				var22_upvw = arg1
				var23_upvw = arg2
			end)
			expect(any_new_result1_8).to.be.ok()
			expect(var21_upvw).to.equal(1)
			expect(var22_upvw).to.be.a("function")
			expect(var23_upvw).to.be.a("function")
			expect(any_new_result1_8:getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
		it("should resolve promises on resolve()", function() -- Line 98
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var27_upvw = 0
			local any_new_result1_27 = Parent_upvr.new(function(arg1) -- Line 101
				--[[ Upvalues[1]:
					[1]: var27_upvw (read and write)
				]]
				var27_upvw += 1
				arg1()
			end)
			expect(any_new_result1_27).to.be.ok()
			expect(var27_upvw).to.equal(1)
			expect(any_new_result1_27:getStatus()).to.equal(Parent_upvr.Status.Resolved)
		end)
		it("should reject promises on reject()", function() -- Line 111
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var31_upvw = 0
			local any_new_result1_6 = Parent_upvr.new(function(arg1, arg2) -- Line 114
				--[[ Upvalues[1]:
					[1]: var31_upvw (read and write)
				]]
				var31_upvw += 1
				arg2()
			end)
			expect(any_new_result1_6).to.be.ok()
			expect(var31_upvw).to.equal(1)
			expect(any_new_result1_6:getStatus()).to.equal(Parent_upvr.Status.Rejected)
		end)
		it("should reject on error in callback", function() -- Line 124
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var35_upvw = 0
			local any_new_result1_12 = Parent_upvr.new(function() -- Line 127
				--[[ Upvalues[1]:
					[1]: var35_upvw (read and write)
				]]
				var35_upvw += 1
				error("hahah")
			end)
			expect(any_new_result1_12).to.be.ok()
			expect(var35_upvw).to.equal(1)
			expect(any_new_result1_12:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(tostring(any_new_result1_12._values[1]):find("hahah")).to.be.ok()
			expect(tostring(any_new_result1_12._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(any_new_result1_12._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should work with C functions", function() -- Line 142
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 143
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.new(tick):andThen(tick)
			end).to.never.throw()
		end)
		it("should have a nice tostring", function() -- Line 148
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(tostring(Parent_upvr.resolve()):gmatch("Promise(Resolved)")).to.be.ok()
		end)
		it("should allow yielding", function() -- Line 152
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent_upvr = Instance.new("BindableEvent")
			local any_new_result1_5 = Parent_upvr.new(function(arg1) -- Line 154
				--[[ Upvalues[1]:
					[1]: BindableEvent_upvr (readonly)
				]]
				BindableEvent_upvr.Event:Wait()
				arg1(5)
			end)
			expect(any_new_result1_5:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_upvr:Fire()
			expect(any_new_result1_5:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_new_result1_5._values[1]).to.equal(5)
		end)
		it("should preserve stack traces of resolve-chained promises", function() -- Line 165
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local function _(arg1) -- Line 166, Named "nestedCall"
				error(arg1)
			end
			local any_new_result1_11 = Parent_upvr.new(function(arg1) -- Line 170
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				arg1(Parent_upvr.new(function() -- Line 171
					error("sample text")
				end))
			end)
			expect(any_new_result1_11:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			local tostring_result1 = tostring(any_new_result1_11._values[1])
			expect(tostring_result1:find("sample text")).to.be.ok()
			expect(tostring_result1:find("nestedCall")).to.be.ok()
			expect(tostring_result1:find("runExecutor")).to.be.ok()
			expect(tostring_result1:find("runPlanNode")).to.be.ok()
			expect(tostring_result1:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
		end)
		it("should report errors from Promises with _error (< v2)", function() -- Line 188
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_reject_result1_2 = Parent_upvr.reject()
			any_reject_result1_2._error = "Sample error"
			local any_andThenReturn_result1 = Parent_upvr.resolve():andThenReturn(any_reject_result1_2)
			expect(any_andThenReturn_result1:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			local tostring_result1_2 = tostring(any_andThenReturn_result1._values[1])
			expect(tostring_result1_2:find("Sample error")).to.be.ok()
			expect(tostring_result1_2:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
			expect(tostring_result1_2:find("%[No stack trace available")).to.be.ok()
		end)
		it("should allow callable tables", function() -- Line 204
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_17 = {}
			local function __call(arg1, arg2) -- Line 206
				arg2(1)
			end
			tbl_17.__call = __call
			local var56_upvw = false
			Parent_upvr.new(setmetatable({}, tbl_17)):andThen(setmetatable({}, {
				__call = function(arg1, arg2) -- Line 213, Named "__call"
					--[[ Upvalues[1]:
						[1]: var56_upvw (read and write)
					]]
					expect(arg2).to.equal(1)
					var56_upvw = true
				end;
			}))
			expect(var56_upvw).to.equal(true)
		end)
		itSKIP("should close the thread after resolve", function() -- Line 222
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var59_upvw = 0
			Parent_upvr.new(function(arg1) -- Line 224
				--[[ Upvalues[2]:
					[1]: var59_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				var59_upvw += 1
				arg1()
				Parent_upvr.delay(1):await()
				var59_upvw += 1
			end)
			task.wait(1)
			expect(var59_upvw).to.equal(1)
		end)
	end)
	describe("Promise.defer", function() -- Line 237
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should execute after the time event", function() -- Line 238
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local var63_upvw = 0
			local any_defer_result1 = Parent_upvr.defer(function(arg1, arg2, arg3, arg4) -- Line 240
				--[[ Upvalues[1]:
					[1]: var63_upvw (read and write)
				]]
				expect(type(arg1)).to.equal("function")
				expect(type(arg2)).to.equal("function")
				expect(type(arg3)).to.equal("function")
				expect(type(arg4)).to.equal("nil")
				var63_upvw += 1
				arg1("foo")
			end)
			expect(var63_upvw).to.equal(0)
			expect(any_defer_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw()
			expect(var63_upvw).to.equal(1)
			expect(any_defer_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			advanceTime_upvw()
			expect(var63_upvw).to.equal(1)
		end)
	end)
	describe("Promise.delay", function() -- Line 263
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should schedule promise resolution", function() -- Line 264
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local any_delay_result1 = Parent_upvr.delay(1)
			expect(any_delay_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw()
			expect(any_delay_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw(1)
			expect(any_delay_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
		end)
		it("should allow for delays to be cancelled", function() -- Line 276
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local any_delay_result1_upvr = Parent_upvr.delay(2)
			Parent_upvr.delay(1):andThen(function() -- Line 279
				--[[ Upvalues[1]:
					[1]: any_delay_result1_upvr (readonly)
				]]
				any_delay_result1_upvr:cancel()
			end)
			expect(any_delay_result1_upvr:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw()
			expect(any_delay_result1_upvr:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw(1)
			expect(any_delay_result1_upvr:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			advanceTime_upvw(1)
		end)
	end)
	describe("Promise.resolve", function() -- Line 292
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should immediately resolve with a value", function() -- Line 293
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_resolve_result1_2 = Parent_upvr.resolve(5, 6)
			expect(any_resolve_result1_2).to.be.ok()
			expect(any_resolve_result1_2:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_resolve_result1_2._values[1]).to.equal(5)
			expect(any_resolve_result1_2._values[2]).to.equal(6)
		end)
		it("should chain onto passed promises", function() -- Line 302
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_resolve_result1 = Parent_upvr.resolve(Parent_upvr.new(function(arg1, arg2) -- Line 303
				arg2(7)
			end))
			expect(any_resolve_result1).to.be.ok()
			expect(any_resolve_result1:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_resolve_result1._values[1]).to.equal(7)
		end)
	end)
	describe("Promise.reject", function() -- Line 313
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should immediately reject with a value", function() -- Line 314
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_reject_result1_5 = Parent_upvr.reject(6, 7)
			expect(any_reject_result1_5).to.be.ok()
			expect(any_reject_result1_5:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_reject_result1_5._values[1]).to.equal(6)
			expect(any_reject_result1_5._values[2]).to.equal(7)
		end)
		it("should pass a promise as-is as an error", function() -- Line 323
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_15 = Parent_upvr.new(function(arg1) -- Line 324
				arg1(6)
			end)
			local any_reject_result1_3 = Parent_upvr.reject(any_new_result1_15)
			expect(any_reject_result1_3).to.be.ok()
			expect(any_reject_result1_3:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_reject_result1_3._values[1]).to.equal(any_new_result1_15)
		end)
	end)
	describe("Promise:andThen", function() -- Line 336
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: pack_upvr (readonly)
		]]
		it("should allow yielding", function() -- Line 337
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent_upvr_4 = Instance.new("BindableEvent")
			local any_andThen_result1_4 = Parent_upvr.resolve():andThen(function() -- Line 339
				--[[ Upvalues[1]:
					[1]: BindableEvent_upvr_4 (readonly)
				]]
				BindableEvent_upvr_4.Event:Wait()
				return 5
			end)
			expect(any_andThen_result1_4:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_upvr_4:Fire()
			expect(any_andThen_result1_4:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_andThen_result1_4._values[1]).to.equal(5)
		end)
		it("should run andThens on a new thread", function() -- Line 350
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var91_upvw
			local any_new_result1_29 = Parent_upvr.new(function(arg1) -- Line 354
				--[[ Upvalues[1]:
					[1]: var91_upvw (read and write)
				]]
				var91_upvw = arg1
			end)
			local BindableEvent_upvr_3 = Instance.new("BindableEvent")
			local any_andThen_result1 = any_new_result1_29:andThen(function() -- Line 363
				return "foo"
			end)
			expect(any_new_result1_29:getStatus()).to.equal(Parent_upvr.Status.Started)
			var91_upvw()
			expect(any_andThen_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_andThen_result1._values[1]).to.equal("foo")
			expect(any_new_result1_29:andThen(function() -- Line 358
				--[[ Upvalues[1]:
					[1]: BindableEvent_upvr_3 (readonly)
				]]
				BindableEvent_upvr_3.Event:Wait()
				return 5
			end):getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
		it("should chain onto resolved promises", function() -- Line 374
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: pack_upvr (copied, readonly)
			]]
			local var99_upvw
			local var100_upvw
			local var101_upvw = 0
			local var102_upvw = 0
			local any_resolve_result1_3 = Parent_upvr.resolve(5)
			local any_andThen_result1_5 = any_resolve_result1_3:andThen(function(...) -- Line 382
				--[[ Upvalues[4]:
					[1]: var100_upvw (read and write)
					[2]: var99_upvw (read and write)
					[3]: pack_upvr (copied, readonly)
					[4]: var101_upvw (read and write)
				]]
				local pack_result1_4, pack_result2_3 = pack_upvr(...)
				var100_upvw = pack_result1_4
				var99_upvw = pack_result2_3
				var101_upvw += 1
			end, function() -- Line 385
				--[[ Upvalues[1]:
					[1]: var102_upvw (read and write)
				]]
				var102_upvw += 1
			end)
			expect(var102_upvw).to.equal(0)
			expect(var101_upvw).to.equal(1)
			expect(var100_upvw).to.equal(1)
			expect(var99_upvw[1]).to.equal(5)
			expect(any_resolve_result1_3).to.be.ok()
			expect(any_resolve_result1_3:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_resolve_result1_3._values[1]).to.equal(5)
			expect(any_andThen_result1_5).to.be.ok()
			expect(any_andThen_result1_5).never.to.equal(any_resolve_result1_3)
			expect(any_andThen_result1_5:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_andThen_result1_5._values).to.equal(0)
		end)
		it("should chain onto rejected promises", function() -- Line 405
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: pack_upvr (copied, readonly)
			]]
			local var110_upvw
			local var111_upvw
			local var112_upvw = 0
			local var113_upvw = 0
			local any_reject_result1 = Parent_upvr.reject(5)
			local any_andThen_result1_12 = any_reject_result1:andThen(function(...) -- Line 413
				--[[ Upvalues[1]:
					[1]: var113_upvw (read and write)
				]]
				var113_upvw += 1
			end, function(...) -- Line 415
				--[[ Upvalues[4]:
					[1]: var111_upvw (read and write)
					[2]: var110_upvw (read and write)
					[3]: pack_upvr (copied, readonly)
					[4]: var112_upvw (read and write)
				]]
				local pack_result1_3, pack_result2_5 = pack_upvr(...)
				var111_upvw = pack_result1_3
				var110_upvw = pack_result2_5
				var112_upvw += 1
			end)
			expect(var113_upvw).to.equal(0)
			expect(var112_upvw).to.equal(1)
			expect(var111_upvw).to.equal(1)
			expect(var110_upvw[1]).to.equal(5)
			expect(any_reject_result1).to.be.ok()
			expect(any_reject_result1:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_reject_result1._values[1]).to.equal(5)
			expect(any_andThen_result1_12).to.be.ok()
			expect(any_andThen_result1_12).never.to.equal(any_reject_result1)
			expect(any_andThen_result1_12:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_andThen_result1_12._values).to.equal(0)
		end)
		it("should reject on error in callback", function() -- Line 436
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var121_upvw = 0
			local any_andThen_result1_9 = Parent_upvr.resolve(1):andThen(function() -- Line 439
				--[[ Upvalues[1]:
					[1]: var121_upvw (read and write)
				]]
				var121_upvw += 1
				error("hahah")
			end)
			expect(any_andThen_result1_9).to.be.ok()
			expect(var121_upvw).to.equal(1)
			expect(any_andThen_result1_9:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(tostring(any_andThen_result1_9._values[1]):find("hahah")).to.be.ok()
			expect(tostring(any_andThen_result1_9._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(any_andThen_result1_9._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should chain onto asynchronously resolved promises", function() -- Line 454
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var125_upvw
			local var126_upvw
			local var127_upvw = 0
			local var128_upvw = 0
			local var129_upvw
			local any_new_result1_33 = Parent_upvr.new(function(arg1) -- Line 461
				--[[ Upvalues[1]:
					[1]: var129_upvw (read and write)
				]]
				var129_upvw = arg1
			end)
			local any_andThen_result1_7 = any_new_result1_33:andThen(function(...) -- Line 465
				--[[ Upvalues[3]:
					[1]: var125_upvw (read and write)
					[2]: var126_upvw (read and write)
					[3]: var127_upvw (read and write)
				]]
				var125_upvw = {...}
				var126_upvw = select('#', ...)
				var127_upvw += 1
			end, function() -- Line 469
				--[[ Upvalues[1]:
					[1]: var128_upvw (read and write)
				]]
				var128_upvw += 1
			end)
			expect(var127_upvw).to.equal(0)
			expect(var128_upvw).to.equal(0)
			var129_upvw(6)
			expect(var128_upvw).to.equal(0)
			expect(var127_upvw).to.equal(1)
			expect(var126_upvw).to.equal(1)
			expect(var125_upvw[1]).to.equal(6)
			expect(any_new_result1_33).to.be.ok()
			expect(any_new_result1_33:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_new_result1_33._values[1]).to.equal(6)
			expect(any_andThen_result1_7).to.be.ok()
			expect(any_andThen_result1_7).never.to.equal(any_new_result1_33)
			expect(any_andThen_result1_7:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_andThen_result1_7._values).to.equal(0)
		end)
		it("should chain onto asynchronously rejected promises", function() -- Line 494
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var137_upvw
			local var138_upvw
			local var139_upvw = 0
			local var140_upvw = 0
			local var141_upvw
			local any_new_result1_13 = Parent_upvr.new(function(arg1, arg2) -- Line 501
				--[[ Upvalues[1]:
					[1]: var141_upvw (read and write)
				]]
				var141_upvw = arg2
			end)
			local any_andThen_result1_2 = any_new_result1_13:andThen(function() -- Line 505
				--[[ Upvalues[1]:
					[1]: var140_upvw (read and write)
				]]
				var140_upvw += 1
			end, function(...) -- Line 507
				--[[ Upvalues[3]:
					[1]: var137_upvw (read and write)
					[2]: var138_upvw (read and write)
					[3]: var139_upvw (read and write)
				]]
				var137_upvw = {...}
				var138_upvw = select('#', ...)
				var139_upvw += 1
			end)
			expect(var139_upvw).to.equal(0)
			expect(var140_upvw).to.equal(0)
			var141_upvw(6)
			expect(var140_upvw).to.equal(0)
			expect(var139_upvw).to.equal(1)
			expect(var138_upvw).to.equal(1)
			expect(var137_upvw[1]).to.equal(6)
			expect(any_new_result1_13).to.be.ok()
			expect(any_new_result1_13:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_new_result1_13._values[1]).to.equal(6)
			expect(any_andThen_result1_2).to.be.ok()
			expect(any_andThen_result1_2).never.to.equal(any_new_result1_13)
			expect(any_andThen_result1_2:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_andThen_result1_2._values).to.equal(0)
		end)
		it("should propagate errors through multiple levels", function() -- Line 534
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var149_upvw
			local var150_upvw
			local var151_upvw
			Parent_upvr.new(function(arg1, arg2) -- Line 536
				arg2(1, 2, 3)
			end):andThen(function() -- Line 538
			end):catch(function(arg1, arg2, arg3) -- Line 538
				--[[ Upvalues[3]:
					[1]: var149_upvw (read and write)
					[2]: var150_upvw (read and write)
					[3]: var151_upvw (read and write)
				]]
				var149_upvw = arg1
				var150_upvw = arg2
				var151_upvw = arg3
			end)
			expect(var149_upvw).to.equal(1)
			expect(var150_upvw).to.equal(2)
			expect(var151_upvw).to.equal(3)
		end)
		it("should not call queued callbacks from a cancelled sub-promise", function() -- Line 547
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var156_upvw
			local var157_upvw = 0
			local any_new_result1_26 = Parent_upvr.new(function(arg1) -- Line 551
				--[[ Upvalues[1]:
					[1]: var156_upvw (read and write)
				]]
				var156_upvw = arg1
			end)
			any_new_result1_26:andThen(function() -- Line 555
				--[[ Upvalues[1]:
					[1]: var157_upvw (read and write)
				]]
				var157_upvw += 1
			end)
			any_new_result1_26:andThen(function() -- Line 560
				--[[ Upvalues[1]:
					[1]: var157_upvw (read and write)
				]]
				var157_upvw += 1
			end):cancel()
			var156_upvw("foo")
			expect(var157_upvw).to.equal(1)
		end)
	end)
	describe("Promise:cancel", function() -- Line 571
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should mark promises as cancelled and not resolve or reject them", function() -- Line 572
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var164_upvw = 0
			local var165_upvw = 0
			local any_finally_result1_3 = Parent_upvr.new(function() -- Line 575
			end):andThen(function() -- Line 576
				--[[ Upvalues[1]:
					[1]: var164_upvw (read and write)
				]]
				var164_upvw += 1
			end):finally(function() -- Line 579
				--[[ Upvalues[1]:
					[1]: var165_upvw (read and write)
				]]
				var165_upvw += 1
			end)
			any_finally_result1_3:cancel()
			any_finally_result1_3:cancel()
			expect(var164_upvw).to.equal(0)
			expect(var165_upvw).to.equal(1)
			expect(any_finally_result1_3:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should call the cancellation hook once", function() -- Line 591
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var171_upvw = 0
			local any_new_result1_28 = Parent_upvr.new(function(arg1, arg2, arg3) -- Line 594
				--[[ Upvalues[1]:
					[1]: var171_upvw (read and write)
				]]
				arg3(function() -- Line 595
					--[[ Upvalues[1]:
						[1]: var171_upvw (copied, read and write)
					]]
					var171_upvw += 1
				end)
			end)
			any_new_result1_28:cancel()
			any_new_result1_28:cancel()
			expect(var171_upvw).to.equal(1)
		end)
		it("should propagate cancellations", function() -- Line 606
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_20 = Parent_upvr.new(function() -- Line 607
			end)
			local any_andThen_result1_11 = any_new_result1_20:andThen()
			local any_andThen_result1_6 = any_new_result1_20:andThen()
			expect(any_new_result1_20:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(any_andThen_result1_11:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(any_andThen_result1_6:getStatus()).to.equal(Parent_upvr.Status.Started)
			any_andThen_result1_11:cancel()
			expect(any_new_result1_20:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(any_andThen_result1_11:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_andThen_result1_6:getStatus()).to.equal(Parent_upvr.Status.Started)
			any_andThen_result1_6:cancel()
			expect(any_new_result1_20:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_andThen_result1_11:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_andThen_result1_6:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should affect downstream promises", function() -- Line 629
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_16 = Parent_upvr.new(function() -- Line 630
			end)
			any_new_result1_16:cancel()
			expect(any_new_result1_16:andThen():getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should track consumers", function() -- Line 638
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_resolve_result1_4 = Parent_upvr.resolve()
			local any_new_result1_2_upvr = Parent_upvr.new(function() -- Line 639
			end)
			local any_andThen_result1_8_upvr = any_resolve_result1_4:andThen(function() -- Line 641
				--[[ Upvalues[1]:
					[1]: any_new_result1_2_upvr (readonly)
				]]
				return any_new_result1_2_upvr
			end)
			local any_new_result1_10 = Parent_upvr.new(function(arg1) -- Line 644
				--[[ Upvalues[1]:
					[1]: any_andThen_result1_8_upvr (readonly)
				]]
				arg1(any_andThen_result1_8_upvr)
			end)
			local any_andThen_result1_10 = any_new_result1_10:andThen(function() -- Line 647
			end)
			expect(any_andThen_result1_8_upvr._parent).to.never.equal(any_resolve_result1_4)
			expect(any_new_result1_10._parent).to.never.equal(any_andThen_result1_8_upvr)
			expect(any_new_result1_10._consumers[any_andThen_result1_10]).to.be.ok()
			expect(any_andThen_result1_10._parent).to.equal(any_new_result1_10)
		end)
		it("should cancel resolved pending promises", function() -- Line 655
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_23_upvr = Parent_upvr.new(function() -- Line 656
			end)
			local any_finally_result1_4 = Parent_upvr.new(function(arg1) -- Line 658
				--[[ Upvalues[1]:
					[1]: any_new_result1_23_upvr (readonly)
				]]
				arg1(any_new_result1_23_upvr)
			end):finally(function() -- Line 660
			end)
			any_finally_result1_4:cancel()
			expect(any_new_result1_23_upvr._status).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_finally_result1_4._status).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should close the promise thread", function() -- Line 668
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local var200_upvw = 0
			Parent_upvr.new(function() -- Line 670
				--[[ Upvalues[2]:
					[1]: var200_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				var200_upvw += 1
				Parent_upvr.delay(1):await()
				var200_upvw += 1
			end):cancel()
			advanceTime_upvw(2)
			expect(var200_upvw).to.equal(1)
		end)
	end)
	describe("Promise:finally", function() -- Line 683
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should be called upon resolve, reject, or cancel", function() -- Line 684
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var204_upvw = 0
			local function finally() -- Line 687
				--[[ Upvalues[1]:
					[1]: var204_upvw (read and write)
				]]
				var204_upvw += 1
			end
			Parent_upvr.new(function(arg1, arg2) -- Line 692
				arg1()
			end):finally(finally)
			Parent_upvr.resolve():andThen(function() -- Line 697
			end):finally(finally):finally(finally)
			Parent_upvr.reject():finally(finally)
			Parent_upvr.new(function() -- Line 702
			end):finally(finally):cancel()
			expect(var204_upvw).to.equal(5)
		end)
		it("should not forward return values", function() -- Line 708
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var209_upvw
			Parent_upvr.resolve(2):finally(function() -- Line 712
				return 1
			end):andThen(function(arg1) -- Line 715
				--[[ Upvalues[1]:
					[1]: var209_upvw (read and write)
				]]
				var209_upvw = arg1
			end)
			expect(var209_upvw).to.equal(2)
		end)
		it("should not consume rejections", function() -- Line 722
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var213_upvw = false
			local var214_upvw = false
			Parent_upvr.reject(5):finally(function() -- Line 726
				return 42
			end):andThen(function() -- Line 729
				--[[ Upvalues[1]:
					[1]: var214_upvw (read and write)
				]]
				var214_upvw = true
			end):catch(function(arg1) -- Line 732
				--[[ Upvalues[1]:
					[1]: var213_upvw (read and write)
				]]
				var213_upvw = true
				expect(arg1).to.equal(5)
			end)
			expect(var213_upvw).to.equal(true)
			expect(var214_upvw).to.equal(false)
		end)
		it("should wait for returned promises", function() -- Line 741
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var219_upvw
			local any_finally_result1_2 = Parent_upvr.reject("foo"):finally(function() -- Line 743
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: var219_upvw (read and write)
				]]
				return Parent_upvr.new(function(arg1) -- Line 744
					--[[ Upvalues[1]:
						[1]: var219_upvw (copied, read and write)
					]]
					var219_upvw = arg1
				end)
			end)
			expect(any_finally_result1_2:getStatus()).to.equal(Parent_upvr.Status.Started)
			var219_upvw()
			expect(any_finally_result1_2:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			local _, any__unwrap_result2_2 = any_finally_result1_2:_unwrap()
			expect(any__unwrap_result2_2).to.equal("foo")
		end)
		it("should reject with a returned rejected promise's value", function() -- Line 758
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var226_upvw
			local any_finally_result1 = Parent_upvr.reject("foo"):finally(function() -- Line 760
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: var226_upvw (read and write)
				]]
				return Parent_upvr.new(function(arg1, arg2) -- Line 761
					--[[ Upvalues[1]:
						[1]: var226_upvw (copied, read and write)
					]]
					var226_upvw = arg2
				end)
			end)
			expect(any_finally_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			var226_upvw("bar")
			expect(any_finally_result1:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			local _, any__unwrap_result2_5 = any_finally_result1:_unwrap()
			expect(any__unwrap_result2_5).to.equal("bar")
		end)
		it("should reject when handler errors", function() -- Line 775
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_6_upvr = {}
			local any__unwrap_result1_3, any__unwrap_result2_8 = Parent_upvr.reject("bar"):finally(function() -- Line 777
				--[[ Upvalues[1]:
					[1]: tbl_6_upvr (readonly)
				]]
				error(tbl_6_upvr)
			end):_unwrap()
			expect(any__unwrap_result1_3).to.equal(false)
			expect(any__unwrap_result2_8).to.equal(tbl_6_upvr)
		end)
		it("should not prevent cancellation", function() -- Line 787
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_9 = Parent_upvr.new(function() -- Line 788
			end)
			local var240_upvw = false
			any_new_result1_9:finally(function() -- Line 791
				--[[ Upvalues[1]:
					[1]: var240_upvw (read and write)
				]]
				var240_upvw = true
			end)
			any_new_result1_9:andThen(function() -- Line 795
			end):cancel()
			expect(any_new_result1_9:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(var240_upvw).to.equal(true)
		end)
		it("should propagate cancellation downwards", function() -- Line 803
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var244_upvw = false
			local any_new_result1_31 = Parent_upvr.new(function() -- Line 806
			end)
			any_new_result1_31:cancel()
			expect(any_new_result1_31:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_new_result1_31:finally(function() -- Line 808
				--[[ Upvalues[1]:
					[1]: var244_upvw (read and write)
				]]
				var244_upvw = true
			end):getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(var244_upvw).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should propagate cancellation upwards", function() -- Line 821
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var249_upvw = false
			local any_new_result1_4 = Parent_upvr.new(function() -- Line 824
			end)
			local any_finally_result1_5 = any_new_result1_4:finally(function() -- Line 826
				--[[ Upvalues[1]:
					[1]: var249_upvw (read and write)
				]]
				var249_upvw = true
			end)
			any_finally_result1_5:cancel()
			expect(any_new_result1_4:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_finally_result1_5:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(var249_upvw).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should cancel returned promise if cancelled", function() -- Line 839
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_7_upvr = Parent_upvr.new(function() -- Line 840
			end)
			Parent_upvr.resolve():finally(function() -- Line 842
				--[[ Upvalues[1]:
					[1]: any_new_result1_7_upvr (readonly)
				]]
				return any_new_result1_7_upvr
			end):cancel()
			expect(any_new_result1_7_upvr:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
	end)
	describe("Promise.all", function() -- Line 852
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: pack_upvr (readonly)
		]]
		it("should error if given something other than a table", function() -- Line 853
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 854
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.all(1)
			end).to.throw()
		end)
		it("should resolve instantly with an empty table if given no promises", function() -- Line 859
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_all_result1 = Parent_upvr.all({})
			local any__unwrap_result1_4, any__unwrap_result2_6 = any_all_result1:_unwrap()
			expect(any__unwrap_result1_4).to.equal(true)
			expect(any_all_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any__unwrap_result2_6).to.be.a("table")
			expect(next(any__unwrap_result2_6)).to.equal(nil)
		end)
		it("should error if given non-promise values", function() -- Line 869
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 870
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.all({{}, {}, {}})
			end).to.throw()
		end)
		it("should wait for all promises to be resolved and return their values", function() -- Line 875
			--[[ Upvalues[2]:
				[1]: pack_upvr (copied, readonly)
				[2]: Parent_upvr (copied, readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local tbl_3_upvr = {}
			local pack_result1_6, pack_result2_2_upvr = pack_upvr(1, "A string", nil, false)
			local tbl_12 = {}
			for i_upvr = 1, pack_result1_6 do
				tbl_12[i_upvr] = Parent_upvr.new(function(arg1) -- Line 883
					--[[ Upvalues[3]:
						[1]: tbl_3_upvr (readonly)
						[2]: i_upvr (readonly)
						[3]: pack_result2_2_upvr (readonly)
					]]
					local tbl = {}
					tbl[1] = arg1
					tbl[2] = pack_result2_2_upvr[i_upvr]
					tbl_3_upvr[i_upvr] = tbl
				end)
			end
			for _, v in ipairs(tbl_3_upvr) do
				expect(Parent_upvr.all(tbl_12):getStatus()).to.equal(Parent_upvr.Status.Started)
				v[1](v[2])
				local var295
			end
			local pack_result1_2, pack_result2_4 = pack_upvr(var295:_unwrap())
			local unpack_result1_3, unpack_result2_2 = unpack(pack_result2_4, 1, pack_result1_2)
			expect(pack_result1_2).to.equal(2)
			expect(unpack_result1_3).to.equal(true)
			expect(unpack_result2_2).to.be.a("table")
			expect(#unpack_result2_2).to.equal(#tbl_12)
			for i_3 = 1, pack_result1_6 do
				expect(unpack_result2_2[i_3]).to.equal(pack_result2_2_upvr[i_3])
				local _
			end
		end)
		it("should reject if any individual promise rejected", function() -- Line 908
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: pack_upvr (copied, readonly)
			]]
			local var302_upvw
			local var303_upvw
			local any_new_result1_21 = Parent_upvr.new(function(arg1) -- Line 916
				--[[ Upvalues[1]:
					[1]: var303_upvw (read and write)
				]]
				var303_upvw = arg1
			end)
			local any_all_result1_4 = Parent_upvr.all({Parent_upvr.new(function(arg1, arg2) -- Line 912
				--[[ Upvalues[1]:
					[1]: var302_upvw (read and write)
				]]
				var302_upvw = arg2
			end), any_new_result1_21})
			expect(any_all_result1_4:getStatus()).to.equal(Parent_upvr.Status.Started)
			var302_upvw("baz", "qux")
			var303_upvw("foo", "bar")
			local pack_result1_5, pack_result2_7 = pack_upvr(any_all_result1_4:_unwrap())
			local unpack_result1, unpack_result2_4, unpack_result3_2 = unpack(pack_result2_7, 1, pack_result1_5)
			expect(pack_result1_5).to.equal(3)
			expect(unpack_result1).to.equal(false)
			expect(unpack_result2_4).to.equal("baz")
			expect(unpack_result3_2).to.equal("qux")
			expect(any_new_result1_21:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should not resolve if resolved after rejecting", function() -- Line 937
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: pack_upvr (copied, readonly)
			]]
			local var315_upvw
			local var316_upvw
			local any_all_result1_2 = Parent_upvr.all({Parent_upvr.new(function(arg1, arg2) -- Line 941
				--[[ Upvalues[1]:
					[1]: var315_upvw (read and write)
				]]
				var315_upvw = arg2
			end), Parent_upvr.new(function(arg1) -- Line 945
				--[[ Upvalues[1]:
					[1]: var316_upvw (read and write)
				]]
				var316_upvw = arg1
			end)})
			expect(any_all_result1_2:getStatus()).to.equal(Parent_upvr.Status.Started)
			var315_upvw("baz", "qux")
			var316_upvw("foo", "bar")
			local pack_result1_7, pack_result2 = pack_upvr(any_all_result1_2:_unwrap())
			local unpack_result1_2, unpack_result2_3, unpack_result3 = unpack(pack_result2, 1, pack_result1_7)
			expect(pack_result1_7).to.equal(3)
			expect(unpack_result1_2).to.equal(false)
			expect(unpack_result2_3).to.equal("baz")
			expect(unpack_result3).to.equal("qux")
		end)
		it("should only reject once", function() -- Line 965
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: pack_upvr (copied, readonly)
			]]
			local var327_upvw
			local var328_upvw
			local any_all_result1_3 = Parent_upvr.all({Parent_upvr.new(function(arg1, arg2) -- Line 969
				--[[ Upvalues[1]:
					[1]: var327_upvw (read and write)
				]]
				var327_upvw = arg2
			end), Parent_upvr.new(function(arg1, arg2) -- Line 973
				--[[ Upvalues[1]:
					[1]: var328_upvw (read and write)
				]]
				var328_upvw = arg2
			end)})
			expect(any_all_result1_3:getStatus()).to.equal(Parent_upvr.Status.Started)
			var327_upvw("foo", "bar")
			expect(any_all_result1_3:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			var328_upvw("baz", "qux")
			local pack_result1, pack_result2_6 = pack_upvr(any_all_result1_3:_unwrap())
			local unpack_result1_4, unpack_result2, unpack_result3_3 = unpack(pack_result2_6, 1, pack_result1)
			expect(pack_result1).to.equal(3)
			expect(unpack_result1_4).to.equal(false)
			expect(unpack_result2).to.equal("foo")
			expect(unpack_result3_3).to.equal("bar")
		end)
		it("should error if a non-array table is passed in", function() -- Line 996
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local pcall_result1, pcall_result2_3 = pcall(function() -- Line 997
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.all(Parent_upvr.new(function() -- Line 998
				end))
			end)
			expect(pcall_result1).to.be.ok()
			expect(pcall_result2_3:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel pending promises if one rejects", function() -- Line 1005
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_14 = Parent_upvr.new(function() -- Line 1006
			end)
			expect(Parent_upvr.all({Parent_upvr.resolve(), Parent_upvr.reject(), any_new_result1_14}):getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_new_result1_14:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should cancel promises if it is cancelled", function() -- Line 1015
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_18 = Parent_upvr.new(function() -- Line 1016
			end)
			any_new_result1_18:andThen(function() -- Line 1017
			end)
			local tbl_18 = {Parent_upvr.new(function() -- Line 1020
			end), Parent_upvr.new(function() -- Line 1021
			end), any_new_result1_18}
			Parent_upvr.all(tbl_18):cancel()
			expect(tbl_18[1]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_18[2]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_18[3]:getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
	end)
	describe("Promise.fold", function() -- Line 1033
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should return the initial value in a promise when the list is empty", function() -- Line 1034
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_2 = {}
			local any_fold_result1 = Parent_upvr.fold({}, function() -- Line 1036
				error("should not be called")
			end, tbl_2)
			expect(Parent_upvr.is(any_fold_result1)).to.equal(true)
			expect(any_fold_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_fold_result1:expect()).to.equal(tbl_2)
		end)
		it("should accept promises in the list", function() -- Line 1045
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var360_upvw
			local any_fold_result1_5 = Parent_upvr.fold({Parent_upvr.new(function(arg1) -- Line 1048
				--[[ Upvalues[1]:
					[1]: var360_upvw (read and write)
				]]
				var360_upvw = arg1
			end), 2, 3}, function(arg1, arg2) -- Line 1050
				return arg1 + arg2
			end, 0)
			var360_upvw(1)
			expect(Parent_upvr.is(any_fold_result1_5)).to.equal(true)
			expect(any_fold_result1_5:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_fold_result1_5:expect()).to.equal(6)
		end)
		it("should always return a promise even if the list or reducer don't use them", function() -- Line 1061
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local any_fold_result1_3 = Parent_upvr.fold({1, 2, 3}, function(arg1, arg2, arg3) -- Line 1062
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				if arg3 == 2 then
					return Parent_upvr.delay(1):andThenReturn(arg1 + arg2)
				end
				return arg1 + arg2
			end, 0)
			expect(Parent_upvr.is(any_fold_result1_3)).to.equal(true)
			expect(any_fold_result1_3:getStatus()).to.equal(Parent_upvr.Status.Started)
			advanceTime_upvw(2)
			expect(any_fold_result1_3:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_fold_result1_3:expect()).to.equal(6)
		end)
		it("should return the first rejected promise", function() -- Line 1076
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_fold_result1_4 = Parent_upvr.fold({1, 2, 3}, function(arg1, arg2, arg3) -- Line 1078
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				if arg3 == 2 then
					return Parent_upvr.reject("foo")
				end
				return arg1 + arg2
			end, 0)
			expect(Parent_upvr.is(any_fold_result1_4)).to.equal(true)
			local any_awaitStatus_result1, any_awaitStatus_result2 = any_fold_result1_4:awaitStatus()
			expect(any_awaitStatus_result1).to.equal(Parent_upvr.Status.Rejected)
			expect(any_awaitStatus_result2).to.equal("foo")
		end)
		it("should return the first canceled promise", function() -- Line 1091
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var376_upvw
			local any_fold_result1_2 = Parent_upvr.fold({1, 2, 3}, function(arg1, arg2, arg3) -- Line 1093
				--[[ Upvalues[2]:
					[1]: var376_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				if arg3 == 1 then
					return arg1 + arg2
				end
				if arg3 == 2 then
					var376_upvw = Parent_upvr.delay(1):andThenReturn(arg1 + arg2)
					return var376_upvw
				end
				error("this should not run if the promise is cancelled")
			end, 0)
			expect(Parent_upvr.is(any_fold_result1_2)).to.equal(true)
			expect(any_fold_result1_2:getStatus()).to.equal(Parent_upvr.Status.Started)
			var376_upvw:cancel()
			expect(any_fold_result1_2:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
	end)
	describe("Promise.race", function() -- Line 1110
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should resolve with the first settled value", function() -- Line 1111
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.race({Parent_upvr.resolve(1), Parent_upvr.resolve(2)}):andThen(function(arg1) -- Line 1115
				expect(arg1).to.equal(1)
			end):getStatus()).to.equal(Parent_upvr.Status.Resolved)
		end)
		it("should cancel other promises", function() -- Line 1122
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_32 = Parent_upvr.new(function() -- Line 1123
			end)
			any_new_result1_32:andThen(function() -- Line 1124
			end)
			local tbl_15 = {any_new_result1_32, Parent_upvr.new(function() -- Line 1127
			end), Parent_upvr.new(function(arg1) -- Line 1128
				arg1(2)
			end)}
			local any_race_result1 = Parent_upvr.race(tbl_15)
			expect(any_race_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_race_result1._values[1]).to.equal(2)
			expect(tbl_15[1]:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(tbl_15[2]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_15[3]:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			local any_new_result1_19 = Parent_upvr.new(function() -- Line 1141
			end)
			expect(Parent_upvr.race({Parent_upvr.reject(), Parent_upvr.resolve(), any_new_result1_19}):getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_new_result1_19:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should error if a non-array table is passed in", function() -- Line 1150
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local pcall_result1_3, pcall_result2 = pcall(function() -- Line 1151
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.race(Parent_upvr.new(function() -- Line 1152
				end))
			end)
			expect(pcall_result1_3).to.be.ok()
			expect(pcall_result2:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel promises if it is cancelled", function() -- Line 1159
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_3 = Parent_upvr.new(function() -- Line 1160
			end)
			any_new_result1_3:andThen(function() -- Line 1161
			end)
			local tbl_16 = {Parent_upvr.new(function() -- Line 1164
			end), Parent_upvr.new(function() -- Line 1165
			end), any_new_result1_3}
			Parent_upvr.race(tbl_16):cancel()
			expect(tbl_16[1]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_16[2]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_16[3]:getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
	end)
	describe("Promise.promisify", function() -- Line 1177
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should wrap functions", function() -- Line 1178
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var409 = Parent_upvr.promisify(function(arg1) -- Line 1179, Named "test"
				return arg1 + 1
			end)(1)
			local any__unwrap_result1, any__unwrap_result2_3 = var409:_unwrap()
			expect(any__unwrap_result1).to.equal(true)
			expect(var409:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any__unwrap_result2_3).to.equal(2)
		end)
		it("should catch errors after a yield", function() -- Line 1192
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent_2_upvr = Instance.new("BindableEvent")
			local var415 = Parent_upvr.promisify(function() -- Line 1194
				--[[ Upvalues[1]:
					[1]: BindableEvent_2_upvr (readonly)
				]]
				BindableEvent_2_upvr.Event:Wait()
				error("errortext")
			end)()
			expect(var415:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_2_upvr:Fire()
			expect(var415:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(tostring(var415._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise.tap", function() -- Line 1208
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should thread through values", function() -- Line 1209
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var418_upvw
			local var419_upvw
			Parent_upvr.resolve(1):andThen(function(arg1) -- Line 1213
				return arg1 + 1
			end):tap(function(arg1) -- Line 1216
				--[[ Upvalues[1]:
					[1]: var418_upvw (read and write)
				]]
				var418_upvw = arg1
				return arg1 + 1
			end):andThen(function(arg1) -- Line 1220
				--[[ Upvalues[1]:
					[1]: var419_upvw (read and write)
				]]
				var419_upvw = arg1
			end)
			expect(var418_upvw).to.equal(2)
			expect(var419_upvw).to.equal(2)
		end)
		it("should chain onto promises", function() -- Line 1228
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var424_upvw
			local var425_upvw
			local any_andThen_result1_3 = Parent_upvr.resolve(1):tap(function() -- Line 1232
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: var424_upvw (read and write)
				]]
				return Parent_upvr.new(function(arg1) -- Line 1233
					--[[ Upvalues[1]:
						[1]: var424_upvw (copied, read and write)
					]]
					var424_upvw = arg1
				end)
			end):andThen(function(arg1) -- Line 1237
				--[[ Upvalues[1]:
					[1]: var425_upvw (read and write)
				]]
				var425_upvw = arg1
			end)
			expect(any_andThen_result1_3:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(var425_upvw).to.never.be.ok()
			var424_upvw(1)
			expect(any_andThen_result1_3:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(var425_upvw).to.equal(1)
		end)
	end)
	describe("Promise.try", function() -- Line 1251
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should catch synchronous errors", function() -- Line 1252
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var432_upvw
			Parent_upvr.try(function() -- Line 1254
				error("errortext")
			end):catch(function(arg1) -- Line 1256
				--[[ Upvalues[1]:
					[1]: var432_upvw (read and write)
				]]
				var432_upvw = tostring(arg1)
			end)
			expect(var432_upvw:find("errortext")).to.be.ok()
		end)
		it("should reject with error objects", function() -- Line 1263
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_14_upvr = {}
			local any__unwrap_result1_8, any__unwrap_result2_10 = Parent_upvr.try(function() -- Line 1265
				--[[ Upvalues[1]:
					[1]: tbl_14_upvr (readonly)
				]]
				error(tbl_14_upvr)
			end):_unwrap()
			expect(any__unwrap_result1_8).to.equal(false)
			expect(any__unwrap_result2_10).to.equal(tbl_14_upvr)
		end)
		it("should catch asynchronous errors", function() -- Line 1273
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent_upvr_2 = Instance.new("BindableEvent")
			local any_try_result1 = Parent_upvr.try(function() -- Line 1275
				--[[ Upvalues[1]:
					[1]: BindableEvent_upvr_2 (readonly)
				]]
				BindableEvent_upvr_2.Event:Wait()
				error("errortext")
			end)
			expect(any_try_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_upvr_2:Fire()
			expect(any_try_result1:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(tostring(any_try_result1._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise:andThenReturn", function() -- Line 1287
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should return the given values", function() -- Line 1288
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var446_upvw
			local var447_upvw
			Parent_upvr.resolve():andThenReturn(1, 2):andThen(function(arg1, arg2) -- Line 1291
				--[[ Upvalues[2]:
					[1]: var446_upvw (read and write)
					[2]: var447_upvw (read and write)
				]]
				var446_upvw = arg1
				var447_upvw = arg2
			end)
			expect(var446_upvw).to.equal(1)
			expect(var447_upvw).to.equal(2)
		end)
	end)
	describe("Promise:andThenCall", function() -- Line 1301
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should call the given function with arguments", function() -- Line 1302
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var451_upvw
			local var452_upvw
			Parent_upvr.resolve():andThenCall(function(arg1, arg2) -- Line 1304
				--[[ Upvalues[2]:
					[1]: var451_upvw (read and write)
					[2]: var452_upvw (read and write)
				]]
				var451_upvw = arg1
				var452_upvw = arg2
			end, 3, 4)
			expect(var451_upvw).to.equal(3)
			expect(var452_upvw).to.equal(4)
		end)
	end)
	describe("Promise.some", function() -- Line 1314
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should resolve once the goal is reached", function() -- Line 1315
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_some_result1_2 = Parent_upvr.some({Parent_upvr.resolve(1), Parent_upvr.reject(), Parent_upvr.resolve(2)}, 2)
			expect(any_some_result1_2:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_some_result1_2._values[1][1]).to.equal(1)
			expect(any_some_result1_2._values[1][2]).to.equal(2)
		end)
		it("should error if the goal can't be reached", function() -- Line 1326
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.some({Parent_upvr.resolve(), Parent_upvr.reject()}, 2):getStatus()).to.equal(Parent_upvr.Status.Rejected)
			local var460_upvw
			local any_some_result1_3 = Parent_upvr.some({Parent_upvr.resolve(), Parent_upvr.new(function(arg1, arg2) -- Line 1335
				--[[ Upvalues[1]:
					[1]: var460_upvw (read and write)
				]]
				var460_upvw = arg2
			end)}, 2)
			expect(any_some_result1_3:getStatus()).to.equal(Parent_upvr.Status.Started)
			var460_upvw("foo")
			expect(any_some_result1_3:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_some_result1_3._values[1]).to.equal("foo")
		end)
		it("should cancel pending Promises once the goal is reached", function() -- Line 1346
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var465_upvw
			local any_new_result1_24 = Parent_upvr.new(function() -- Line 1348
			end)
			local any_new_result1_34 = Parent_upvr.new(function(arg1) -- Line 1349
				--[[ Upvalues[1]:
					[1]: var465_upvw (read and write)
				]]
				var465_upvw = arg1
			end)
			local any_some_result1_5 = Parent_upvr.some({any_new_result1_24, any_new_result1_34, Parent_upvr.resolve()}, 2)
			expect(any_some_result1_5:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(any_new_result1_24:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(any_new_result1_34:getStatus()).to.equal(Parent_upvr.Status.Started)
			var465_upvw()
			expect(any_some_result1_5:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_new_result1_24:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(any_new_result1_34:getStatus()).to.equal(Parent_upvr.Status.Resolved)
		end)
		it("should error if passed a non-number", function() -- Line 1370
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(function() -- Line 1371
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				Parent_upvr.some({}, "non-number")
			end).to.throw()
		end)
		it("should return an empty array if amount is 0", function() -- Line 1376
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_some_result1 = Parent_upvr.some({Parent_upvr.resolve(2)}, 0)
			expect(any_some_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_some_result1._values[1]).to.equal(0)
		end)
		it("should not return extra values", function() -- Line 1385
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_some_result1_4 = Parent_upvr.some({Parent_upvr.resolve(1), Parent_upvr.resolve(2), Parent_upvr.resolve(3), Parent_upvr.resolve(4)}, 2)
			expect(any_some_result1_4:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(#any_some_result1_4._values[1]).to.equal(2)
			expect(any_some_result1_4._values[1][1]).to.equal(1)
			expect(any_some_result1_4._values[1][2]).to.equal(2)
		end)
		it("should cancel promises if it is cancelled", function() -- Line 1399
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_25 = Parent_upvr.new(function() -- Line 1400
			end)
			any_new_result1_25:andThen(function() -- Line 1401
			end)
			local tbl_4 = {Parent_upvr.new(function() -- Line 1404
			end), Parent_upvr.new(function() -- Line 1405
			end), any_new_result1_25}
			Parent_upvr.some(tbl_4, 3):cancel()
			expect(tbl_4[1]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_4[2]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_4[3]:getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
		describe("Promise.any", function() -- Line 1416
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			it("should return the value directly", function() -- Line 1417
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				local any_any_result1 = Parent_upvr.any({Parent_upvr.reject(), Parent_upvr.reject(), Parent_upvr.resolve(1)})
				expect(any_any_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
				expect(any_any_result1._values[1]).to.equal(1)
			end)
			it("should error if all are rejected", function() -- Line 1428
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				expect(Parent_upvr.any({Parent_upvr.reject(), Parent_upvr.reject(), Parent_upvr.reject()}):getStatus()).to.equal(Parent_upvr.Status.Rejected)
			end)
		end)
	end)
	describe("Promise.allSettled", function() -- Line 1438
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should resolve with an array of PromiseStatuses", function() -- Line 1439
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var495_upvw
			local any_allSettled_result1 = Parent_upvr.allSettled({Parent_upvr.resolve(), Parent_upvr.reject(), Parent_upvr.resolve(), Parent_upvr.new(function(arg1, arg2) -- Line 1445
				--[[ Upvalues[1]:
					[1]: var495_upvw (read and write)
				]]
				var495_upvw = arg2
			end)})
			expect(any_allSettled_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			var495_upvw()
			expect(any_allSettled_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_allSettled_result1._values[1][1]).to.equal(Parent_upvr.Status.Resolved)
			expect(any_allSettled_result1._values[1][2]).to.equal(Parent_upvr.Status.Rejected)
			expect(any_allSettled_result1._values[1][3]).to.equal(Parent_upvr.Status.Resolved)
			expect(any_allSettled_result1._values[1][4]).to.equal(Parent_upvr.Status.Rejected)
		end)
		it("should cancel promises if it is cancelled", function() -- Line 1459
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_22 = Parent_upvr.new(function() -- Line 1460
			end)
			any_new_result1_22:andThen(function() -- Line 1461
			end)
			local tbl_10 = {Parent_upvr.new(function() -- Line 1464
			end), Parent_upvr.new(function() -- Line 1465
			end), any_new_result1_22}
			Parent_upvr.allSettled(tbl_10):cancel()
			expect(tbl_10[1]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_10[2]:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_10[3]:getStatus()).to.equal(Parent_upvr.Status.Started)
		end)
	end)
	describe("Promise:await", function() -- Line 1477
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should return the correct values", function() -- Line 1478
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_await_result1, any_await_result2_2, any_await_result3, any_await_result4, any_await_result5 = Parent_upvr.resolve(5, 6, nil, 7):await()
			expect(any_await_result1).to.equal(true)
			expect(any_await_result2_2).to.equal(5)
			expect(any_await_result3).to.equal(6)
			expect(any_await_result4).to.equal(nil)
			expect(any_await_result5).to.equal(7)
		end)
		it("should work if yielding is needed", function() -- Line 1490
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local var514_upvw = false
			task.spawn(function() -- Line 1492
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: var514_upvw (read and write)
				]]
				local _, any_await_result2 = Parent_upvr.delay(1):await()
				expect(type(any_await_result2)).to.equal("number")
				var514_upvw = true
			end)
			advanceTime_upvw(2)
			expect(var514_upvw).to.equal(true)
		end)
	end)
	describe("Promise:expect", function() -- Line 1503
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should throw the correct values", function() -- Line 1504
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_11 = {}
			local any_reject_result1_4_upvr = Parent_upvr.reject(tbl_11)
			local pcall_result1_2, pcall_result2_2 = pcall(function() -- Line 1508
				--[[ Upvalues[1]:
					[1]: any_reject_result1_4_upvr (readonly)
				]]
				any_reject_result1_4_upvr:expect()
			end)
			expect(pcall_result1_2).to.equal(false)
			expect(pcall_result2_2).to.equal(tbl_11)
		end)
	end)
	describe("Promise:now", function() -- Line 1517
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should resolve if the Promise is resolved", function() -- Line 1518
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any__unwrap_result1_7, any__unwrap_result2_9 = Parent_upvr.resolve("foo"):now():_unwrap()
			expect(any__unwrap_result1_7).to.equal(true)
			expect(any__unwrap_result2_9).to.equal("foo")
		end)
		it("should reject if the Promise is not resolved", function() -- Line 1525
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any__unwrap_result1_6, any__unwrap_result2_7 = Parent_upvr.new(function() -- Line 1526
			end):now():_unwrap()
			expect(any__unwrap_result1_6).to.equal(false)
			expect(Parent_upvr.Error.isKind(any__unwrap_result2_7, "NotResolvedInTime")).to.equal(true)
		end)
		it("should reject with a custom rejection value", function() -- Line 1532
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any__unwrap_result1_5, any__unwrap_result2_4 = Parent_upvr.new(function() -- Line 1533
			end):now("foo"):_unwrap()
			expect(any__unwrap_result1_5).to.equal(false)
			expect(any__unwrap_result2_4).to.equal("foo")
		end)
	end)
	describe("Promise.each", function() -- Line 1540
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should iterate", function() -- Line 1541
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any__unwrap_result1_2, any__unwrap_result2 = Parent_upvr.each({"foo", "bar", "baz", "qux"}, function(...) -- Line 1547
				return {...}
			end):_unwrap()
			expect(any__unwrap_result1_2).to.equal(true)
			expect(any__unwrap_result2[1][1]).to.equal("foo")
			expect(any__unwrap_result2[1][2]).to.equal(1)
			expect(any__unwrap_result2[2][1]).to.equal("bar")
			expect(any__unwrap_result2[2][2]).to.equal(2)
			expect(any__unwrap_result2[3][1]).to.equal("baz")
			expect(any__unwrap_result2[3][2]).to.equal(3)
			expect(any__unwrap_result2[4][1]).to.equal("qux")
			expect(any__unwrap_result2[4][2]).to.equal(4)
		end)
		it("should iterate serially", function() -- Line 1562
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_13_upvr = {}
			local tbl_5_upvr = {}
			local any_each_result1_5 = Parent_upvr.each({"foo", "bar", "baz"}, function(arg1, arg2) -- Line 1570
				--[[ Upvalues[3]:
					[1]: tbl_5_upvr (readonly)
					[2]: Parent_upvr (copied, readonly)
					[3]: tbl_13_upvr (readonly)
				]]
				tbl_5_upvr[arg2] = (tbl_5_upvr[arg2] or 0) + 1
				return Parent_upvr.new(function(arg1_2) -- Line 1573
					--[[ Upvalues[2]:
						[1]: tbl_13_upvr (copied, readonly)
						[2]: arg1 (readonly)
					]]
					table.insert(tbl_13_upvr, function() -- Line 1574
						--[[ Upvalues[2]:
							[1]: arg1_2 (readonly)
							[2]: arg1 (copied, readonly)
						]]
						arg1_2(arg1:upper())
					end)
				end)
			end)
			expect(any_each_result1_5:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(#tbl_13_upvr).to.equal(1)
			expect(tbl_5_upvr[1]).to.equal(1)
			expect(tbl_5_upvr[2]).to.never.be.ok()
			table.remove(tbl_13_upvr, 1)()
			expect(any_each_result1_5:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(#tbl_13_upvr).to.equal(1)
			expect(tbl_5_upvr[1]).to.equal(1)
			expect(tbl_5_upvr[2]).to.equal(1)
			expect(tbl_5_upvr[3]).to.never.be.ok()
			table.remove(tbl_13_upvr, 1)()
			expect(any_each_result1_5:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(tbl_5_upvr[1]).to.equal(1)
			expect(tbl_5_upvr[2]).to.equal(1)
			expect(tbl_5_upvr[3]).to.equal(1)
			table.remove(tbl_13_upvr, 1)()
			expect(any_each_result1_5:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(type(any_each_result1_5._values[1])).to.equal("table")
			expect(type(any_each_result1_5._values[2])).to.equal("nil")
			local _1 = any_each_result1_5._values[1]
			expect(_1[1]).to.equal("FOO")
			expect(_1[2]).to.equal("BAR")
			expect(_1[3]).to.equal("BAZ")
		end)
		it("should reject with the value if the predicate promise rejects", function() -- Line 1613
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_each_result1_2 = Parent_upvr.each({1, 2, 3}, function() -- Line 1614
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				return Parent_upvr.reject("foobar")
			end)
			expect(any_each_result1_2:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_each_result1_2._values[1]).to.equal("foobar")
		end)
		it("should allow Promises to be in the list and wait when it gets to them", function() -- Line 1622
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var558_upvw
			local any_each_result1_4 = Parent_upvr.each({Parent_upvr.new(function(arg1) -- Line 1624
				--[[ Upvalues[1]:
					[1]: var558_upvw (read and write)
				]]
				var558_upvw = arg1
			end)}, function(arg1) -- Line 1630
				return arg1 * 2
			end)
			expect(any_each_result1_4:getStatus()).to.equal(Parent_upvr.Status.Started)
			var558_upvw(2)
			expect(any_each_result1_4:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_each_result1_4._values[1][1]).to.equal(4)
		end)
		it("should reject with the value if a Promise from the list rejects", function() -- Line 1642
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var564_upvw = false
			local any_each_result1_6 = Parent_upvr.each({1, 2, Parent_upvr.reject("foobar")}, function(arg1) -- Line 1644
				--[[ Upvalues[1]:
					[1]: var564_upvw (read and write)
				]]
				var564_upvw = true
				return "never"
			end)
			expect(any_each_result1_6:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_each_result1_6._values[1]).to.equal("foobar")
			expect(var564_upvw).to.equal(false)
		end)
		it("should reject immediately if there's a cancelled Promise in the list initially", function() -- Line 1654
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1 = Parent_upvr.new(function() -- Line 1655
			end)
			any_new_result1:cancel()
			local var571_upvw = false
			local any_each_result1_3 = Parent_upvr.each({1, 2, any_new_result1}, function() -- Line 1659
				--[[ Upvalues[1]:
					[1]: var571_upvw (read and write)
				]]
				var571_upvw = true
			end)
			expect(any_each_result1_3:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(var571_upvw).to.equal(false)
			expect(any_each_result1_3._values[1].kind).to.equal(Parent_upvr.Error.Kind.AlreadyCancelled)
		end)
		it("should stop iteration if Promise.each is cancelled", function() -- Line 1668
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_8_upvr = {}
			local any_each_result1 = Parent_upvr.each({"foo", "bar", "baz"}, function(arg1, arg2) -- Line 1675
				--[[ Upvalues[2]:
					[1]: tbl_8_upvr (readonly)
					[2]: Parent_upvr (copied, readonly)
				]]
				tbl_8_upvr[arg2] = (tbl_8_upvr[arg2] or 0) + 1
				return Parent_upvr.new(function() -- Line 1678
				end)
			end)
			expect(any_each_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			expect(tbl_8_upvr[1]).to.equal(1)
			expect(tbl_8_upvr[2]).to.never.be.ok()
			any_each_result1:cancel()
			expect(any_each_result1:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
			expect(tbl_8_upvr[1]).to.equal(1)
			expect(tbl_8_upvr[2]).to.never.be.ok()
		end)
		it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function() -- Line 1692
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var582_upvw
			Parent_upvr.each({"foo", "bar", "baz"}, function(arg1, arg2) -- Line 1699
				--[[ Upvalues[2]:
					[1]: var582_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				var582_upvw = Parent_upvr.new(function() -- Line 1700
				end)
				return var582_upvw
			end):cancel()
			expect(var582_upvw:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
		it("should cancel Promises in the list if Promise.each is cancelled", function() -- Line 1709
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_new_result1_17 = Parent_upvr.new(function() -- Line 1710
			end)
			Parent_upvr.each({any_new_result1_17}, function() -- Line 1712
			end):cancel()
			expect(any_new_result1_17:getStatus()).to.equal(Parent_upvr.Status.Cancelled)
		end)
	end)
	describe("Promise.retry", function() -- Line 1720
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should retry N times", function() -- Line 1721
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local var594_upvw = 0
			local any_retry_result1 = Parent_upvr.retry(function(arg1) -- Line 1724
				--[[ Upvalues[2]:
					[1]: var594_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				expect(arg1).to.equal("foo")
				var594_upvw += 1
				if var594_upvw == 5 then
					return Parent_upvr.resolve("ok")
				end
				return Parent_upvr.reject("fail")
			end, 5, "foo")
			expect(any_retry_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_retry_result1._values[1]).to.equal("ok")
		end)
		it("should reject if threshold is exceeded", function() -- Line 1740
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_retry_result1_2 = Parent_upvr.retry(function() -- Line 1741
				--[[ Upvalues[1]:
					[1]: Parent_upvr (copied, readonly)
				]]
				return Parent_upvr.reject("fail")
			end, 5)
			expect(any_retry_result1_2:getStatus()).to.equal(Parent_upvr.Status.Rejected)
			expect(any_retry_result1_2._values[1]).to.equal("fail")
		end)
	end)
	describe("Promise.retryWithDelay", function() -- Line 1750
		--[[ Upvalues[2]:
			[1]: Parent_upvr (readonly)
			[2]: advanceTime_upvw (read and write)
		]]
		it("should retry after a delay", function() -- Line 1751
			--[[ Upvalues[2]:
				[1]: Parent_upvr (copied, readonly)
				[2]: advanceTime_upvw (copied, read and write)
			]]
			local var601_upvw = 0
			local any_retryWithDelay_result1 = Parent_upvr.retryWithDelay(function(arg1) -- Line 1754
				--[[ Upvalues[2]:
					[1]: var601_upvw (read and write)
					[2]: Parent_upvr (copied, readonly)
				]]
				expect(arg1).to.equal("foo")
				var601_upvw += 1
				if var601_upvw == 3 then
					return Parent_upvr.resolve("ok")
				end
				return Parent_upvr.reject("fail")
			end, 3, 10, "foo")
			expect(var601_upvw).to.equal(1)
			advanceTime_upvw(11)
			expect(var601_upvw).to.equal(2)
			advanceTime_upvw(11)
			expect(var601_upvw).to.equal(3)
			expect(any_retryWithDelay_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_retryWithDelay_result1._values[1]).to.equal("ok")
		end)
	end)
	describe("Promise.fromEvent", function() -- Line 1781
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should convert a Promise into an event", function() -- Line 1782
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent = Instance.new("BindableEvent")
			local any_fromEvent_result1 = Parent_upvr.fromEvent(BindableEvent.Event)
			expect(any_fromEvent_result1:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent:Fire("foo")
			expect(any_fromEvent_result1:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_fromEvent_result1._values[1]).to.equal("foo")
		end)
		it("should convert a Promise into an event with the predicate", function() -- Line 1795
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local BindableEvent_3 = Instance.new("BindableEvent")
			local any_fromEvent_result1_2 = Parent_upvr.fromEvent(BindableEvent_3.Event, function(arg1) -- Line 1798
				if arg1 ~= "foo" then
				else
				end
				return true
			end)
			expect(any_fromEvent_result1_2:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_3:Fire("bar")
			expect(any_fromEvent_result1_2:getStatus()).to.equal(Parent_upvr.Status.Started)
			BindableEvent_3:Fire("foo")
			expect(any_fromEvent_result1_2:getStatus()).to.equal(Parent_upvr.Status.Resolved)
			expect(any_fromEvent_result1_2._values[1]).to.equal("foo")
		end)
	end)
	describe("Promise.is", function() -- Line 1815
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should work with current version", function() -- Line 1816
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.is(Parent_upvr.resolve(1))).to.equal(true)
		end)
		it("should work with any object with an andThen", function() -- Line 1822
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_7 = {}
			local function andThen() -- Line 1824
				return 1
			end
			tbl_7.andThen = andThen
			expect(Parent_upvr.is(tbl_7)).to.equal(true)
		end)
		it("should work with older promises", function() -- Line 1832
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_9 = {
				prototype = {};
				__index = tbl_9.prototype;
			}
			tbl_9.prototype.andThen = function(arg1) -- Line 1837, Named "andThen"
			end
			expect(Parent_upvr.is(setmetatable({}, tbl_9))).to.equal(true)
		end)
	end)
end