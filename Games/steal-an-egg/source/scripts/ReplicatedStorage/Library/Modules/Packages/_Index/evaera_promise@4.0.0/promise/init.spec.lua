-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	v1.TEST = true

	local v2 = Instance.new("BindableEvent")

	v1._timeEvent = v2.Event

	local v3 = 0

	function v1._getTime() --[[ Line: 12 | Upvalues: v3 (ref) ]]
		return v3
	end

	local function advanceTime(p1) --[[ advanceTime | Line: 16 | Upvalues: v3 (ref), v2 (copy) ]]
		local v1 = p1 or 1 / 60

		v3 = v3 + v1
		v2:Fire(v1)
	end

	local function pack(...) --[[ pack | Line: 24 ]]
		return select("#", ...), { ... }
	end

	describe("Promise.Status", function() --[[ Line: 30 | Upvalues: v1 (copy) ]]
		it("should error if indexing nil value", function() --[[ Line: 31 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 32 | Upvalues: v1 (ref) ]]
				local wrong = v1.Status.wrong
			end).to.throw()
		end)
	end)
	describe("Unhandled rejection signal", function() --[[ Line: 38 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should call unhandled rejection callbacks", function() --[[ Line: 39 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = v1.new(function(p1, p2) --[[ Line: 40 ]]
				p2(1, 2)
			end)
			local v2 = 0

			local function callback(p1, p2, p3) --[[ callback | Line: 46 | Upvalues: v2 (ref), v12 (copy) ]]
				v2 = v2 + 1
				expect(p1).to.equal(v12)
				expect(p2).to.equal(1)
				expect(p3).to.equal(2)
			end

			local v3 = v1.onUnhandledRejection(callback)

			advanceTime()
			expect(v2).to.equal(1)
			v3()
			v1.new(function(p1, p2) --[[ Line: 62 ]]
				p2(3, 4)
			end)
			advanceTime()
			expect(v2).to.equal(1)
		end)
	end)
	describe("Promise.new", function() --[[ Line: 72 | Upvalues: v1 (copy) ]]
		it("should instantiate with a callback", function() --[[ Line: 73 | Upvalues: v1 (ref) ]]
			expect((v1.new(function() --[[ Line: 74 ]] end))).to.be.ok()
		end)
		it("should invoke the given callback with resolve and reject", function() --[[ Line: 79 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = nil
			local v3 = nil
			local v4 = v1.new(function(p1, p2) --[[ Line: 84 | Upvalues: v12 (ref), v2 (ref), v3 (ref) ]]
				v12 = v12 + 1
				v2 = p1
				v3 = p2
			end)

			expect(v4).to.be.ok()
			expect(v12).to.equal(1)
			expect(v2).to.be.a("function")
			expect(v3).to.be.a("function")
			expect(v4:getStatus()).to.equal(v1.Status.Started)
		end)
		it("should resolve promises on resolve()", function() --[[ Line: 98 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.new(function(p1) --[[ Line: 101 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
				p1()
			end)

			expect(v2).to.be.ok()
			expect(v12).to.equal(1)
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
		end)
		it("should reject promises on reject()", function() --[[ Line: 111 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.new(function(p1, p2) --[[ Line: 114 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
				p2()
			end)

			expect(v2).to.be.ok()
			expect(v12).to.equal(1)
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)
		end)
		it("should reject on error in callback", function() --[[ Line: 124 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.new(function() --[[ Line: 127 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
				error("hahah")
			end)

			expect(v2).to.be.ok()
			expect(v12).to.equal(1)
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local v3 = expect

			v3(tostring(v2._values[1]):find("hahah")).to.be.ok()

			local v5 = expect

			v5(tostring(v2._values[1]):find("init.spec")).to.be.ok()

			local v7 = expect

			v7(tostring(v2._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should work with C functions", function() --[[ Line: 142 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 143 | Upvalues: v1 (ref) ]]
				v1.new(tick):andThen(tick)
			end).to.never.throw()
		end)
		it("should have a nice tostring", function() --[[ Line: 148 | Upvalues: v1 (ref) ]]
			local v12 = expect

			v12(tostring(v1.resolve()):gmatch("Promise(Resolved)")).to.be.ok()
		end)
		it("should allow yielding", function() --[[ Line: 152 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.new(function(p1) --[[ Line: 154 | Upvalues: v12 (copy) ]]
				v12.Event:Wait()
				p1(5)
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire()
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal(5)
		end)
		it("should preserve stack traces of resolve-chained promises", function() --[[ Line: 165 | Upvalues: v1 (ref) ]]
			local function nestedCall(p1) --[[ nestedCall | Line: 166 ]]
				error(p1)
			end

			local v12 = v1.new(function(p1) --[[ Line: 170 | Upvalues: v1 (ref) ]]
				p1(v1.new(function() --[[ Line: 171 ]]
					error("sample text")
				end))
			end)

			expect(v12:getStatus()).to.equal(v1.Status.Rejected)

			local v3 = tostring(v12._values[1])

			expect(v3:find("sample text")).to.be.ok()
			expect(v3:find("nestedCall")).to.be.ok()
			expect(v3:find("runExecutor")).to.be.ok()
			expect(v3:find("runPlanNode")).to.be.ok()
			expect(v3:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
		end)
		it("should report errors from Promises with _error (< v2)", function() --[[ Line: 188 | Upvalues: v1 (ref) ]]
			local v12 = v1.reject()

			v12._error = "Sample error"

			local v2 = v1.resolve():andThenReturn(v12)

			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local v4 = tostring(v2._values[1])

			expect(v4:find("Sample error")).to.be.ok()
			expect(v4:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
			expect(v4:find("%[No stack trace available")).to.be.ok()
		end)
		it("should allow callable tables", function() --[[ Line: 204 | Upvalues: v1 (ref) ]]
			local v2 = v1.new((setmetatable({}, {
				__call = function(p1, p2) --[[ __call | Line: 206 ]]
					p2(1)
				end
			})))
			local v3 = false
			local t2 = {
				__call = function(p1, p2) --[[ __call | Line: 213 | Upvalues: v3 (ref) ]]
					expect(p2).to.equal(1)
					v3 = true
				end
			}

			v2:andThen((setmetatable({}, t2)))
			expect(v3).to.equal(true)
		end)
		itSKIP("should close the thread after resolve", function() --[[ Line: 222 | Upvalues: v1 (ref) ]]
			local v12 = 0

			v1.new(function(p1) --[[ Line: 224 | Upvalues: v12 (ref), v1 (ref) ]]
				v12 = v12 + 1
				p1()
				v1.delay(1):await()
				v12 = v12 + 1
			end)
			task.wait(1)
			expect(v12).to.equal(1)
		end)
	end)
	describe("Promise.defer", function() --[[ Line: 237 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should execute after the time event", function() --[[ Line: 238 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = 0
			local v2 = v1.defer(function(p1, p2, p3, p4) --[[ Line: 240 | Upvalues: v12 (ref) ]]
				expect((type(p1))).to.equal("function")
				expect((type(p2))).to.equal("function")
				expect((type(p3))).to.equal("function")
				expect((type(p4))).to.equal("nil")
				v12 = v12 + 1
				p1("foo")
			end)

			expect(v12).to.equal(0)
			expect(v2:getStatus()).to.equal(v1.Status.Started)
			advanceTime()
			expect(v12).to.equal(1)
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			advanceTime()
			expect(v12).to.equal(1)
		end)
	end)
	describe("Promise.delay", function() --[[ Line: 263 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should schedule promise resolution", function() --[[ Line: 264 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = v1.delay(1)

			expect(v12:getStatus()).to.equal(v1.Status.Started)
			advanceTime()
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			advanceTime(1)
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
		end)
		it("should allow for delays to be cancelled", function() --[[ Line: 276 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = v1.delay(2)

			v1.delay(1):andThen(function() --[[ Line: 279 | Upvalues: v12 (copy) ]]
				v12:cancel()
			end)
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			advanceTime()
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			advanceTime(1)
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
			advanceTime(1)
		end)
	end)
	describe("Promise.resolve", function() --[[ Line: 292 | Upvalues: v1 (copy) ]]
		it("should immediately resolve with a value", function() --[[ Line: 293 | Upvalues: v1 (ref) ]]
			local v12 = v1.resolve(5, 6)

			expect(v12).to.be.ok()
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v12._values[1]).to.equal(5)
			expect(v12._values[2]).to.equal(6)
		end)
		it("should chain onto passed promises", function() --[[ Line: 302 | Upvalues: v1 (ref) ]]
			local v12 = v1.resolve(v1.new(function(p1, p2) --[[ Line: 303 ]]
				p2(7)
			end))

			expect(v12).to.be.ok()
			expect(v12:getStatus()).to.equal(v1.Status.Rejected)
			expect(v12._values[1]).to.equal(7)
		end)
	end)
	describe("Promise.reject", function() --[[ Line: 313 | Upvalues: v1 (copy) ]]
		it("should immediately reject with a value", function() --[[ Line: 314 | Upvalues: v1 (ref) ]]
			local v12 = v1.reject(6, 7)

			expect(v12).to.be.ok()
			expect(v12:getStatus()).to.equal(v1.Status.Rejected)
			expect(v12._values[1]).to.equal(6)
			expect(v12._values[2]).to.equal(7)
		end)
		it("should pass a promise as-is as an error", function() --[[ Line: 323 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function(p1) --[[ Line: 324 ]]
				p1(6)
			end)
			local v2 = v1.reject(v12)

			expect(v2).to.be.ok()
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)
			expect(v2._values[1]).to.equal(v12)
		end)
	end)
	describe("Promise:andThen", function() --[[ Line: 336 | Upvalues: v1 (copy), pack (copy) ]]
		it("should allow yielding", function() --[[ Line: 337 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.resolve():andThen(function() --[[ Line: 339 | Upvalues: v12 (copy) ]]
				v12.Event:Wait()

				return 5
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire()
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal(5)
		end)
		it("should run andThens on a new thread", function() --[[ Line: 350 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = nil
			local v3 = v1.new(function(p1) --[[ Line: 354 | Upvalues: v2 (ref) ]]
				v2 = p1
			end)
			local v4 = v3:andThen(function() --[[ Line: 358 | Upvalues: v12 (copy) ]]
				v12.Event:Wait()

				return 5
			end)
			local v5 = v3:andThen(function() --[[ Line: 363 ]]
				return "foo"
			end)

			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v2()
			expect(v5:getStatus()).to.equal(v1.Status.Resolved)
			expect(v5._values[1]).to.equal("foo")
			expect(v4:getStatus()).to.equal(v1.Status.Started)
		end)
		it("should chain onto resolved promises", function() --[[ Line: 374 | Upvalues: v1 (ref), pack (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = 0
			local v4 = 0
			local v5 = v1.resolve(5)
			local v6 = v5:andThen(function(...) --[[ Line: 382 | Upvalues: v2 (ref), v12 (ref), pack (ref), v3 (ref) ]]
				local v1, v22 = pack(...)

				v2 = v1
				v12 = v22
				v3 = v3 + 1
			end, function() --[[ Line: 385 | Upvalues: v4 (ref) ]]
				v4 = v4 + 1
			end)

			expect(v4).to.equal(0)
			expect(v3).to.equal(1)
			expect(v2).to.equal(1)
			expect(v12[1]).to.equal(5)
			expect(v5).to.be.ok()
			expect(v5:getStatus()).to.equal(v1.Status.Resolved)
			expect(v5._values[1]).to.equal(5)
			expect(v6).to.be.ok()
			expect(v6).never.to.equal(v5)
			expect(v6:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v6._values).to.equal(0)
		end)
		it("should chain onto rejected promises", function() --[[ Line: 405 | Upvalues: v1 (ref), pack (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = 0
			local v4 = 0
			local v5 = v1.reject(5)
			local v6 = v5:andThen(function(...) --[[ Line: 413 | Upvalues: v4 (ref) ]]
				v4 = v4 + 1
			end, function(...) --[[ Line: 415 | Upvalues: v2 (ref), v12 (ref), pack (ref), v3 (ref) ]]
				local v1, v22 = pack(...)

				v2 = v1
				v12 = v22
				v3 = v3 + 1
			end)

			expect(v4).to.equal(0)
			expect(v3).to.equal(1)
			expect(v2).to.equal(1)
			expect(v12[1]).to.equal(5)
			expect(v5).to.be.ok()
			expect(v5:getStatus()).to.equal(v1.Status.Rejected)
			expect(v5._values[1]).to.equal(5)
			expect(v6).to.be.ok()
			expect(v6).never.to.equal(v5)
			expect(v6:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v6._values).to.equal(0)
		end)
		it("should reject on error in callback", function() --[[ Line: 436 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.resolve(1):andThen(function() --[[ Line: 439 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
				error("hahah")
			end)

			expect(v2).to.be.ok()
			expect(v12).to.equal(1)
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local v3 = expect

			v3(tostring(v2._values[1]):find("hahah")).to.be.ok()

			local v5 = expect

			v5(tostring(v2._values[1]):find("init.spec")).to.be.ok()

			local v7 = expect

			v7(tostring(v2._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should chain onto asynchronously resolved promises", function() --[[ Line: 454 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = 0
			local v4 = 0
			local v5 = nil
			local v6 = v1.new(function(p1) --[[ Line: 461 | Upvalues: v5 (ref) ]]
				v5 = p1
			end)
			local v7 = v6:andThen(function(...) --[[ Line: 465 | Upvalues: v12 (ref), v2 (ref), v3 (ref) ]]
				v12 = { ... }
				v2 = select("#", ...)
				v3 = v3 + 1
			end, function() --[[ Line: 469 | Upvalues: v4 (ref) ]]
				v4 = v4 + 1
			end)

			expect(v3).to.equal(0)
			expect(v4).to.equal(0)
			v5(6)
			expect(v4).to.equal(0)
			expect(v3).to.equal(1)
			expect(v2).to.equal(1)
			expect(v12[1]).to.equal(6)
			expect(v6).to.be.ok()
			expect(v6:getStatus()).to.equal(v1.Status.Resolved)
			expect(v6._values[1]).to.equal(6)
			expect(v7).to.be.ok()
			expect(v7).never.to.equal(v6)
			expect(v7:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v7._values).to.equal(0)
		end)
		it("should chain onto asynchronously rejected promises", function() --[[ Line: 494 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = 0
			local v4 = 0
			local v5 = nil
			local v6 = v1.new(function(p1, p2) --[[ Line: 501 | Upvalues: v5 (ref) ]]
				v5 = p2
			end)
			local v7 = v6:andThen(function() --[[ Line: 505 | Upvalues: v4 (ref) ]]
				v4 = v4 + 1
			end, function(...) --[[ Line: 507 | Upvalues: v12 (ref), v2 (ref), v3 (ref) ]]
				v12 = { ... }
				v2 = select("#", ...)
				v3 = v3 + 1
			end)

			expect(v3).to.equal(0)
			expect(v4).to.equal(0)
			v5(6)
			expect(v4).to.equal(0)
			expect(v3).to.equal(1)
			expect(v2).to.equal(1)
			expect(v12[1]).to.equal(6)
			expect(v6).to.be.ok()
			expect(v6:getStatus()).to.equal(v1.Status.Rejected)
			expect(v6._values[1]).to.equal(6)
			expect(v7).to.be.ok()
			expect(v7).never.to.equal(v6)
			expect(v7:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v7._values).to.equal(0)
		end)
		it("should propagate errors through multiple levels", function() --[[ Line: 534 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = nil

			v1.new(function(p1, p2) --[[ Line: 536 ]]
				p2(1, 2, 3)
			end):andThen(function() --[[ Line: 539 ]] end):catch(function(p1, p2, p3) --[[ Line: 540 | Upvalues: v12 (ref), v2 (ref), v3 (ref) ]]
				v12 = p1
				v2 = p2
				v3 = p3
			end)
			expect(v12).to.equal(1)
			expect(v2).to.equal(2)
			expect(v3).to.equal(3)
		end)
		it("should not call queued callbacks from a cancelled sub-promise", function() --[[ Line: 549 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = 0
			local v3 = v1.new(function(p1) --[[ Line: 553 | Upvalues: v12 (ref) ]]
				v12 = p1
			end)

			v3:andThen(function() --[[ Line: 557 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end)
			v3:andThen(function() --[[ Line: 561 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end):cancel()
			v12("foo")
			expect(v2).to.equal(1)
		end)
	end)
	describe("Promise:cancel", function() --[[ Line: 571 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should mark promises as cancelled and not resolve or reject them", function() --[[ Line: 572 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = 0
			local v3 = v1.new(function() --[[ Line: 575 ]] end):andThen(function() --[[ Line: 576 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
			end):finally(function() --[[ Line: 579 | Upvalues: v2 (ref) ]]
				v2 = v2 + 1
			end)

			v3:cancel()
			v3:cancel()
			expect(v12).to.equal(0)
			expect(v2).to.equal(1)
			expect(v3:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should call the cancellation hook once", function() --[[ Line: 591 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.new(function(p1, p2, p3) --[[ Line: 594 | Upvalues: v12 (ref) ]]
				p3(function() --[[ Line: 595 | Upvalues: v12 (ref) ]]
					v12 = v12 + 1
				end)
			end)

			v2:cancel()
			v2:cancel()
			expect(v12).to.equal(1)
		end)
		it("should propagate cancellations", function() --[[ Line: 606 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 607 ]] end)
			local v2 = v12:andThen()
			local v3 = v12:andThen()

			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(v2:getStatus()).to.equal(v1.Status.Started)
			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v2:cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v3:cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v3:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should affect downstream promises", function() --[[ Line: 629 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 630 ]] end)
			local v2 = v12:andThen()

			v12:cancel()
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should track consumers", function() --[[ Line: 638 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 639 ]] end)
			local v2 = v1.resolve()
			local v3 = v2:andThen(function() --[[ Line: 641 | Upvalues: v12 (copy) ]]
				return v12
			end)
			local v4 = v1.new(function(p1) --[[ Line: 644 | Upvalues: v3 (copy) ]]
				p1(v3)
			end)
			local v5 = v4:andThen(function() --[[ Line: 647 ]] end)

			expect(v3._parent).to.never.equal(v2)
			expect(v4._parent).to.never.equal(v3)
			expect(v4._consumers[v5]).to.be.ok()
			expect(v5._parent).to.equal(v4)
		end)
		it("should cancel resolved pending promises", function() --[[ Line: 655 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 656 ]] end)
			local v2 = v1.new(function(p1) --[[ Line: 658 | Upvalues: v12 (copy) ]]
				p1(v12)
			end):finally(function() --[[ Line: 660 ]] end)

			v2:cancel()
			expect(v12._status).to.equal(v1.Status.Cancelled)
			expect(v2._status).to.equal(v1.Status.Cancelled)
		end)
		it("should close the promise thread", function() --[[ Line: 668 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = 0

			v1.new(function() --[[ Line: 670 | Upvalues: v12 (ref), v1 (ref) ]]
				v12 = v12 + 1
				v1.delay(1):await()
				v12 = v12 + 1
			end):cancel()
			advanceTime(2)
			expect(v12).to.equal(1)
		end)
	end)
	describe("Promise:finally", function() --[[ Line: 683 | Upvalues: v1 (copy) ]]
		it("should be called upon resolve, reject, or cancel", function() --[[ Line: 684 | Upvalues: v1 (ref) ]]
			local v12 = 0

			local function finally() --[[ finally | Line: 687 | Upvalues: v12 (ref) ]]
				v12 = v12 + 1
			end

			v1.new(function(p1, p2) --[[ Line: 692 ]]
				p1()
			end):finally(finally)
			v1.resolve():andThen(function() --[[ Line: 697 ]] end):finally(finally):finally(finally)
			v1.reject():finally(finally)
			v1.new(function() --[[ Line: 702 ]] end):finally(finally):cancel()
			expect(v12).to.equal(5)
		end)
		it("should not forward return values", function() --[[ Line: 708 | Upvalues: v1 (ref) ]]
			local v12 = nil

			v1.resolve(2):finally(function() --[[ Line: 712 ]]
				return 1
			end):andThen(function(p1) --[[ Line: 715 | Upvalues: v12 (ref) ]]
				v12 = p1
			end)
			expect(v12).to.equal(2)
		end)
		it("should not consume rejections", function() --[[ Line: 722 | Upvalues: v1 (ref) ]]
			local v12 = false
			local v2 = false

			v1.reject(5):finally(function() --[[ Line: 726 ]]
				return 42
			end):andThen(function() --[[ Line: 729 | Upvalues: v2 (ref) ]]
				v2 = true
			end):catch(function(p1) --[[ Line: 732 | Upvalues: v12 (ref) ]]
				v12 = true
				expect(p1).to.equal(5)
			end)
			expect(v12).to.equal(true)
			expect(v2).to.equal(false)
		end)
		it("should wait for returned promises", function() --[[ Line: 741 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.reject("foo"):finally(function() --[[ Line: 743 | Upvalues: v1 (ref), v12 (ref) ]]
				return v1.new(function(p1) --[[ Line: 744 | Upvalues: v12 (ref) ]]
					v12 = p1
				end)
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12()
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local _, v3 = v2:_unwrap()

			expect(v3).to.equal("foo")
		end)
		it("should reject with a returned rejected promise\'s value", function() --[[ Line: 758 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.reject("foo"):finally(function() --[[ Line: 760 | Upvalues: v1 (ref), v12 (ref) ]]
				return v1.new(function(p1, p2) --[[ Line: 761 | Upvalues: v12 (ref) ]]
					v12 = p2
				end)
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12("bar")
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local _, v3 = v2:_unwrap()

			expect(v3).to.equal("bar")
		end)
		it("should reject when handler errors", function() --[[ Line: 775 | Upvalues: v1 (ref) ]]
			local t = {}
			local v12, v2 = v1.reject("bar"):finally(function() --[[ Line: 777 | Upvalues: t (copy) ]]
				error(t)
			end):_unwrap()

			expect(v12).to.equal(false)
			expect(v2).to.equal(t)
		end)
		it("should not prevent cancellation", function() --[[ Line: 787 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 788 ]] end)
			local v2 = false

			v12:finally(function() --[[ Line: 791 | Upvalues: v2 (ref) ]]
				v2 = true
			end)
			v12:andThen(function() --[[ Line: 795 ]] end):cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v2).to.equal(true)
		end)
		it("should propagate cancellation downwards", function() --[[ Line: 803 | Upvalues: v1 (ref) ]]
			local v12 = false
			local v2 = v1.new(function() --[[ Line: 806 ]] end)
			local v3 = v2:finally(function() --[[ Line: 808 | Upvalues: v12 (ref) ]]
				v12 = true
			end)

			v2:cancel()
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v3:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v12).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should propagate cancellation upwards", function() --[[ Line: 821 | Upvalues: v1 (ref) ]]
			local v12 = false
			local v2 = v1.new(function() --[[ Line: 824 ]] end)
			local v3 = v2:finally(function() --[[ Line: 826 | Upvalues: v12 (ref) ]]
				v12 = true
			end)

			v3:cancel()
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v3:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v12).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should cancel returned promise if cancelled", function() --[[ Line: 839 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 840 ]] end)

			v1.resolve():finally(function() --[[ Line: 842 | Upvalues: v12 (copy) ]]
				return v12
			end):cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
		end)
	end)
	describe("Promise.all", function() --[[ Line: 852 | Upvalues: v1 (copy), pack (copy) ]]
		it("should error if given something other than a table", function() --[[ Line: 853 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 854 | Upvalues: v1 (ref) ]]
				v1.all(1)
			end).to.throw()
		end)
		it("should resolve instantly with an empty table if given no promises", function() --[[ Line: 859 | Upvalues: v1 (ref) ]]
			local v12 = v1.all({})
			local v2, v3 = v12:_unwrap()

			expect(v2).to.equal(true)
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v3).to.be.a("table")
			expect(next(v3)).to.equal(nil)
		end)
		it("should error if given non-promise values", function() --[[ Line: 869 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 870 | Upvalues: v1 (ref) ]]
				v1.all({
					{},
					{},
					{}
				})
			end).to.throw()
		end)
		it("should wait for all promises to be resolved and return their values", function() --[[ Line: 875 | Upvalues: pack (ref), v1 (ref) ]]
			local v12, v2 = pack(1, "A string", nil, false)
			local list = {}
			local t = {}

			for i = 1, v12 do
				t[i] = v1.new(function(p1) --[[ Line: 883 | Upvalues: list (copy), i (copy), v2 (copy) ]]
					list[i] = { p1, v2[i] }
				end)
			end

			local v3 = v1.all(t)

			for i, v in ipairs(list) do
				expect(v3:getStatus()).to.equal(v1.Status.Started)
				v[1](v[2])
			end

			local v4, v5 = pack(v3:_unwrap())
			local v6, v7 = unpack(v5, 1, v4)

			expect(v4).to.equal(2)
			expect(v6).to.equal(true)
			expect(v7).to.be.a("table")
			expect(#v7).to.equal(#t)

			for j = 1, v12 do
				expect(v7[j]).to.equal(v2[j])
			end
		end)
		it("should reject if any individual promise rejected", function() --[[ Line: 908 | Upvalues: v1 (ref), pack (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = v1.new(function(p1, p2) --[[ Line: 912 | Upvalues: v12 (ref) ]]
				v12 = p2
			end)
			local v4 = v1.new(function(p1) --[[ Line: 916 | Upvalues: v2 (ref) ]]
				v2 = p1
			end)
			local v5 = v1.all({ v3, v4 })

			expect(v5:getStatus()).to.equal(v1.Status.Started)
			v12("baz", "qux")
			v2("foo", "bar")

			local v6, v7 = pack(v5:_unwrap())
			local v8, v9, v10 = unpack(v7, 1, v6)

			expect(v6).to.equal(3)
			expect(v8).to.equal(false)
			expect(v9).to.equal("baz")
			expect(v10).to.equal("qux")
			expect(v4:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should not resolve if resolved after rejecting", function() --[[ Line: 937 | Upvalues: v1 (ref), pack (ref) ]]
			local v12 = nil
			local v2 = nil
			local t = { v1.new(function(p1, p2) --[[ Line: 941 | Upvalues: v12 (ref) ]]
					v12 = p2
				end), (v1.new(function(p1) --[[ Line: 945 | Upvalues: v2 (ref) ]]
					v2 = p1
				end)) }
			local v3 = v1.all(t)

			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v12("baz", "qux")
			v2("foo", "bar")

			local v4, v5 = pack(v3:_unwrap())
			local v6, v7, v8 = unpack(v5, 1, v4)

			expect(v4).to.equal(3)
			expect(v6).to.equal(false)
			expect(v7).to.equal("baz")
			expect(v8).to.equal("qux")
		end)
		it("should only reject once", function() --[[ Line: 965 | Upvalues: v1 (ref), pack (ref) ]]
			local v12 = nil
			local v2 = nil
			local t = { v1.new(function(p1, p2) --[[ Line: 969 | Upvalues: v12 (ref) ]]
					v12 = p2
				end), (v1.new(function(p1, p2) --[[ Line: 973 | Upvalues: v2 (ref) ]]
					v2 = p2
				end)) }
			local v3 = v1.all(t)

			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v12("foo", "bar")
			expect(v3:getStatus()).to.equal(v1.Status.Rejected)
			v2("baz", "qux")

			local v4, v5 = pack(v3:_unwrap())
			local v6, v7, v8 = unpack(v5, 1, v4)

			expect(v4).to.equal(3)
			expect(v6).to.equal(false)
			expect(v7).to.equal("foo")
			expect(v8).to.equal("bar")
		end)
		it("should error if a non-array table is passed in", function() --[[ Line: 996 | Upvalues: v1 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 997 | Upvalues: v1 (ref) ]]
				v1.all(v1.new(function() --[[ Line: 998 ]] end))
			end)

			expect(ok).to.be.ok()
			expect(result:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel pending promises if one rejects", function() --[[ Line: 1005 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1006 ]] end)

			expect(v1.all({ v1.resolve(), v1.reject(), v12 }):getStatus()).to.equal(v1.Status.Rejected)
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should cancel promises if it is cancelled", function() --[[ Line: 1015 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1016 ]] end)

			v12:andThen(function() --[[ Line: 1017 ]] end)

			local t = { v1.new(function() --[[ Line: 1020 ]] end), v1.new(function() --[[ Line: 1021 ]] end), v12 }

			v1.all(t):cancel()
			expect(t[1]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[2]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[3]:getStatus()).to.equal(v1.Status.Started)
		end)
	end)
	describe("Promise.fold", function() --[[ Line: 1033 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should return the initial value in a promise when the list is empty", function() --[[ Line: 1034 | Upvalues: v1 (ref) ]]
			local t = {}
			local v12 = v1.fold({}, function() --[[ Line: 1036 ]]
				error("should not be called")
			end, t)

			expect(v1.is(v12)).to.equal(true)
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v12:expect()).to.equal(t)
		end)
		it("should accept promises in the list", function() --[[ Line: 1045 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.fold({ v1.new(function(p1) --[[ Line: 1048 | Upvalues: v12 (ref) ]]
					v12 = p1
				end), 2, 3 }, function(p1, p2) --[[ Line: 1050 ]]
				return p1 + p2
			end, 0)

			v12(1)
			expect(v1.is(v2)).to.equal(true)
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2:expect()).to.equal(6)
		end)
		it("should always return a promise even if the list or reducer don\'t use them", function() --[[ Line: 1061 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = v1.fold({ 1, 2, 3 }, function(p1, p2, p3) --[[ Line: 1062 | Upvalues: v1 (ref) ]]
				if p3 == 2 then
					return v1.delay(1):andThenReturn(p1 + p2)
				end

				return p1 + p2
			end, 0)

			expect(v1.is(v12)).to.equal(true)
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			advanceTime(2)
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v12:expect()).to.equal(6)
		end)
		it("should return the first rejected promise", function() --[[ Line: 1076 | Upvalues: v1 (ref) ]]
			local v12 = v1.fold({ 1, 2, 3 }, function(p1, p2, p3) --[[ Line: 1078 | Upvalues: v1 (ref) ]]
				if p3 == 2 then
					return v1.reject("foo")
				end

				return p1 + p2
			end, 0)

			expect(v1.is(v12)).to.equal(true)

			local v2, v3 = v12:awaitStatus()

			expect(v2).to.equal(v1.Status.Rejected)
			expect(v3).to.equal("foo")
		end)
		it("should return the first canceled promise", function() --[[ Line: 1091 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.fold({ 1, 2, 3 }, function(p1, p2, p3) --[[ Line: 1093 | Upvalues: v12 (ref), v1 (ref) ]]
				if p3 == 1 then
					return p1 + p2
				end

				if p3 == 2 then
					v12 = v1.delay(1):andThenReturn(p1 + p2)

					return v12
				end

				error("this should not run if the promise is cancelled")
			end, 0)

			expect(v1.is(v2)).to.equal(true)
			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:cancel()
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
		end)
	end)
	describe("Promise.race", function() --[[ Line: 1110 | Upvalues: v1 (copy) ]]
		it("should resolve with the first settled value", function() --[[ Line: 1111 | Upvalues: v1 (ref) ]]
			expect(v1.race({ v1.resolve(1), v1.resolve(2) }):andThen(function(p1) --[[ Line: 1115 ]]
				expect(p1).to.equal(1)
			end):getStatus()).to.equal(v1.Status.Resolved)
		end)
		it("should cancel other promises", function() --[[ Line: 1122 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1123 ]] end)

			v12:andThen(function() --[[ Line: 1124 ]] end)

			local t = { v12, v1.new(function() --[[ Line: 1127 ]] end), v1.new(function(p1) --[[ Line: 1128 ]]
					p1(2)
				end) }
			local v2 = v1.race(t)

			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal(2)
			expect(t[1]:getStatus()).to.equal(v1.Status.Started)
			expect(t[2]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[3]:getStatus()).to.equal(v1.Status.Resolved)

			local v3 = v1.new(function() --[[ Line: 1141 ]] end)

			expect(v1.race({ v1.reject(), v1.resolve(), v3 }):getStatus()).to.equal(v1.Status.Rejected)
			expect(v3:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should error if a non-array table is passed in", function() --[[ Line: 1150 | Upvalues: v1 (ref) ]]
			local ok, result = pcall(function() --[[ Line: 1151 | Upvalues: v1 (ref) ]]
				v1.race(v1.new(function() --[[ Line: 1152 ]] end))
			end)

			expect(ok).to.be.ok()
			expect(result:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel promises if it is cancelled", function() --[[ Line: 1159 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1160 ]] end)

			v12:andThen(function() --[[ Line: 1161 ]] end)

			local t = { v1.new(function() --[[ Line: 1164 ]] end), v1.new(function() --[[ Line: 1165 ]] end), v12 }

			v1.race(t):cancel()
			expect(t[1]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[2]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[3]:getStatus()).to.equal(v1.Status.Started)
		end)
	end)
	describe("Promise.promisify", function() --[[ Line: 1177 | Upvalues: v1 (copy) ]]
		it("should wrap functions", function() --[[ Line: 1178 | Upvalues: v1 (ref) ]]
			local function test(p1) --[[ test | Line: 1179 ]]
				return p1 + 1
			end

			local v12 = v1.promisify(test)(1)
			local v2, v3 = v12:_unwrap()

			expect(v2).to.equal(true)
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v3).to.equal(2)
		end)
		it("should catch errors after a yield", function() --[[ Line: 1192 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.promisify(function() --[[ Line: 1194 | Upvalues: v12 (copy) ]]
				v12.Event:Wait()
				error("errortext")
			end)()

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire()
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local v3 = expect

			v3(tostring(v2._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise.tap", function() --[[ Line: 1208 | Upvalues: v1 (copy) ]]
		it("should thread through values", function() --[[ Line: 1209 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil

			v1.resolve(1):andThen(function(p1) --[[ Line: 1213 ]]
				return p1 + 1
			end):tap(function(p1) --[[ Line: 1216 | Upvalues: v12 (ref) ]]
				v12 = p1

				return p1 + 1
			end):andThen(function(p1) --[[ Line: 1220 | Upvalues: v2 (ref) ]]
				v2 = p1
			end)
			expect(v12).to.equal(2)
			expect(v2).to.equal(2)
		end)
		it("should chain onto promises", function() --[[ Line: 1228 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil
			local v3 = v1.resolve(1):tap(function() --[[ Line: 1232 | Upvalues: v1 (ref), v12 (ref) ]]
				return v1.new(function(p1) --[[ Line: 1233 | Upvalues: v12 (ref) ]]
					v12 = p1
				end)
			end):andThen(function(p1) --[[ Line: 1237 | Upvalues: v2 (ref) ]]
				v2 = p1
			end)

			expect(v3:getStatus()).to.equal(v1.Status.Started)
			expect(v2).to.never.be.ok()
			v12(1)
			expect(v3:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2).to.equal(1)
		end)
	end)
	describe("Promise.try", function() --[[ Line: 1251 | Upvalues: v1 (copy) ]]
		it("should catch synchronous errors", function() --[[ Line: 1252 | Upvalues: v1 (ref) ]]
			local v12 = nil

			v1.try(function() --[[ Line: 1254 ]]
				error("errortext")
			end):catch(function(p1) --[[ Line: 1256 | Upvalues: v12 (ref) ]]
				v12 = tostring(p1)
			end)
			expect(v12:find("errortext")).to.be.ok()
		end)
		it("should reject with error objects", function() --[[ Line: 1263 | Upvalues: v1 (ref) ]]
			local t = {}
			local v12, v2 = v1.try(function() --[[ Line: 1265 | Upvalues: t (copy) ]]
				error(t)
			end):_unwrap()

			expect(v12).to.equal(false)
			expect(v2).to.equal(t)
		end)
		it("should catch asynchronous errors", function() --[[ Line: 1273 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.try(function() --[[ Line: 1275 | Upvalues: v12 (copy) ]]
				v12.Event:Wait()
				error("errortext")
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire()
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)

			local v3 = expect

			v3(tostring(v2._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise:andThenReturn", function() --[[ Line: 1287 | Upvalues: v1 (copy) ]]
		it("should return the given values", function() --[[ Line: 1288 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil

			v1.resolve():andThenReturn(1, 2):andThen(function(p1, p2) --[[ Line: 1291 | Upvalues: v12 (ref), v2 (ref) ]]
				v12 = p1
				v2 = p2
			end)
			expect(v12).to.equal(1)
			expect(v2).to.equal(2)
		end)
	end)
	describe("Promise:andThenCall", function() --[[ Line: 1301 | Upvalues: v1 (copy) ]]
		it("should call the given function with arguments", function() --[[ Line: 1302 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = nil

			v1.resolve():andThenCall(function(p1, p2) --[[ Line: 1304 | Upvalues: v12 (ref), v2 (ref) ]]
				v12 = p1
				v2 = p2
			end, 3, 4)
			expect(v12).to.equal(3)
			expect(v2).to.equal(4)
		end)
	end)
	describe("Promise.some", function() --[[ Line: 1314 | Upvalues: v1 (copy) ]]
		it("should resolve once the goal is reached", function() --[[ Line: 1315 | Upvalues: v1 (ref) ]]
			local v12 = v1.some({ v1.resolve(1), v1.reject(), v1.resolve(2) }, 2)

			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(v12._values[1][1]).to.equal(1)
			expect(v12._values[1][2]).to.equal(2)
		end)
		it("should error if the goal can\'t be reached", function() --[[ Line: 1326 | Upvalues: v1 (ref) ]]
			expect(v1.some({ v1.resolve(), v1.reject() }, 2):getStatus()).to.equal(v1.Status.Rejected)

			local v12 = nil
			local v2 = v1.some({ v1.resolve(), v1.new(function(p1, p2) --[[ Line: 1335 | Upvalues: v12 (ref) ]]
					v12 = p2
				end) }, 2)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12("foo")
			expect(v2:getStatus()).to.equal(v1.Status.Rejected)
			expect(v2._values[1]).to.equal("foo")
		end)
		it("should cancel pending Promises once the goal is reached", function() --[[ Line: 1346 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.new(function() --[[ Line: 1348 ]] end)
			local v3 = v1.new(function(p1) --[[ Line: 1349 | Upvalues: v12 (ref) ]]
				v12 = p1
			end)
			local v4 = v1.some({ v2, v3, v1.resolve() }, 2)

			expect(v4:getStatus()).to.equal(v1.Status.Started)
			expect(v2:getStatus()).to.equal(v1.Status.Started)
			expect(v3:getStatus()).to.equal(v1.Status.Started)
			v12()
			expect(v4:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2:getStatus()).to.equal(v1.Status.Cancelled)
			expect(v3:getStatus()).to.equal(v1.Status.Resolved)
		end)
		it("should error if passed a non-number", function() --[[ Line: 1370 | Upvalues: v1 (ref) ]]
			expect(function() --[[ Line: 1371 | Upvalues: v1 (ref) ]]
				v1.some({}, "non-number")
			end).to.throw()
		end)
		it("should return an empty array if amount is 0", function() --[[ Line: 1376 | Upvalues: v1 (ref) ]]
			local v12 = v1.some({ v1.resolve(2) }, 0)

			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v12._values[1]).to.equal(0)
		end)
		it("should not return extra values", function() --[[ Line: 1385 | Upvalues: v1 (ref) ]]
			local v12 = v1.some({
				v1.resolve(1),
				v1.resolve(2),
				v1.resolve(3),
				v1.resolve(4)
			}, 2)

			expect(v12:getStatus()).to.equal(v1.Status.Resolved)
			expect(#v12._values[1]).to.equal(2)
			expect(v12._values[1][1]).to.equal(1)
			expect(v12._values[1][2]).to.equal(2)
		end)
		it("should cancel promises if it is cancelled", function() --[[ Line: 1399 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1400 ]] end)

			v12:andThen(function() --[[ Line: 1401 ]] end)

			local t = { v1.new(function() --[[ Line: 1404 ]] end), v1.new(function() --[[ Line: 1405 ]] end), v12 }

			v1.some(t, 3):cancel()
			expect(t[1]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[2]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[3]:getStatus()).to.equal(v1.Status.Started)
		end)
		describe("Promise.any", function() --[[ Line: 1416 | Upvalues: v1 (ref) ]]
			it("should return the value directly", function() --[[ Line: 1417 | Upvalues: v1 (ref) ]]
				local v12 = v1.any({ v1.reject(), v1.reject(), v1.resolve(1) })

				expect(v12:getStatus()).to.equal(v1.Status.Resolved)
				expect(v12._values[1]).to.equal(1)
			end)
			it("should error if all are rejected", function() --[[ Line: 1428 | Upvalues: v1 (ref) ]]
				expect(v1.any({ v1.reject(), v1.reject(), v1.reject() }):getStatus()).to.equal(v1.Status.Rejected)
			end)
		end)
	end)
	describe("Promise.allSettled", function() --[[ Line: 1438 | Upvalues: v1 (copy) ]]
		it("should resolve with an array of PromiseStatuses", function() --[[ Line: 1439 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local v2 = v1.allSettled({
				v1.resolve(),
				v1.reject(),
				v1.resolve(),
				v1.new(function(p1, p2) --[[ Line: 1445 | Upvalues: v12 (ref) ]]
					v12 = p2
				end)
			})

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12()
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1][1]).to.equal(v1.Status.Resolved)
			expect(v2._values[1][2]).to.equal(v1.Status.Rejected)
			expect(v2._values[1][3]).to.equal(v1.Status.Resolved)
			expect(v2._values[1][4]).to.equal(v1.Status.Rejected)
		end)
		it("should cancel promises if it is cancelled", function() --[[ Line: 1459 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1460 ]] end)

			v12:andThen(function() --[[ Line: 1461 ]] end)

			local t = { v1.new(function() --[[ Line: 1464 ]] end), v1.new(function() --[[ Line: 1465 ]] end), v12 }

			v1.allSettled(t):cancel()
			expect(t[1]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[2]:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[3]:getStatus()).to.equal(v1.Status.Started)
		end)
	end)
	describe("Promise:await", function() --[[ Line: 1477 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should return the correct values", function() --[[ Line: 1478 | Upvalues: v1 (ref) ]]
			local v12, v2, v3, v4, v5 = v1.resolve(5, 6, nil, 7):await()

			expect(v12).to.equal(true)
			expect(v2).to.equal(5)
			expect(v3).to.equal(6)
			expect(v4).to.equal(nil)
			expect(v5).to.equal(7)
		end)
		it("should work if yielding is needed", function() --[[ Line: 1490 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = false

			task.spawn(function() --[[ Line: 1492 | Upvalues: v1 (ref), v12 (ref) ]]
				local _, v13 = v1.delay(1):await()

				expect((type(v13))).to.equal("number")
				v12 = true
			end)
			advanceTime(2)
			expect(v12).to.equal(true)
		end)
	end)
	describe("Promise:expect", function() --[[ Line: 1503 | Upvalues: v1 (copy) ]]
		it("should throw the correct values", function() --[[ Line: 1504 | Upvalues: v1 (ref) ]]
			local t = {}
			local v12 = v1.reject(t)
			local ok, result = pcall(function() --[[ Line: 1508 | Upvalues: v12 (copy) ]]
				v12:expect()
			end)

			expect(ok).to.equal(false)
			expect(result).to.equal(t)
		end)
	end)
	describe("Promise:now", function() --[[ Line: 1517 | Upvalues: v1 (copy) ]]
		it("should resolve if the Promise is resolved", function() --[[ Line: 1518 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.resolve("foo"):now():_unwrap()

			expect(v12).to.equal(true)
			expect(v2).to.equal("foo")
		end)
		it("should reject if the Promise is not resolved", function() --[[ Line: 1525 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.new(function() --[[ Line: 1526 ]] end):now():_unwrap()

			expect(v12).to.equal(false)
			expect(v1.Error.isKind(v2, "NotResolvedInTime")).to.equal(true)
		end)
		it("should reject with a custom rejection value", function() --[[ Line: 1532 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.new(function() --[[ Line: 1533 ]] end):now("foo"):_unwrap()

			expect(v12).to.equal(false)
			expect(v2).to.equal("foo")
		end)
	end)
	describe("Promise.each", function() --[[ Line: 1540 | Upvalues: v1 (copy) ]]
		it("should iterate", function() --[[ Line: 1541 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.each({ "foo", "bar", "baz", "qux" }, function(...) --[[ Line: 1547 ]]
				return { ... }
			end):_unwrap()

			expect(v12).to.equal(true)
			expect(v2[1][1]).to.equal("foo")
			expect(v2[1][2]).to.equal(1)
			expect(v2[2][1]).to.equal("bar")
			expect(v2[2][2]).to.equal(2)
			expect(v2[3][1]).to.equal("baz")
			expect(v2[3][2]).to.equal(3)
			expect(v2[4][1]).to.equal("qux")
			expect(v2[4][2]).to.equal(4)
		end)
		it("should iterate serially", function() --[[ Line: 1562 | Upvalues: v1 (ref) ]]
			local t = {}
			local t2 = {}
			local v12 = v1.each({ "foo", "bar", "baz" }, function(p1, p2) --[[ Line: 1570 | Upvalues: t2 (copy), v1 (ref), t (copy) ]]
				t2[p2] = (t2[p2] or 0) + 1

				return v1.new(function(p12) --[[ Line: 1573 | Upvalues: t (ref), p1 (copy) ]]
					local function f2() --[[ Line: 1574 | Upvalues: p12 (copy), p1 (ref) ]]
						p12(p1:upper())
					end

					table.insert(t, f2)
				end)
			end)

			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(#t).to.equal(1)
			expect(t2[1]).to.equal(1)
			expect(t2[2]).to.never.be.ok()
			table.remove(t, 1)()
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(#t).to.equal(1)
			expect(t2[1]).to.equal(1)
			expect(t2[2]).to.equal(1)
			expect(t2[3]).to.never.be.ok()
			table.remove(t, 1)()
			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(t2[1]).to.equal(1)
			expect(t2[2]).to.equal(1)
			expect(t2[3]).to.equal(1)
			table.remove(t, 1)()
			expect(v12:getStatus()).to.equal(v1.Status.Resolved)

			local v2 = expect

			v2((type(v12._values[1]))).to.equal("table")

			local v4 = expect

			v4((type(v12._values[2]))).to.equal("nil")

			local v6 = v12._values[1]

			expect(v6[1]).to.equal("FOO")
			expect(v6[2]).to.equal("BAR")
			expect(v6[3]).to.equal("BAZ")
		end)
		it("should reject with the value if the predicate promise rejects", function() --[[ Line: 1613 | Upvalues: v1 (ref) ]]
			local v12 = v1.each({ 1, 2, 3 }, function() --[[ Line: 1614 | Upvalues: v1 (ref) ]]
				return v1.reject("foobar")
			end)

			expect(v12:getStatus()).to.equal(v1.Status.Rejected)
			expect(v12._values[1]).to.equal("foobar")
		end)
		it("should allow Promises to be in the list and wait when it gets to them", function() --[[ Line: 1622 | Upvalues: v1 (ref) ]]
			local v12 = nil
			local t = { (v1.new(function(p1) --[[ Line: 1624 | Upvalues: v12 (ref) ]]
					v12 = p1
				end)) }
			local v2 = v1.each(t, function(p1) --[[ Line: 1630 ]]
				return p1 * 2
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12(2)
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1][1]).to.equal(4)
		end)
		it("should reject with the value if a Promise from the list rejects", function() --[[ Line: 1642 | Upvalues: v1 (ref) ]]
			local v12 = false
			local v2 = v1.each({ 1, 2, v1.reject("foobar") }, function(p1) --[[ Line: 1644 | Upvalues: v12 (ref) ]]
				v12 = true

				return "never"
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Rejected)
			expect(v2._values[1]).to.equal("foobar")
			expect(v12).to.equal(false)
		end)
		it("should reject immediately if there\'s a cancelled Promise in the list initially", function() --[[ Line: 1654 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1655 ]] end)

			v12:cancel()

			local v2 = false
			local v3 = v1.each({ 1, 2, v12 }, function() --[[ Line: 1659 | Upvalues: v2 (ref) ]]
				v2 = true
			end)

			expect(v3:getStatus()).to.equal(v1.Status.Rejected)
			expect(v2).to.equal(false)
			expect(v3._values[1].kind).to.equal(v1.Error.Kind.AlreadyCancelled)
		end)
		it("should stop iteration if Promise.each is cancelled", function() --[[ Line: 1668 | Upvalues: v1 (ref) ]]
			local t = {}
			local v12 = v1.each({ "foo", "bar", "baz" }, function(p1, p2) --[[ Line: 1675 | Upvalues: t (copy), v1 (ref) ]]
				t[p2] = (t[p2] or 0) + 1

				return v1.new(function() --[[ Line: 1678 ]] end)
			end)

			expect(v12:getStatus()).to.equal(v1.Status.Started)
			expect(t[1]).to.equal(1)
			expect(t[2]).to.never.be.ok()
			v12:cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
			expect(t[1]).to.equal(1)
			expect(t[2]).to.never.be.ok()
		end)
		it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function() --[[ Line: 1692 | Upvalues: v1 (ref) ]]
			local v12 = nil

			v1.each({ "foo", "bar", "baz" }, function(p1, p2) --[[ Line: 1699 | Upvalues: v12 (ref), v1 (ref) ]]
				v12 = v1.new(function() --[[ Line: 1700 ]] end)

				return v12
			end):cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
		end)
		it("should cancel Promises in the list if Promise.each is cancelled", function() --[[ Line: 1709 | Upvalues: v1 (ref) ]]
			local v12 = v1.new(function() --[[ Line: 1710 ]] end)

			v1.each({ v12 }, function() --[[ Line: 1712 ]] end):cancel()
			expect(v12:getStatus()).to.equal(v1.Status.Cancelled)
		end)
	end)
	describe("Promise.retry", function() --[[ Line: 1720 | Upvalues: v1 (copy) ]]
		it("should retry N times", function() --[[ Line: 1721 | Upvalues: v1 (ref) ]]
			local v12 = 0
			local v2 = v1.retry(function(p1) --[[ Line: 1724 | Upvalues: v12 (ref), v1 (ref) ]]
				expect(p1).to.equal("foo")
				v12 = v12 + 1

				if v12 == 5 then
					return v1.resolve("ok")
				end

				return v1.reject("fail")
			end, 5, "foo")

			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal("ok")
		end)
		it("should reject if threshold is exceeded", function() --[[ Line: 1740 | Upvalues: v1 (ref) ]]
			local v12 = v1.retry(function() --[[ Line: 1741 | Upvalues: v1 (ref) ]]
				return v1.reject("fail")
			end, 5)

			expect(v12:getStatus()).to.equal(v1.Status.Rejected)
			expect(v12._values[1]).to.equal("fail")
		end)
	end)
	describe("Promise.retryWithDelay", function() --[[ Line: 1750 | Upvalues: v1 (copy), advanceTime (ref) ]]
		it("should retry after a delay", function() --[[ Line: 1751 | Upvalues: v1 (ref), advanceTime (ref) ]]
			local v12 = 0
			local v2 = v1.retryWithDelay(function(p1) --[[ Line: 1754 | Upvalues: v12 (ref), v1 (ref) ]]
				expect(p1).to.equal("foo")
				v12 = v12 + 1

				if v12 == 3 then
					return v1.resolve("ok")
				end

				return v1.reject("fail")
			end, 3, 10, "foo")

			expect(v12).to.equal(1)
			advanceTime(11)
			expect(v12).to.equal(2)
			advanceTime(11)
			expect(v12).to.equal(3)
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal("ok")
		end)
	end)
	describe("Promise.fromEvent", function() --[[ Line: 1781 | Upvalues: v1 (copy) ]]
		it("should convert a Promise into an event", function() --[[ Line: 1782 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.fromEvent(v12.Event)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire("foo")
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal("foo")
		end)
		it("should convert a Promise into an event with the predicate", function() --[[ Line: 1795 | Upvalues: v1 (ref) ]]
			local v12 = Instance.new("BindableEvent")
			local v2 = v1.fromEvent(v12.Event, function(p1) --[[ Line: 1798 ]]
				return p1 == "foo"
			end)

			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire("bar")
			expect(v2:getStatus()).to.equal(v1.Status.Started)
			v12:Fire("foo")
			expect(v2:getStatus()).to.equal(v1.Status.Resolved)
			expect(v2._values[1]).to.equal("foo")
		end)
	end)
	describe("Promise.is", function() --[[ Line: 1815 | Upvalues: v1 (copy) ]]
		it("should work with current version", function() --[[ Line: 1816 | Upvalues: v1 (ref) ]]
			expect(v1.is((v1.resolve(1)))).to.equal(true)
		end)
		it("should work with any object with an andThen", function() --[[ Line: 1822 | Upvalues: v1 (ref) ]]
			expect(v1.is({
				andThen = function() --[[ andThen | Line: 1824 ]]
					return 1
				end
			})).to.equal(true)
		end)
		it("should work with older promises", function() --[[ Line: 1832 | Upvalues: v1 (ref) ]]
			local t = {
				prototype = {}
			}

			t.__index = t.prototype

			local function andThen(p1) --[[ andThen | Line: 1837 ]] end

			t.prototype.andThen = andThen
			expect(v1.is((setmetatable({}, t)))).to.equal(true)
		end)
	end)
end