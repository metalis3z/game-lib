-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: init.spec, time of decompilation: Sun May  3 10:10:31 2026 ]]
return function() -- line: 1
	local Parent = require(script.Parent)

	Parent.TEST = true

	local BindableEvent = Instance.new("BindableEvent")

	Parent._timeEvent = BindableEvent.Event

	local n1 = 0

	function Parent._getTime() -- line: 12
		-- upvalues: n1 (ref)
		return n1
	end

	local function advanceTime(p1) -- line: 16
		-- upvalues: n1 (ref), BindableEvent (copy)
		local v7 = p1 or 0.016666666666666666

		n1 += v7
		BindableEvent:Fire(v7)
	end
	local function pack(...) -- line: 24
		return select("#", ...), { ... }
	end

	describe("Promise.Status", function() -- line: 30
		-- upvalues: Parent (copy)
		it("should error if indexing nil value", function() -- line: 31
			-- upvalues: Parent (copy)
			expect(function() -- line: 32
				-- upvalues: Parent (copy)
				local _ = Parent.Status.wrong
			end).to.throw()
		end)
	end)
	describe("Unhandled rejection signal", function() -- line: 38
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should call unhandled rejection callbacks", function() -- line: 39
			-- upvalues: Parent (copy), advanceTime (ref)
			local v8 = Parent.new(function(_, p3) -- line: 40
				p3(1, 2)
			end)
			local n2 = 0
			local v10 = Parent.onUnhandledRejection(function(p4, p5, p6) --[[ callback ]] -- line: 46
				-- upvalues: n2 (ref), v8 (copy)
				n2 += 1
				expect(p4).to.equal(v8)
				expect(p5).to.equal(1)
				expect(p6).to.equal(2)
			end)

			advanceTime()
			expect(n2).to.equal(1)
			v10()
			Parent.new(function(_, p8) -- line: 62
				p8(3, 4)
			end)
			advanceTime()
			expect(n2).to.equal(1)
		end)
	end)
	describe("Promise.new", function() -- line: 72
		-- upvalues: Parent (copy)
		it("should instantiate with a callback", function() -- line: 73
			-- upvalues: Parent (copy)
			local v11 = Parent.new(function() -- line: 74
			end)

			expect(v11).to.be.ok()
		end)
		it("should invoke the given callback with resolve and reject", function() -- line: 79
			-- upvalues: Parent (copy)
			local n3 = 0
			local u13 = nil
			local u14 = nil
			local v15 = Parent.new(function(p9, p10) -- line: 84
				-- upvalues: n3 (ref), u13 (ref), u14 (ref)
				n3 += 1
				u13 = p9
				u14 = p10
			end)

			expect(v15).to.be.ok()
			expect(n3).to.equal(1)
			expect(u13).to.be.a("function")
			expect(u14).to.be.a("function")
			expect(v15:getStatus()).to.equal(Parent.Status.Started)
		end)
		it("should resolve promises on resolve()", function() -- line: 98
			-- upvalues: Parent (copy)
			local n4 = 0
			local v17 = Parent.new(function(p11) -- line: 101
				-- upvalues: n4 (ref)
				n4 += 1
				p11()
			end)

			expect(v17).to.be.ok()
			expect(n4).to.equal(1)
			expect(v17:getStatus()).to.equal(Parent.Status.Resolved)
		end)
		it("should reject promises on reject()", function() -- line: 111
			-- upvalues: Parent (copy)
			local n5 = 0
			local v19 = Parent.new(function(_, p13) -- line: 114
				-- upvalues: n5 (ref)
				n5 += 1
				p13()
			end)

			expect(v19).to.be.ok()
			expect(n5).to.equal(1)
			expect(v19:getStatus()).to.equal(Parent.Status.Rejected)
		end)
		it("should reject on error in callback", function() -- line: 124
			-- upvalues: Parent (copy)
			local n6 = 0
			local v21 = Parent.new(function() -- line: 127
				-- upvalues: n6 (ref)
				n6 += 1
				error("hahah")
			end)

			expect(v21).to.be.ok()
			expect(n6).to.equal(1)
			expect(v21:getStatus()).to.equal(Parent.Status.Rejected)
			expect(tostring(v21._values[1]):find("hahah")).to.be.ok()
			expect(tostring(v21._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(v21._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should work with C functions", function() -- line: 142
			-- upvalues: Parent (copy)
			expect(function() -- line: 143
				-- upvalues: Parent (copy)
				Parent.new(tick):andThen(tick)
			end).to.never.throw()
		end)
		it("should have a nice tostring", function() -- line: 148
			-- upvalues: Parent (copy)
			expect(tostring(Parent.resolve()):gmatch("Promise(Resolved)")).to.be.ok()
		end)
		it("should allow yielding", function() -- line: 152
			-- upvalues: Parent (copy)
			local BindableEvent2 = Instance.new("BindableEvent")
			local v23 = Parent.new(function(p14) -- line: 154
				-- upvalues: BindableEvent2 (copy)
				BindableEvent2.Event:Wait()
				p14(5)
			end)

			expect(v23:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent2:Fire()
			expect(v23:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v23._values[1]).to.equal(5)
		end)
		it("should preserve stack traces of resolve-chained promises", function() -- line: 165
			-- upvalues: Parent (copy)
			local v24 = Parent.new(function(p15) -- line: 170
				-- upvalues: Parent (copy)
				p15(Parent.new(function() -- line: 171
					error("sample text")
				end))
			end)

			expect(v24:getStatus()).to.equal(Parent.Status.Rejected)

			local str = tostring(v24._values[1])

			expect(str:find("sample text")).to.be.ok()
			expect(str:find("nestedCall")).to.be.ok()
			expect(str:find("runExecutor")).to.be.ok()
			expect(str:find("runPlanNode")).to.be.ok()
			expect(str:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
		end)
		it("should report errors from Promises with _error (< v2)", function() -- line: 188
			-- upvalues: Parent (copy)
			local v26 = Parent.reject()

			v26._error = "Sample error"

			local v27 = Parent.resolve():andThenReturn(v26)

			expect(v27:getStatus()).to.equal(Parent.Status.Rejected)

			local str = tostring(v27._values[1])

			expect(str:find("Sample error")).to.be.ok()
			expect(str:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok()
			expect(str:find("%[No stack trace available")).to.be.ok()
		end)
		it("should allow callable tables", function() -- line: 204
			-- upvalues: Parent (copy)
			local v29 = Parent.new((setmetatable({}, {
				__call = function(_, p17) --[[ __call ]] -- line: 206
					p17(1)
				end
			})))
			local u30 = false

			v29:andThen((setmetatable({}, {
				__call = function(_, p19) --[[ __call ]] -- line: 213
					-- upvalues: u30 (ref)
					expect(p19).to.equal(1)
					u30 = true
				end
			})))
			expect(u30).to.equal(true)
		end)
		itSKIP("should close the thread after resolve", function() -- line: 222
			-- upvalues: Parent (copy)
			local n7 = 0

			Parent.new(function(p20) -- line: 224
				-- upvalues: n7 (ref), Parent (copy)
				n7 += 1
				p20()
				Parent.delay(1):await()
				n7 += 1
			end)
			task.wait(1)
			expect(n7).to.equal(1)
		end)
	end)
	describe("Promise.defer", function() -- line: 237
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should execute after the time event", function() -- line: 238
			-- upvalues: Parent (copy), advanceTime (ref)
			local n8 = 0
			local v33 = Parent.defer(function(p21, p22, p23, p24) -- line: 240
				-- upvalues: n8 (ref)
				expect((type(p21))).to.equal("function")
				expect((type(p22))).to.equal("function")
				expect((type(p23))).to.equal("function")
				expect((type(p24))).to.equal("nil")
				n8 += 1
				p21("foo")
			end)

			expect(n8).to.equal(0)
			expect(v33:getStatus()).to.equal(Parent.Status.Started)
			advanceTime()
			expect(n8).to.equal(1)
			expect(v33:getStatus()).to.equal(Parent.Status.Resolved)
			advanceTime()
			expect(n8).to.equal(1)
		end)
	end)
	describe("Promise.delay", function() -- line: 263
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should schedule promise resolution", function() -- line: 264
			-- upvalues: Parent (copy), advanceTime (ref)
			local v34 = Parent.delay(1)

			expect(v34:getStatus()).to.equal(Parent.Status.Started)
			advanceTime()
			expect(v34:getStatus()).to.equal(Parent.Status.Started)
			advanceTime(1)
			expect(v34:getStatus()).to.equal(Parent.Status.Resolved)
		end)
		it("should allow for delays to be cancelled", function() -- line: 276
			-- upvalues: Parent (copy), advanceTime (ref)
			local v35 = Parent.delay(2)

			Parent.delay(1):andThen(function() -- line: 279
				-- upvalues: v35 (copy)
				v35:cancel()
			end)
			expect(v35:getStatus()).to.equal(Parent.Status.Started)
			advanceTime()
			expect(v35:getStatus()).to.equal(Parent.Status.Started)
			advanceTime(1)
			expect(v35:getStatus()).to.equal(Parent.Status.Cancelled)
			advanceTime(1)
		end)
	end)
	describe("Promise.resolve", function() -- line: 292
		-- upvalues: Parent (copy)
		it("should immediately resolve with a value", function() -- line: 293
			-- upvalues: Parent (copy)
			local v36 = Parent.resolve(5, 6)

			expect(v36).to.be.ok()
			expect(v36:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v36._values[1]).to.equal(5)
			expect(v36._values[2]).to.equal(6)
		end)
		it("should chain onto passed promises", function() -- line: 302
			-- upvalues: Parent (copy)
			local v37 = Parent.resolve(Parent.new(function(_, p26) -- line: 303
				p26(7)
			end))

			expect(v37).to.be.ok()
			expect(v37:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v37._values[1]).to.equal(7)
		end)
	end)
	describe("Promise.reject", function() -- line: 313
		-- upvalues: Parent (copy)
		it("should immediately reject with a value", function() -- line: 314
			-- upvalues: Parent (copy)
			local v38 = Parent.reject(6, 7)

			expect(v38).to.be.ok()
			expect(v38:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v38._values[1]).to.equal(6)
			expect(v38._values[2]).to.equal(7)
		end)
		it("should pass a promise as-is as an error", function() -- line: 323
			-- upvalues: Parent (copy)
			local v39 = Parent.new(function(p27) -- line: 324
				p27(6)
			end)
			local v40 = Parent.reject(v39)

			expect(v40).to.be.ok()
			expect(v40:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v40._values[1]).to.equal(v39)
		end)
	end)
	describe("Promise:andThen", function() -- line: 336
		-- upvalues: Parent (copy), pack (copy)
		it("should allow yielding", function() -- line: 337
			-- upvalues: Parent (copy)
			local BindableEvent3 = Instance.new("BindableEvent")
			local v42 = Parent.resolve():andThen(function() -- line: 339
				-- upvalues: BindableEvent3 (copy)
				BindableEvent3.Event:Wait()

				return 5
			end)

			expect(v42:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent3:Fire()
			expect(v42:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v42._values[1]).to.equal(5)
		end)
		it("should run andThens on a new thread", function() -- line: 350
			-- upvalues: Parent (copy)
			local BindableEvent4 = Instance.new("BindableEvent")
			local u44 = nil
			local v45 = Parent.new(function(p28) -- line: 354
				-- upvalues: u44 (ref)
				u44 = p28
			end)
			local v46 = v45:andThen(function() -- line: 358
				-- upvalues: BindableEvent4 (copy)
				BindableEvent4.Event:Wait()

				return 5
			end)
			local v47 = v45:andThen(function() -- line: 363
				return "foo"
			end)

			expect(v45:getStatus()).to.equal(Parent.Status.Started)
			u44()
			expect(v47:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v47._values[1]).to.equal("foo")
			expect(v46:getStatus()).to.equal(Parent.Status.Started)
		end)
		it("should chain onto resolved promises", function() -- line: 374
			-- upvalues: Parent (copy), pack (copy)
			local u48 = nil
			local u49 = nil
			local n9 = 0
			local n10 = 0
			local v52 = Parent.resolve(5)
			local v53 = v52:andThen(function(...) -- line: 382
				-- upvalues: u49 (ref), u48 (ref), pack (copy), n9 (ref)
				local v307, v308 = pack(...)

				u49 = v307
				u48 = v308
				n9 += 1
			end, function() -- line: 385
				-- upvalues: n10 (ref)
				n10 += 1
			end)

			expect(n10).to.equal(0)
			expect(n9).to.equal(1)
			expect(u49).to.equal(1)
			expect(u48[1]).to.equal(5)
			expect(v52).to.be.ok()
			expect(v52:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v52._values[1]).to.equal(5)
			expect(v53).to.be.ok()
			expect(v53).never.to.equal(v52)
			expect(v53:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v53._values).to.equal(0)
		end)
		it("should chain onto rejected promises", function() -- line: 405
			-- upvalues: Parent (copy), pack (copy)
			local u54 = nil
			local u55 = nil
			local n11 = 0
			local n12 = 0
			local v58 = Parent.reject(5)
			local v59 = v58:andThen(function(...) -- line: 413
				-- upvalues: n12 (ref)
				n12 += 1
			end, function(...) -- line: 415
				-- upvalues: u55 (ref), u54 (ref), pack (copy), n11 (ref)
				local v309, v310 = pack(...)

				u55 = v309
				u54 = v310
				n11 += 1
			end)

			expect(n12).to.equal(0)
			expect(n11).to.equal(1)
			expect(u55).to.equal(1)
			expect(u54[1]).to.equal(5)
			expect(v58).to.be.ok()
			expect(v58:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v58._values[1]).to.equal(5)
			expect(v59).to.be.ok()
			expect(v59).never.to.equal(v58)
			expect(v59:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v59._values).to.equal(0)
		end)
		it("should reject on error in callback", function() -- line: 436
			-- upvalues: Parent (copy)
			local n13 = 0
			local v61 = Parent.resolve(1):andThen(function() -- line: 439
				-- upvalues: n13 (ref)
				n13 += 1
				error("hahah")
			end)

			expect(v61).to.be.ok()
			expect(n13).to.equal(1)
			expect(v61:getStatus()).to.equal(Parent.Status.Rejected)
			expect(tostring(v61._values[1]):find("hahah")).to.be.ok()
			expect(tostring(v61._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(v61._values[1]):find("runExecutor")).to.be.ok()
		end)
		it("should chain onto asynchronously resolved promises", function() -- line: 454
			-- upvalues: Parent (copy)
			local t1 = nil
			local u63 = nil
			local n14 = 0
			local n15 = 0
			local u66 = nil
			local v67 = Parent.new(function(p29) -- line: 461
				-- upvalues: u66 (ref)
				u66 = p29
			end)
			local v68 = v67:andThen(function(...) -- line: 465
				-- upvalues: t1 (ref), u63 (ref), n14 (ref)
				t1 = { ... }
				u63 = select("#", ...)
				n14 += 1
			end, function() -- line: 469
				-- upvalues: n15 (ref)
				n15 += 1
			end)

			expect(n14).to.equal(0)
			expect(n15).to.equal(0)
			u66(6)
			expect(n15).to.equal(0)
			expect(n14).to.equal(1)
			expect(u63).to.equal(1)
			expect(t1[1]).to.equal(6)
			expect(v67).to.be.ok()
			expect(v67:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v67._values[1]).to.equal(6)
			expect(v68).to.be.ok()
			expect(v68).never.to.equal(v67)
			expect(v68:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v68._values).to.equal(0)
		end)
		it("should chain onto asynchronously rejected promises", function() -- line: 494
			-- upvalues: Parent (copy)
			local t2 = nil
			local u70 = nil
			local n16 = 0
			local n17 = 0
			local u73 = nil
			local v74 = Parent.new(function(_, p31) -- line: 501
				-- upvalues: u73 (ref)
				u73 = p31
			end)
			local v75 = v74:andThen(function() -- line: 505
				-- upvalues: n17 (ref)
				n17 += 1
			end, function(...) -- line: 507
				-- upvalues: t2 (ref), u70 (ref), n16 (ref)
				t2 = { ... }
				u70 = select("#", ...)
				n16 += 1
			end)

			expect(n16).to.equal(0)
			expect(n17).to.equal(0)
			u73(6)
			expect(n17).to.equal(0)
			expect(n16).to.equal(1)
			expect(u70).to.equal(1)
			expect(t2[1]).to.equal(6)
			expect(v74).to.be.ok()
			expect(v74:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v74._values[1]).to.equal(6)
			expect(v75).to.be.ok()
			expect(v75).never.to.equal(v74)
			expect(v75:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v75._values).to.equal(0)
		end)
		it("should propagate errors through multiple levels", function() -- line: 534
			-- upvalues: Parent (copy)
			local u76 = nil
			local u77 = nil
			local u78 = nil

			Parent.new(function(_, p33) -- line: 536
				p33(1, 2, 3)
			end):andThen(function() -- line: 538
			end):catch(function(p34, p35, p36) -- line: 538
				-- upvalues: u76 (ref), u77 (ref), u78 (ref)
				u76 = p34
				u77 = p35
				u78 = p36
			end)
			expect(u76).to.equal(1)
			expect(u77).to.equal(2)
			expect(u78).to.equal(3)
		end)
		it("should not call queued callbacks from a cancelled sub-promise", function() -- line: 547
			-- upvalues: Parent (copy)
			local u79 = nil
			local n18 = 0
			local v81 = Parent.new(function(p37) -- line: 551
				-- upvalues: u79 (ref)
				u79 = p37
			end)

			v81:andThen(function() -- line: 555
				-- upvalues: n18 (ref)
				n18 += 1
			end)
			v81:andThen(function() -- line: 560
				-- upvalues: n18 (ref)
				n18 += 1
			end):cancel()
			u79("foo")
			expect(n18).to.equal(1)
		end)
	end)
	describe("Promise:cancel", function() -- line: 571
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should mark promises as cancelled and not resolve or reject them", function() -- line: 572
			-- upvalues: Parent (copy)
			local n19 = 0
			local n20 = 0
			local v84 = Parent.new(function() -- line: 575
			end):andThen(function() -- line: 576
				-- upvalues: n19 (ref)
				n19 += 1
			end):finally(function() -- line: 579
				-- upvalues: n20 (ref)
				n20 += 1
			end)

			v84:cancel()
			v84:cancel()
			expect(n19).to.equal(0)
			expect(n20).to.equal(1)
			expect(v84:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should call the cancellation hook once", function() -- line: 591
			-- upvalues: Parent (copy)
			local n21 = 0
			local v86 = Parent.new(function(_, _, p40) -- line: 594
				-- upvalues: n21 (ref)
				p40(function() -- line: 595
					-- upvalues: n21 (ref)
					n21 += 1
				end)
			end)

			v86:cancel()
			v86:cancel()
			expect(n21).to.equal(1)
		end)
		it("should propagate cancellations", function() -- line: 606
			-- upvalues: Parent (copy)
			local v87 = Parent.new(function() -- line: 607
			end)
			local v88 = v87:andThen()
			local v89 = v87:andThen()

			expect(v87:getStatus()).to.equal(Parent.Status.Started)
			expect(v88:getStatus()).to.equal(Parent.Status.Started)
			expect(v89:getStatus()).to.equal(Parent.Status.Started)
			v88:cancel()
			expect(v87:getStatus()).to.equal(Parent.Status.Started)
			expect(v88:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v89:getStatus()).to.equal(Parent.Status.Started)
			v89:cancel()
			expect(v87:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v88:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v89:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should affect downstream promises", function() -- line: 629
			-- upvalues: Parent (copy)
			local v90 = Parent.new(function() -- line: 630
			end)
			local v91 = v90:andThen()

			v90:cancel()
			expect(v91:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should track consumers", function() -- line: 638
			-- upvalues: Parent (copy)
			local v92 = Parent.new(function() -- line: 639
			end)
			local v93 = Parent.resolve()
			local v94 = v93:andThen(function() -- line: 641
				-- upvalues: v92 (copy)
				return v92
			end)
			local v95 = Parent.new(function(p41) -- line: 644
				-- upvalues: v94 (copy)
				p41(v94)
			end)
			local v96 = v95:andThen(function() -- line: 647
			end)

			expect(v94._parent).to.never.equal(v93)
			expect(v95._parent).to.never.equal(v94)
			expect(v95._consumers[v96]).to.be.ok()
			expect(v96._parent).to.equal(v95)
		end)
		it("should cancel resolved pending promises", function() -- line: 655
			-- upvalues: Parent (copy)
			local v97 = Parent.new(function() -- line: 656
			end)
			local v98 = Parent.new(function(p42) -- line: 658
				-- upvalues: v97 (copy)
				p42(v97)
			end):finally(function() -- line: 660
			end)

			v98:cancel()
			expect(v97._status).to.equal(Parent.Status.Cancelled)
			expect(v98._status).to.equal(Parent.Status.Cancelled)
		end)
		it("should close the promise thread", function() -- line: 668
			-- upvalues: Parent (copy), advanceTime (ref)
			local n22 = 0

			Parent.new(function() -- line: 670
				-- upvalues: n22 (ref), Parent (copy)
				n22 += 1
				Parent.delay(1):await()
				n22 += 1
			end):cancel()
			advanceTime(2)
			expect(n22).to.equal(1)
		end)
	end)
	describe("Promise:finally", function() -- line: 683
		-- upvalues: Parent (copy)
		it("should be called upon resolve, reject, or cancel", function() -- line: 684
			-- upvalues: Parent (copy)
			local n23 = 0

			local function finally() -- line: 687
				-- upvalues: n23 (ref)
				n23 += 1
			end

			Parent.new(function(p43, _) -- line: 692
				p43()
			end):finally(finally)
			Parent.resolve():andThen(function() -- line: 697
			end):finally(finally):finally(finally)
			Parent.reject():finally(finally)
			Parent.new(function() -- line: 702
			end):finally(finally):cancel()
			expect(n23).to.equal(5)
		end)
		it("should not forward return values", function() -- line: 708
			-- upvalues: Parent (copy)
			local u102 = nil

			Parent.resolve(2):finally(function() -- line: 712
				return 1
			end):andThen(function(p45) -- line: 715
				-- upvalues: u102 (ref)
				u102 = p45
			end)
			expect(u102).to.equal(2)
		end)
		it("should not consume rejections", function() -- line: 722
			-- upvalues: Parent (copy)
			local u103 = false
			local u104 = false

			Parent.reject(5):finally(function() -- line: 726
				return 42
			end):andThen(function() -- line: 729
				-- upvalues: u104 (ref)
				u104 = true
			end):catch(function(p46) -- line: 732
				-- upvalues: u103 (ref)
				u103 = true
				expect(p46).to.equal(5)
			end)
			expect(u103).to.equal(true)
			expect(u104).to.equal(false)
		end)
		it("should wait for returned promises", function() -- line: 741
			-- upvalues: Parent (copy)
			local u105 = nil
			local v106 = Parent.reject("foo"):finally(function() -- line: 743
				-- upvalues: Parent (copy), u105 (ref)
				return Parent.new(function(p47) -- line: 744
					-- upvalues: u105 (ref)
					u105 = p47
				end)
			end)

			expect(v106:getStatus()).to.equal(Parent.Status.Started)
			u105()
			expect(v106:getStatus()).to.equal(Parent.Status.Rejected)

			local _, v108 = v106:_unwrap()

			expect(v108).to.equal("foo")
		end)
		it("should reject with a returned rejected promise's value", function() -- line: 758
			-- upvalues: Parent (copy)
			local u109 = nil
			local v110 = Parent.reject("foo"):finally(function() -- line: 760
				-- upvalues: Parent (copy), u109 (ref)
				return Parent.new(function(_, p49) -- line: 761
					-- upvalues: u109 (ref)
					u109 = p49
				end)
			end)

			expect(v110:getStatus()).to.equal(Parent.Status.Started)
			u109("bar")
			expect(v110:getStatus()).to.equal(Parent.Status.Rejected)

			local _, v112 = v110:_unwrap()

			expect(v112).to.equal("bar")
		end)
		it("should reject when handler errors", function() -- line: 775
			-- upvalues: Parent (copy)
			local t3 = {}
			local v114, v115 = Parent.reject("bar"):finally(function() -- line: 777
				-- upvalues: t3 (copy)
				error(t3)
			end):_unwrap()

			expect(v114).to.equal(false)
			expect(v115).to.equal(t3)
		end)
		it("should not prevent cancellation", function() -- line: 787
			-- upvalues: Parent (copy)
			local v116 = Parent.new(function() -- line: 788
			end)
			local u117 = false

			v116:finally(function() -- line: 791
				-- upvalues: u117 (ref)
				u117 = true
			end)
			v116:andThen(function() -- line: 795
			end):cancel()
			expect(v116:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(u117).to.equal(true)
		end)
		it("should propagate cancellation downwards", function() -- line: 803
			-- upvalues: Parent (copy)
			local u118 = false
			local v119 = Parent.new(function() -- line: 806
			end)
			local v120 = v119:finally(function() -- line: 808
				-- upvalues: u118 (ref)
				u118 = true
			end)

			v119:cancel()
			expect(v119:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v120:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(u118).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should propagate cancellation upwards", function() -- line: 821
			-- upvalues: Parent (copy)
			local u121 = false
			local v122 = Parent.new(function() -- line: 824
			end)
			local v123 = v122:finally(function() -- line: 826
				-- upvalues: u121 (ref)
				u121 = true
			end)

			v123:cancel()
			expect(v122:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v123:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(u121).to.equal(true)
			expect(false).to.equal(false)
		end)
		it("should cancel returned promise if cancelled", function() -- line: 839
			-- upvalues: Parent (copy)
			local v124 = Parent.new(function() -- line: 840
			end)

			Parent.resolve():finally(function() -- line: 842
				-- upvalues: v124 (copy)
				return v124
			end):cancel()
			expect(v124:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
	end)
	describe("Promise.all", function() -- line: 852
		-- upvalues: Parent (copy), pack (copy)
		it("should error if given something other than a table", function() -- line: 853
			-- upvalues: Parent (copy)
			expect(function() -- line: 854
				-- upvalues: Parent (copy)
				Parent.all(1)
			end).to.throw()
		end)
		it("should resolve instantly with an empty table if given no promises", function() -- line: 859
			-- upvalues: Parent (copy)
			local v125 = Parent.all({})
			local v126, v127 = v125:_unwrap()

			expect(v126).to.equal(true)
			expect(v125:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v127).to.be.a("table")
			expect(next(v127)).to.equal(nil)
		end)
		it("should error if given non-promise values", function() -- line: 869
			-- upvalues: Parent (copy)
			expect(function() -- line: 870
				-- upvalues: Parent (copy)
				Parent.all({
					{},
					{},
					{}
				})
			end).to.throw()
		end)
		it("should wait for all promises to be resolved and return their values", function() -- line: 875
			-- upvalues: pack (copy), Parent (copy)
			local t4 = {}
			local v129, v130 = pack(1, "A string", nil, false)
			local t5 = {}

			for i = 1, v129 do
				t5[i] = Parent.new(function(p50) -- line: 883
					-- upvalues: t4 (copy), i (copy), v130 (copy)
					t4[i] = {
						p50,
						v130[i]
					}
				end)
			end

			local v133 = Parent.all(t5)

			for _, v in ipairs(t4) do
				expect(v133:getStatus()).to.equal(Parent.Status.Started)
				v[1](v[2])
			end

			local v136, v137 = pack(v133:_unwrap())
			local v138, v139 = unpack(v137, 1, v136)

			expect(v136).to.equal(2)
			expect(v138).to.equal(true)
			expect(v139).to.be.a("table")
			expect(#v139).to.equal(#t5)

			for i = 1, v129 do
				expect(v139[i]).to.equal(v130[i])
			end
		end)
		it("should reject if any individual promise rejected", function() -- line: 908
			-- upvalues: Parent (copy), pack (copy)
			local u141 = nil
			local u142 = nil
			local v143 = Parent.new(function(_, p52) -- line: 912
				-- upvalues: u141 (ref)
				u141 = p52
			end)
			local v144 = Parent.new(function(p53) -- line: 916
				-- upvalues: u142 (ref)
				u142 = p53
			end)
			local v145 = Parent.all({
				v143,
				v144
			})

			expect(v145:getStatus()).to.equal(Parent.Status.Started)
			u141("baz", "qux")
			u142("foo", "bar")

			local v146, v147 = pack(v145:_unwrap())
			local v148, v149, v150 = unpack(v147, 1, v146)

			expect(v146).to.equal(3)
			expect(v148).to.equal(false)
			expect(v149).to.equal("baz")
			expect(v150).to.equal("qux")
			expect(v144:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should not resolve if resolved after rejecting", function() -- line: 937
			-- upvalues: Parent (copy), pack (copy)
			local u151 = nil
			local u152 = nil
			local v153 = Parent.new(function(_, p55) -- line: 941
				-- upvalues: u151 (ref)
				u151 = p55
			end)
			local v154 = Parent.new(function(p56) -- line: 945
				-- upvalues: u152 (ref)
				u152 = p56
			end)
			local v155 = Parent.all({
				v153,
				v154
			})

			expect(v155:getStatus()).to.equal(Parent.Status.Started)
			u151("baz", "qux")
			u152("foo", "bar")

			local v156, v157 = pack(v155:_unwrap())
			local v158, v159, v160 = unpack(v157, 1, v156)

			expect(v156).to.equal(3)
			expect(v158).to.equal(false)
			expect(v159).to.equal("baz")
			expect(v160).to.equal("qux")
		end)
		it("should only reject once", function() -- line: 965
			-- upvalues: Parent (copy), pack (copy)
			local u161 = nil
			local u162 = nil
			local v163 = Parent.new(function(_, p58) -- line: 969
				-- upvalues: u161 (ref)
				u161 = p58
			end)
			local v164 = Parent.new(function(_, p60) -- line: 973
				-- upvalues: u162 (ref)
				u162 = p60
			end)
			local v165 = Parent.all({
				v163,
				v164
			})

			expect(v165:getStatus()).to.equal(Parent.Status.Started)
			u161("foo", "bar")
			expect(v165:getStatus()).to.equal(Parent.Status.Rejected)
			u162("baz", "qux")

			local v166, v167 = pack(v165:_unwrap())
			local v168, v169, v170 = unpack(v167, 1, v166)

			expect(v166).to.equal(3)
			expect(v168).to.equal(false)
			expect(v169).to.equal("foo")
			expect(v170).to.equal("bar")
		end)
		it("should error if a non-array table is passed in", function() -- line: 996
			-- upvalues: Parent (copy)
			local ok, result = pcall(function() -- line: 997
				-- upvalues: Parent (copy)
				Parent.all(Parent.new(function() -- line: 998
				end))
			end)

			expect(ok).to.be.ok()
			expect(result:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel pending promises if one rejects", function() -- line: 1005
			-- upvalues: Parent (copy)
			local v173 = Parent.new(function() -- line: 1006
			end)

			expect(Parent.all({
				Parent.resolve(),
				Parent.reject(),
				v173
			}):getStatus()).to.equal(Parent.Status.Rejected)
			expect(v173:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should cancel promises if it is cancelled", function() -- line: 1015
			-- upvalues: Parent (copy)
			local v174 = Parent.new(function() -- line: 1016
			end)

			v174:andThen(function() -- line: 1017
			end)

			local t6 = {
				Parent.new(function() -- line: 1020
				end),
				Parent.new(function() -- line: 1021
				end),
				v174
			}

			Parent.all(t6):cancel()
			expect(t6[1]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t6[2]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t6[3]:getStatus()).to.equal(Parent.Status.Started)
		end)
	end)
	describe("Promise.fold", function() -- line: 1033
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should return the initial value in a promise when the list is empty", function() -- line: 1034
			-- upvalues: Parent (copy)
			local t7 = {}
			local v177 = Parent.fold({}, function() -- line: 1036
				error("should not be called")
			end, t7)

			expect(Parent.is(v177)).to.equal(true)
			expect(v177:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v177:expect()).to.equal(t7)
		end)
		it("should accept promises in the list", function() -- line: 1045
			-- upvalues: Parent (copy)
			local u178 = nil
			local v179 = Parent.fold({
				Parent.new(function(p61) -- line: 1048
					-- upvalues: u178 (ref)
					u178 = p61
				end),
				2,
				3
			}, function(p62, p63) -- line: 1050
				return p62 + p63
			end, 0)

			u178(1)
			expect(Parent.is(v179)).to.equal(true)
			expect(v179:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v179:expect()).to.equal(6)
		end)
		it("should always return a promise even if the list or reducer don't use them", function() -- line: 1061
			-- upvalues: Parent (copy), advanceTime (ref)
			local v180 = Parent.fold({
				1,
				2,
				3
			}, function(p64, p65, p66) -- line: 1062
				-- upvalues: Parent (copy)
				if p66 == 2 then
					return Parent.delay(1):andThenReturn(p64 + p65)
				end

				return p64 + p65
			end, 0)

			expect(Parent.is(v180)).to.equal(true)
			expect(v180:getStatus()).to.equal(Parent.Status.Started)
			advanceTime(2)
			expect(v180:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v180:expect()).to.equal(6)
		end)
		it("should return the first rejected promise", function() -- line: 1076
			-- upvalues: Parent (copy)
			local v181 = Parent.fold({
				1,
				2,
				3
			}, function(p67, p68, p69) -- line: 1078
				-- upvalues: Parent (copy)
				if p69 == 2 then
					return Parent.reject("foo")
				end

				return p67 + p68
			end, 0)

			expect(Parent.is(v181)).to.equal(true)

			local v182, v183 = v181:awaitStatus()

			expect(v182).to.equal(Parent.Status.Rejected)
			expect(v183).to.equal("foo")
		end)
		it("should return the first canceled promise", function() -- line: 1091
			-- upvalues: Parent (copy)
			local u184 = nil
			local v185 = Parent.fold({
				1,
				2,
				3
			}, function(p70, p71, p72) -- line: 1093
				-- upvalues: u184 (ref), Parent (copy)
				if p72 == 1 then
					return p70 + p71
				end

				if p72 == 2 then
					u184 = Parent.delay(1):andThenReturn(p70 + p71)

					return u184
				end

				error("this should not run if the promise is cancelled")
			end, 0)

			expect(Parent.is(v185)).to.equal(true)
			expect(v185:getStatus()).to.equal(Parent.Status.Started)
			u184:cancel()
			expect(v185:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
	end)
	describe("Promise.race", function() -- line: 1110
		-- upvalues: Parent (copy)
		it("should resolve with the first settled value", function() -- line: 1111
			-- upvalues: Parent (copy)
			local v186 = Parent.race({
				Parent.resolve(1),
				Parent.resolve(2)
			}):andThen(function(p73) -- line: 1115
				expect(p73).to.equal(1)
			end)

			expect(v186:getStatus()).to.equal(Parent.Status.Resolved)
		end)
		it("should cancel other promises", function() -- line: 1122
			-- upvalues: Parent (copy)
			local v187 = Parent.new(function() -- line: 1123
			end)

			v187:andThen(function() -- line: 1124
			end)

			local t8 = {
				v187,
				Parent.new(function() -- line: 1127
				end),
				Parent.new(function(p74) -- line: 1128
					p74(2)
				end)
			}
			local v189 = Parent.race(t8)

			expect(v189:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v189._values[1]).to.equal(2)
			expect(t8[1]:getStatus()).to.equal(Parent.Status.Started)
			expect(t8[2]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t8[3]:getStatus()).to.equal(Parent.Status.Resolved)

			local v190 = Parent.new(function() -- line: 1141
			end)

			expect(Parent.race({
				Parent.reject(),
				Parent.resolve(),
				v190
			}):getStatus()).to.equal(Parent.Status.Rejected)
			expect(v190:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should error if a non-array table is passed in", function() -- line: 1150
			-- upvalues: Parent (copy)
			local ok, result = pcall(function() -- line: 1151
				-- upvalues: Parent (copy)
				Parent.race(Parent.new(function() -- line: 1152
				end))
			end)

			expect(ok).to.be.ok()
			expect(result:find("Non%-promise")).to.be.ok()
		end)
		it("should cancel promises if it is cancelled", function() -- line: 1159
			-- upvalues: Parent (copy)
			local v193 = Parent.new(function() -- line: 1160
			end)

			v193:andThen(function() -- line: 1161
			end)

			local t9 = {
				Parent.new(function() -- line: 1164
				end),
				Parent.new(function() -- line: 1165
				end),
				v193
			}

			Parent.race(t9):cancel()
			expect(t9[1]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t9[2]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t9[3]:getStatus()).to.equal(Parent.Status.Started)
		end)
	end)
	describe("Promise.promisify", function() -- line: 1177
		-- upvalues: Parent (copy)
		it("should wrap functions", function() -- line: 1178
			-- upvalues: Parent (copy)
			local v195 = Parent.promisify(function(p75) --[[ test ]] -- line: 1179
				return p75 + 1
			end)(1)
			local v196, v197 = v195:_unwrap()

			expect(v196).to.equal(true)
			expect(v195:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v197).to.equal(2)
		end)
		it("should catch errors after a yield", function() -- line: 1192
			-- upvalues: Parent (copy)
			local BindableEvent5 = Instance.new("BindableEvent")
			local v199 = Parent.promisify(function() -- line: 1194
				-- upvalues: BindableEvent5 (copy)
				BindableEvent5.Event:Wait()
				error("errortext")
			end)()

			expect(v199:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent5:Fire()
			expect(v199:getStatus()).to.equal(Parent.Status.Rejected)
			expect(tostring(v199._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise.tap", function() -- line: 1208
		-- upvalues: Parent (copy)
		it("should thread through values", function() -- line: 1209
			-- upvalues: Parent (copy)
			local u200 = nil
			local u201 = nil

			Parent.resolve(1):andThen(function(p76) -- line: 1213
				return p76 + 1
			end):tap(function(p77) -- line: 1216
				-- upvalues: u200 (ref)
				u200 = p77

				return p77 + 1
			end):andThen(function(p78) -- line: 1220
				-- upvalues: u201 (ref)
				u201 = p78
			end)
			expect(u200).to.equal(2)
			expect(u201).to.equal(2)
		end)
		it("should chain onto promises", function() -- line: 1228
			-- upvalues: Parent (copy)
			local u202 = nil
			local u203 = nil
			local v204 = Parent.resolve(1):tap(function() -- line: 1232
				-- upvalues: Parent (copy), u202 (ref)
				return Parent.new(function(p79) -- line: 1233
					-- upvalues: u202 (ref)
					u202 = p79
				end)
			end):andThen(function(p80) -- line: 1237
				-- upvalues: u203 (ref)
				u203 = p80
			end)

			expect(v204:getStatus()).to.equal(Parent.Status.Started)
			expect(u203).to.never.be.ok()
			u202(1)
			expect(v204:getStatus()).to.equal(Parent.Status.Resolved)
			expect(u203).to.equal(1)
		end)
	end)
	describe("Promise.try", function() -- line: 1251
		-- upvalues: Parent (copy)
		it("should catch synchronous errors", function() -- line: 1252
			-- upvalues: Parent (copy)
			local str = nil

			Parent.try(function() -- line: 1254
				error("errortext")
			end):catch(function(p81) -- line: 1256
				-- upvalues: str (ref)
				str = tostring(p81)
			end)
			expect(str:find("errortext")).to.be.ok()
		end)
		it("should reject with error objects", function() -- line: 1263
			-- upvalues: Parent (copy)
			local t10 = {}
			local v207, v208 = Parent.try(function() -- line: 1265
				-- upvalues: t10 (copy)
				error(t10)
			end):_unwrap()

			expect(v207).to.equal(false)
			expect(v208).to.equal(t10)
		end)
		it("should catch asynchronous errors", function() -- line: 1273
			-- upvalues: Parent (copy)
			local BindableEvent6 = Instance.new("BindableEvent")
			local v210 = Parent.try(function() -- line: 1275
				-- upvalues: BindableEvent6 (copy)
				BindableEvent6.Event:Wait()
				error("errortext")
			end)

			expect(v210:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent6:Fire()
			expect(v210:getStatus()).to.equal(Parent.Status.Rejected)
			expect(tostring(v210._values[1]):find("errortext")).to.be.ok()
		end)
	end)
	describe("Promise:andThenReturn", function() -- line: 1287
		-- upvalues: Parent (copy)
		it("should return the given values", function() -- line: 1288
			-- upvalues: Parent (copy)
			local u211 = nil
			local u212 = nil

			Parent.resolve():andThenReturn(1, 2):andThen(function(p82, p83) -- line: 1291
				-- upvalues: u211 (ref), u212 (ref)
				u211 = p82
				u212 = p83
			end)
			expect(u211).to.equal(1)
			expect(u212).to.equal(2)
		end)
	end)
	describe("Promise:andThenCall", function() -- line: 1301
		-- upvalues: Parent (copy)
		it("should call the given function with arguments", function() -- line: 1302
			-- upvalues: Parent (copy)
			local u213 = nil
			local u214 = nil

			Parent.resolve():andThenCall(function(p84, p85) -- line: 1304
				-- upvalues: u213 (ref), u214 (ref)
				u213 = p84
				u214 = p85
			end, 3, 4)
			expect(u213).to.equal(3)
			expect(u214).to.equal(4)
		end)
	end)
	describe("Promise.some", function() -- line: 1314
		-- upvalues: Parent (copy)
		it("should resolve once the goal is reached", function() -- line: 1315
			-- upvalues: Parent (copy)
			local v215 = Parent.some({
				Parent.resolve(1),
				Parent.reject(),
				Parent.resolve(2)
			}, 2)

			expect(v215:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v215._values[1][1]).to.equal(1)
			expect(v215._values[1][2]).to.equal(2)
		end)
		it("should error if the goal can't be reached", function() -- line: 1326
			-- upvalues: Parent (copy)
			expect(Parent.some({
				Parent.resolve(),
				Parent.reject()
			}, 2):getStatus()).to.equal(Parent.Status.Rejected)

			local u216 = nil
			local v217 = Parent.some({
				Parent.resolve(),
				Parent.new(function(_, p87) -- line: 1335
					-- upvalues: u216 (ref)
					u216 = p87
				end)
			}, 2)

			expect(v217:getStatus()).to.equal(Parent.Status.Started)
			u216("foo")
			expect(v217:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v217._values[1]).to.equal("foo")
		end)
		it("should cancel pending Promises once the goal is reached", function() -- line: 1346
			-- upvalues: Parent (copy)
			local u218 = nil
			local v219 = Parent.new(function() -- line: 1348
			end)
			local v220 = Parent.new(function(p88) -- line: 1349
				-- upvalues: u218 (ref)
				u218 = p88
			end)
			local v221 = Parent.some({
				v219,
				v220,
				Parent.resolve()
			}, 2)

			expect(v221:getStatus()).to.equal(Parent.Status.Started)
			expect(v219:getStatus()).to.equal(Parent.Status.Started)
			expect(v220:getStatus()).to.equal(Parent.Status.Started)
			u218()
			expect(v221:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v219:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(v220:getStatus()).to.equal(Parent.Status.Resolved)
		end)
		it("should error if passed a non-number", function() -- line: 1370
			-- upvalues: Parent (copy)
			expect(function() -- line: 1371
				-- upvalues: Parent (copy)
				Parent.some({}, "non-number")
			end).to.throw()
		end)
		it("should return an empty array if amount is 0", function() -- line: 1376
			-- upvalues: Parent (copy)
			local v222 = Parent.some({ Parent.resolve(2) }, 0)

			expect(v222:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v222._values[1]).to.equal(0)
		end)
		it("should not return extra values", function() -- line: 1385
			-- upvalues: Parent (copy)
			local v223 = Parent.some({
				Parent.resolve(1),
				Parent.resolve(2),
				Parent.resolve(3),
				Parent.resolve(4)
			}, 2)

			expect(v223:getStatus()).to.equal(Parent.Status.Resolved)
			expect(#v223._values[1]).to.equal(2)
			expect(v223._values[1][1]).to.equal(1)
			expect(v223._values[1][2]).to.equal(2)
		end)
		it("should cancel promises if it is cancelled", function() -- line: 1399
			-- upvalues: Parent (copy)
			local v224 = Parent.new(function() -- line: 1400
			end)

			v224:andThen(function() -- line: 1401
			end)

			local t11 = {
				Parent.new(function() -- line: 1404
				end),
				Parent.new(function() -- line: 1405
				end),
				v224
			}

			Parent.some(t11, 3):cancel()
			expect(t11[1]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t11[2]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t11[3]:getStatus()).to.equal(Parent.Status.Started)
		end)
		describe("Promise.any", function() -- line: 1416
			-- upvalues: Parent (copy)
			it("should return the value directly", function() -- line: 1417
				-- upvalues: Parent (copy)
				local v367 = Parent.any({
					Parent.reject(),
					Parent.reject(),
					Parent.resolve(1)
				})

				expect(v367:getStatus()).to.equal(Parent.Status.Resolved)
				expect(v367._values[1]).to.equal(1)
			end)
			it("should error if all are rejected", function() -- line: 1428
				-- upvalues: Parent (copy)
				expect(Parent.any({
					Parent.reject(),
					Parent.reject(),
					Parent.reject()
				}):getStatus()).to.equal(Parent.Status.Rejected)
			end)
		end)
	end)
	describe("Promise.allSettled", function() -- line: 1438
		-- upvalues: Parent (copy)
		it("should resolve with an array of PromiseStatuses", function() -- line: 1439
			-- upvalues: Parent (copy)
			local u226 = nil
			local v227 = Parent.allSettled({
				Parent.resolve(),
				Parent.reject(),
				Parent.resolve(),
				Parent.new(function(_, p90) -- line: 1445
					-- upvalues: u226 (ref)
					u226 = p90
				end)
			})

			expect(v227:getStatus()).to.equal(Parent.Status.Started)
			u226()
			expect(v227:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v227._values[1][1]).to.equal(Parent.Status.Resolved)
			expect(v227._values[1][2]).to.equal(Parent.Status.Rejected)
			expect(v227._values[1][3]).to.equal(Parent.Status.Resolved)
			expect(v227._values[1][4]).to.equal(Parent.Status.Rejected)
		end)
		it("should cancel promises if it is cancelled", function() -- line: 1459
			-- upvalues: Parent (copy)
			local v228 = Parent.new(function() -- line: 1460
			end)

			v228:andThen(function() -- line: 1461
			end)

			local t12 = {
				Parent.new(function() -- line: 1464
				end),
				Parent.new(function() -- line: 1465
				end),
				v228
			}

			Parent.allSettled(t12):cancel()
			expect(t12[1]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t12[2]:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t12[3]:getStatus()).to.equal(Parent.Status.Started)
		end)
	end)
	describe("Promise:await", function() -- line: 1477
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should return the correct values", function() -- line: 1478
			-- upvalues: Parent (copy)
			local v230, v231, v232, v233, v234 = Parent.resolve(5, 6, nil, 7):await()

			expect(v230).to.equal(true)
			expect(v231).to.equal(5)
			expect(v232).to.equal(6)
			expect(v233).to.equal(nil)
			expect(v234).to.equal(7)
		end)
		it("should work if yielding is needed", function() -- line: 1490
			-- upvalues: Parent (copy), advanceTime (ref)
			local u235 = false

			task.spawn(function() -- line: 1492
				-- upvalues: Parent (copy), u235 (ref)
				local _, v371 = Parent.delay(1):await()

				expect((type(v371))).to.equal("number")
				u235 = true
			end)
			advanceTime(2)
			expect(u235).to.equal(true)
		end)
	end)
	describe("Promise:expect", function() -- line: 1503
		-- upvalues: Parent (copy)
		it("should throw the correct values", function() -- line: 1504
			-- upvalues: Parent (copy)
			local t13 = {}
			local v237 = Parent.reject(t13)
			local ok, result = pcall(function() -- line: 1508
				-- upvalues: v237 (copy)
				v237:expect()
			end)

			expect(ok).to.equal(false)
			expect(result).to.equal(t13)
		end)
	end)
	describe("Promise:now", function() -- line: 1517
		-- upvalues: Parent (copy)
		it("should resolve if the Promise is resolved", function() -- line: 1518
			-- upvalues: Parent (copy)
			local v240, v241 = Parent.resolve("foo"):now():_unwrap()

			expect(v240).to.equal(true)
			expect(v241).to.equal("foo")
		end)
		it("should reject if the Promise is not resolved", function() -- line: 1525
			-- upvalues: Parent (copy)
			local v242, v243 = Parent.new(function() -- line: 1526
			end):now():_unwrap()

			expect(v242).to.equal(false)
			expect(Parent.Error.isKind(v243, "NotResolvedInTime")).to.equal(true)
		end)
		it("should reject with a custom rejection value", function() -- line: 1532
			-- upvalues: Parent (copy)
			local v244, v245 = Parent.new(function() -- line: 1533
			end):now("foo"):_unwrap()

			expect(v244).to.equal(false)
			expect(v245).to.equal("foo")
		end)
	end)
	describe("Promise.each", function() -- line: 1540
		-- upvalues: Parent (copy)
		it("should iterate", function() -- line: 1541
			-- upvalues: Parent (copy)
			local v246, v247 = Parent.each({
				"foo",
				"bar",
				"baz",
				"qux"
			}, function(...) -- line: 1547
				return { ... }
			end):_unwrap()

			expect(v246).to.equal(true)
			expect(v247[1][1]).to.equal("foo")
			expect(v247[1][2]).to.equal(1)
			expect(v247[2][1]).to.equal("bar")
			expect(v247[2][2]).to.equal(2)
			expect(v247[3][1]).to.equal("baz")
			expect(v247[3][2]).to.equal(3)
			expect(v247[4][1]).to.equal("qux")
			expect(v247[4][2]).to.equal(4)
		end)
		it("should iterate serially", function() -- line: 1562
			-- upvalues: Parent (copy)
			local t14 = {}
			local t15 = {}
			local v250 = Parent.each({
				"foo",
				"bar",
				"baz"
			}, function(p91, p92) -- line: 1570
				-- upvalues: t15 (copy), Parent (copy), t14 (copy)
				t15[p92] = (t15[p92] or 0) + 1

				return Parent.new(function(p93) -- line: 1573
					-- upvalues: t14 (copy), p91 (copy)
					table.insert(t14, function() -- line: 1574
						-- upvalues: p93 (copy), p91 (copy)
						p93(p91:upper())
					end)
				end)
			end)

			expect(v250:getStatus()).to.equal(Parent.Status.Started)
			expect(#t14).to.equal(1)
			expect(t15[1]).to.equal(1)
			expect(t15[2]).to.never.be.ok()
			table.remove(t14, 1)()
			expect(v250:getStatus()).to.equal(Parent.Status.Started)
			expect(#t14).to.equal(1)
			expect(t15[1]).to.equal(1)
			expect(t15[2]).to.equal(1)
			expect(t15[3]).to.never.be.ok()
			table.remove(t14, 1)()
			expect(v250:getStatus()).to.equal(Parent.Status.Started)
			expect(t15[1]).to.equal(1)
			expect(t15[2]).to.equal(1)
			expect(t15[3]).to.equal(1)
			table.remove(t14, 1)()
			expect(v250:getStatus()).to.equal(Parent.Status.Resolved)
			expect((type(v250._values[1]))).to.equal("table")
			expect((type(v250._values[2]))).to.equal("nil")

			local v251 = v250._values[1]

			expect(v251[1]).to.equal("FOO")
			expect(v251[2]).to.equal("BAR")
			expect(v251[3]).to.equal("BAZ")
		end)
		it("should reject with the value if the predicate promise rejects", function() -- line: 1613
			-- upvalues: Parent (copy)
			local v252 = Parent.each({
				1,
				2,
				3
			}, function() -- line: 1614
				-- upvalues: Parent (copy)
				return Parent.reject("foobar")
			end)

			expect(v252:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v252._values[1]).to.equal("foobar")
		end)
		it("should allow Promises to be in the list and wait when it gets to them", function() -- line: 1622
			-- upvalues: Parent (copy)
			local u253 = nil
			local v254 = Parent.new(function(p94) -- line: 1624
				-- upvalues: u253 (ref)
				u253 = p94
			end)
			local v255 = Parent.each({ v254 }, function(p95) -- line: 1630
				return p95 * 2
			end)

			expect(v255:getStatus()).to.equal(Parent.Status.Started)
			u253(2)
			expect(v255:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v255._values[1][1]).to.equal(4)
		end)
		it("should reject with the value if a Promise from the list rejects", function() -- line: 1642
			-- upvalues: Parent (copy)
			local u256 = false
			local v257 = Parent.each({
				1,
				2,
				Parent.reject("foobar")
			}, function(_) -- line: 1644
				-- upvalues: u256 (ref)
				u256 = true

				return "never"
			end)

			expect(v257:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v257._values[1]).to.equal("foobar")
			expect(u256).to.equal(false)
		end)
		it("should reject immediately if there's a cancelled Promise in the list initially", function() -- line: 1654
			-- upvalues: Parent (copy)
			local v258 = Parent.new(function() -- line: 1655
			end)

			v258:cancel()

			local u259 = false
			local v260 = Parent.each({
				1,
				2,
				v258
			}, function() -- line: 1659
				-- upvalues: u259 (ref)
				u259 = true
			end)

			expect(v260:getStatus()).to.equal(Parent.Status.Rejected)
			expect(u259).to.equal(false)
			expect(v260._values[1].kind).to.equal(Parent.Error.Kind.AlreadyCancelled)
		end)
		it("should stop iteration if Promise.each is cancelled", function() -- line: 1668
			-- upvalues: Parent (copy)
			local t16 = {}
			local v262 = Parent.each({
				"foo",
				"bar",
				"baz"
			}, function(_, p98) -- line: 1675
				-- upvalues: t16 (copy), Parent (copy)
				t16[p98] = (t16[p98] or 0) + 1

				return Parent.new(function() -- line: 1678
				end)
			end)

			expect(v262:getStatus()).to.equal(Parent.Status.Started)
			expect(t16[1]).to.equal(1)
			expect(t16[2]).to.never.be.ok()
			v262:cancel()
			expect(v262:getStatus()).to.equal(Parent.Status.Cancelled)
			expect(t16[1]).to.equal(1)
			expect(t16[2]).to.never.be.ok()
		end)
		it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function() -- line: 1692
			-- upvalues: Parent (copy)
			local u263 = nil

			Parent.each({
				"foo",
				"bar",
				"baz"
			}, function(_, _) -- line: 1699
				-- upvalues: u263 (ref), Parent (copy)
				u263 = Parent.new(function() -- line: 1700
				end)

				return u263
			end):cancel()
			expect(u263:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
		it("should cancel Promises in the list if Promise.each is cancelled", function() -- line: 1709
			-- upvalues: Parent (copy)
			local v264 = Parent.new(function() -- line: 1710
			end)

			Parent.each({ v264 }, function() -- line: 1712
			end):cancel()
			expect(v264:getStatus()).to.equal(Parent.Status.Cancelled)
		end)
	end)
	describe("Promise.retry", function() -- line: 1720
		-- upvalues: Parent (copy)
		it("should retry N times", function() -- line: 1721
			-- upvalues: Parent (copy)
			local n24 = 0
			local v266 = Parent.retry(function(p101) -- line: 1724
				-- upvalues: n24 (ref), Parent (copy)
				expect(p101).to.equal("foo")
				n24 += 1

				if n24 == 5 then
					return Parent.resolve("ok")
				end

				return Parent.reject("fail")
			end, 5, "foo")

			expect(v266:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v266._values[1]).to.equal("ok")
		end)
		it("should reject if threshold is exceeded", function() -- line: 1740
			-- upvalues: Parent (copy)
			local v267 = Parent.retry(function() -- line: 1741
				-- upvalues: Parent (copy)
				return Parent.reject("fail")
			end, 5)

			expect(v267:getStatus()).to.equal(Parent.Status.Rejected)
			expect(v267._values[1]).to.equal("fail")
		end)
	end)
	describe("Promise.retryWithDelay", function() -- line: 1750
		-- upvalues: Parent (copy), advanceTime (ref)
		it("should retry after a delay", function() -- line: 1751
			-- upvalues: Parent (copy), advanceTime (ref)
			local n25 = 0
			local v269 = Parent.retryWithDelay(function(p102) -- line: 1754
				-- upvalues: n25 (ref), Parent (copy)
				expect(p102).to.equal("foo")
				n25 += 1

				if n25 == 3 then
					return Parent.resolve("ok")
				end

				return Parent.reject("fail")
			end, 3, 10, "foo")

			expect(n25).to.equal(1)
			advanceTime(11)
			expect(n25).to.equal(2)
			advanceTime(11)
			expect(n25).to.equal(3)
			expect(v269:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v269._values[1]).to.equal("ok")
		end)
	end)
	describe("Promise.fromEvent", function() -- line: 1781
		-- upvalues: Parent (copy)
		it("should convert a Promise into an event", function() -- line: 1782
			-- upvalues: Parent (copy)
			local BindableEvent7 = Instance.new("BindableEvent")
			local v271 = Parent.fromEvent(BindableEvent7.Event)

			expect(v271:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent7:Fire("foo")
			expect(v271:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v271._values[1]).to.equal("foo")
		end)
		it("should convert a Promise into an event with the predicate", function() -- line: 1795
			-- upvalues: Parent (copy)
			local BindableEvent8 = Instance.new("BindableEvent")
			local v273 = Parent.fromEvent(BindableEvent8.Event, function(p103) -- line: 1798
				return p103 == "foo"
			end)

			expect(v273:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent8:Fire("bar")
			expect(v273:getStatus()).to.equal(Parent.Status.Started)
			BindableEvent8:Fire("foo")
			expect(v273:getStatus()).to.equal(Parent.Status.Resolved)
			expect(v273._values[1]).to.equal("foo")
		end)
	end)
	describe("Promise.is", function() -- line: 1815
		-- upvalues: Parent (copy)
		it("should work with current version", function() -- line: 1816
			-- upvalues: Parent (copy)
			local v274 = Parent.resolve(1)

			expect(Parent.is(v274)).to.equal(true)
		end)
		it("should work with any object with an andThen", function() -- line: 1822
			-- upvalues: Parent (copy)
			local t17 = {
				andThen = function() --[[ andThen ]] -- line: 1824
					return 1
				end
			}

			expect(Parent.is(t17)).to.equal(true)
		end)
		it("should work with older promises", function() -- line: 1832
			-- upvalues: Parent (copy)
			local t18 = {
				prototype = {}
			}

			t18.__index = t18.prototype

			function t18.prototype.andThen(_) -- line: 1837
			end

			local v277 = setmetatable({}, t18)

			expect(Parent.is(v277)).to.equal(true)
		end)
	end)
end
