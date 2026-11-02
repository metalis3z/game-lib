-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	local function Awaiter(p1) --[[ Awaiter | Line: 4 ]]
		local t = {}
		local v1 = nil
		local v2 = nil

		function t.Resume(...) --[[ Resume | Line: 8 | Upvalues: v2 (ref), v1 (ref) ]]
			if coroutine.running() ~= v2 then
				task.cancel(v2)
			end

			task.spawn(v1, ...)
		end
		function t.Yield() --[[ Yield | Line: 14 | Upvalues: v1 (ref), v2 (ref), p1 (copy), t (copy) ]]
			v1 = coroutine.running()
			v2 = task.delay(p1, function() --[[ Line: 16 | Upvalues: t (ref) ]]
				t.Resume()
			end)

			return coroutine.yield()
		end

		return t
	end

	local v2 = nil

	beforeEach(function() --[[ Line: 25 | Upvalues: v2 (ref) ]]
		v2 = Instance.new("BindableEvent")
	end)
	afterEach(function() --[[ Line: 28 | Upvalues: v2 (ref) ]]
		v2:Destroy()
		v2 = nil
	end)
	describe("Single", function() --[[ Line: 33 | Upvalues: v1 (copy), Awaiter (copy), v2 (ref) ]]
		it("should spawn a new concur instance", function() --[[ Line: 34 | Upvalues: v1 (ref) ]]
			local v12 = nil

			expect(function() --[[ Line: 36 | Upvalues: v1 (ref), v12 (ref) ]]
				v1.spawn(function() --[[ Line: 37 | Upvalues: v12 (ref) ]]
					v12 = 10
				end)
			end).to.never.throw()
			expect(v12).to.equal(10)
		end)
		it("should defer a new concur instance", function() --[[ Line: 44 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(1)

			expect(function() --[[ Line: 46 | Upvalues: v1 (ref), v12 (copy) ]]
				v1.defer(function() --[[ Line: 47 | Upvalues: v12 (ref) ]]
					v12.Resume(10)
				end)
			end).to.never.throw()
			expect((v12.Yield())).to.equal(10)
		end)
		it("should delay a new concur instance", function() --[[ Line: 55 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(1)

			expect(function() --[[ Line: 57 | Upvalues: v1 (ref), v12 (copy) ]]
				v1.delay(0.1, function() --[[ Line: 58 | Upvalues: v12 (ref) ]]
					v12.Resume(10)
				end)
			end).to.never.throw()
			expect((v12.Yield())).to.equal(10)
		end)
		it("should create an immediate value concur instance", function() --[[ Line: 66 | Upvalues: v1 (ref) ]]
			local v12 = nil

			expect(function() --[[ Line: 68 | Upvalues: v12 (ref), v1 (ref) ]]
				v12 = v1.value(10)
			end).to.never.throw()
			expect(v12).to.be.ok()
			expect(v12:IsCompleted()).to.equal(true)

			local v2, v3 = v12:Await()

			expect(v2).to.never.be.ok()
			expect(v3).to.equal(10)
		end)
		it("should create a concur instance to watch an event with no predicate", function() --[[ Line: 78 | Upvalues: v1 (ref), v2 (ref) ]]
			local v12 = nil

			expect(function() --[[ Line: 80 | Upvalues: v12 (ref), v1 (ref), v2 (ref) ]]
				v12 = v1.event(v2.Event)
			end).to.never.throw()
			expect(v12:IsCompleted()).to.equal(false)
			v2:Fire(10)

			local v22, v3 = v12:Await(1)

			expect(v22).to.never.be.ok()
			expect(v3).to.equal(10)
		end)
		it("should create a concur instance to watch an event with a predicate", function() --[[ Line: 90 | Upvalues: v1 (ref), v2 (ref) ]]
			local v12 = nil

			expect(function() --[[ Line: 92 | Upvalues: v12 (ref), v1 (ref), v2 (ref) ]]
				v12 = v1.event(v2.Event, function(p1) --[[ Line: 93 ]]
					return p1 < 10
				end)
			end).to.never.throw()
			expect(v12:IsCompleted()).to.equal(false)
			v2:Fire(10)
			v2:Fire(5)

			local v22, v3 = v12:Await(1)

			expect(v22).to.never.be.ok()
			expect(v3).to.equal(5)
		end)
	end)
	describe("Multi", function() --[[ Line: 106 | Upvalues: v1 (copy), v2 (ref) ]]
		it("should complete all concur instances", function() --[[ Line: 107 | Upvalues: v1 (ref), v2 (ref) ]]
			local v12 = v1.all({
				v1.spawn(function() --[[ Line: 108 ]]
					return 10
				end),
				v1.defer(function() --[[ Line: 111 ]]
					return 20
				end),
				v1.delay(0, function() --[[ Line: 114 ]]
					return 30
				end),
				v1.spawn(function() --[[ Line: 117 ]]
					error("fail")
				end),
				(v1.event(v2.Event))
			})

			expect(v12:IsCompleted()).to.equal(false)
			v2:Fire(40)

			local v22, v3 = v12:Await(1)

			expect(v22).to.never.be.ok()
			expect(v3[1][1]).to.never.be.ok()
			expect(v3[1][2]).to.equal(10)
			expect(v3[2][1]).to.never.be.ok()
			expect(v3[2][2]).to.equal(20)
			expect(v3[3][1]).to.never.be.ok()
			expect(v3[3][2]).to.equal(30)
			expect(v3[4][1]).to.be.ok()
			expect(v3[4][2]).to.never.be.ok()
			expect(v3[5][1]).to.never.be.ok()
			expect(v3[5][2]).to.equal(40)
		end)
		it("should complete the first concur instance", function() --[[ Line: 138 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.first({ v1.defer(function() --[[ Line: 139 ]]
					return 10
				end), (v1.spawn(function() --[[ Line: 142 ]]
					return 20
				end)) }):Await(1)

			expect(v12).to.never.be.ok()
			expect(v2).to.equal(20)
		end)
	end)
	describe("Stop", function() --[[ Line: 152 | Upvalues: v1 (copy), v2 (ref) ]]
		it("should stop a single concur", function() --[[ Line: 153 | Upvalues: v1 (ref) ]]
			local v12 = v1.defer(function() --[[ Line: 154 ]]
				return 10
			end)

			expect(v12:IsCompleted()).to.equal(false)
			v12:Stop()
			expect(v12:IsCompleted()).to.equal(true)

			local v2, v3 = v12:Await()

			expect(v2).to.equal(v1.Errors.Stopped)
			expect(v3).to.never.be.ok()
		end)
		it("should stop multiple concurs", function() --[[ Line: 165 | Upvalues: v1 (ref), v2 (ref) ]]
			local v12 = v1.all({ v1.defer(function() --[[ Line: 166 ]] end), v1.delay(1, function() --[[ Line: 167 ]] end), (v1.event(v2.Event)) })

			v12:Stop()

			local v22, v3 = v12:Await()

			expect(v22).to.equal(v1.Errors.Stopped)
			expect(v3).to.never.be.ok()
		end)
		it("should not stop an already completed concur", function() --[[ Line: 176 | Upvalues: v1 (ref) ]]
			local v12 = v1.spawn(function() --[[ Line: 177 ]]
				return 10
			end)

			expect(v12:IsCompleted()).to.equal(true)
			v12:Stop()

			local v2, v3 = v12:Await()

			expect(v2).to.never.be.ok()
			expect(v3).to.equal(10)
		end)
	end)
	describe("IsCompleted", function() --[[ Line: 188 | Upvalues: v1 (copy) ]]
		it("should correctly check if a concur instance is completed", function() --[[ Line: 189 | Upvalues: v1 (ref) ]]
			local v12 = v1.defer(function() --[[ Line: 190 ]] end)

			expect(v12:IsCompleted()).to.equal(false)
			expect((v12:Await())).to.never.be.ok()
			expect(v12:IsCompleted()).to.equal(true)
		end)
		it("should be marked as completed if error", function() --[[ Line: 197 | Upvalues: v1 (ref) ]]
			expect(v1.spawn(function() --[[ Line: 198 ]]
				error("err")
			end):IsCompleted()).to.equal(true)
		end)
		it("should be marked as completed if stopped", function() --[[ Line: 204 | Upvalues: v1 (ref) ]]
			local v12 = v1.defer(function() --[[ Line: 205 ]] end)

			v12:Stop()
			expect(v12:IsCompleted()).to.equal(true)
		end)
	end)
	describe("Await", function() --[[ Line: 211 | Upvalues: v1 (copy) ]]
		it("should await concur to be completed", function() --[[ Line: 212 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.defer(function() --[[ Line: 213 ]]
				return 10
			end):Await(1)

			expect(v12).to.never.be.ok()
			expect(v2).to.equal(10)
		end)
		it("should await concur to be completed even if error", function() --[[ Line: 221 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.defer(function() --[[ Line: 222 ]]
				return error("err")
			end):Await(1)

			expect(v12).to.be.ok()
			expect(v2).to.never.be.ok()
		end)
		it("should await concur to be completed even if stopped", function() --[[ Line: 230 | Upvalues: v1 (ref) ]]
			local v12 = v1.delay(0.1, function() --[[ Line: 231 ]]
				return 10
			end)

			task.defer(function() --[[ Line: 234 | Upvalues: v12 (copy) ]]
				v12:Stop()
			end)

			local v2, v3 = v12:Await(1)

			expect(v2).to.equal(v1.Errors.Stopped)
			expect(v3).to.never.be.ok()
		end)
		it("should return completed values immediately if already completed", function() --[[ Line: 242 | Upvalues: v1 (ref) ]]
			local v12 = v1.spawn(function() --[[ Line: 243 ]]
				return 10
			end)

			expect(v12:IsCompleted()).to.equal(true)

			local v2, v3 = v12:Await()

			expect(v2).to.never.be.ok()
			expect(v3).to.equal(10)
		end)
		it("should timeout", function() --[[ Line: 252 | Upvalues: v1 (ref) ]]
			local v12 = v1.delay(0.2, function() --[[ Line: 253 ]]
				return 10
			end)
			local v2, v3 = v12:Await(0.1)

			expect(v2).to.equal(v1.Errors.Timeout)
			expect(v3).to.never.be.ok()

			local v4, v5 = v12:Await()

			expect(v4).to.never.be.ok()
			expect(v5).to.equal(10)
		end)
	end)
	describe("OnCompleted", function() --[[ Line: 265 | Upvalues: Awaiter (copy), v1 (copy) ]]
		it("should fire function once completed", function() --[[ Line: 266 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(0.1)
			local v2 = v1.defer(function() --[[ Line: 268 ]]
				return 10
			end)

			expect(v2:IsCompleted()).to.equal(false)
			v2:OnCompleted(function(p1, p2) --[[ Line: 272 | Upvalues: v12 (copy) ]]
				v12.Resume(p1, p2)
			end)

			local v3, v4 = v12.Yield()

			expect(v3).to.never.be.ok()
			expect(v4).to.equal(10)
		end)
		it("should fire function even if already completed", function() --[[ Line: 280 | Upvalues: v1 (ref) ]]
			local v12 = v1.spawn(function() --[[ Line: 281 ]]
				return 10
			end)

			expect(v12:IsCompleted()).to.equal(true)

			local v2 = nil
			local v3 = nil

			v12:OnCompleted(function(p1, p2) --[[ Line: 286 | Upvalues: v2 (ref), v3 (ref) ]]
				v2 = p1
				v3 = p2
			end)
			expect(v2).to.never.be.ok()
			expect(v3).to.equal(10)
		end)
		it("should fire function even if error", function() --[[ Line: 293 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(0.1)

			v1.defer(function() --[[ Line: 295 ]]
				error("err")
			end):OnCompleted(function(p1, p2) --[[ Line: 298 | Upvalues: v12 (copy) ]]
				v12.Resume(p1, p2)
			end)

			local v2, v3 = v12.Yield()

			expect(v2).to.be.ok()
			expect(v3).to.never.be.ok()
		end)
		it("should fire function even if stopped", function() --[[ Line: 306 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(0.2)
			local v2 = v1.delay(0.1, function() --[[ Line: 308 ]]
				error("err")
			end)

			v2:OnCompleted(function(p1, p2) --[[ Line: 311 | Upvalues: v12 (copy) ]]
				v12.Resume(p1, p2)
			end)
			task.defer(function() --[[ Line: 314 | Upvalues: v2 (copy) ]]
				v2:Stop()
			end)

			local v3, v4 = v12.Yield()

			expect(v3).to.equal(v1.Errors.Stopped)
			expect(v4).to.never.be.ok()
		end)
		it("should fire function even if timeout", function() --[[ Line: 322 | Upvalues: Awaiter (ref), v1 (ref) ]]
			local v12 = Awaiter(0.5)

			v1.delay(0.2, function() --[[ Line: 324 ]]
				error("err")
			end):OnCompleted(function(p1, p2) --[[ Line: 327 | Upvalues: v12 (copy) ]]
				v12.Resume(p1, p2)
			end, 0.1)

			local v2, v3 = v12.Yield()

			expect(v2).to.equal(v1.Errors.Timeout)
			expect(v3).to.never.be.ok()
		end)
		it("should unbind function", function() --[[ Line: 335 | Upvalues: v1 (ref) ]]
			local v12 = v1.defer(function() --[[ Line: 336 ]] end)
			local v2 = nil

			v12:OnCompleted(function() --[[ Line: 338 | Upvalues: v2 (ref) ]]
				v2 = 10
			end)()
			expect((v12:Await())).to.never.be.ok()
			task.wait()
			expect(v2).to.never.be.ok()
		end)
	end)
end