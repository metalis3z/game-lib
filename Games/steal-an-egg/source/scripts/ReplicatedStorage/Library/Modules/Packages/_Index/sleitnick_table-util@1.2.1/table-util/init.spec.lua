-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = require(script.Parent)

	describe("Copy (Deep)", function() --[[ Line: 4 | Upvalues: v1 (copy) ]]
		it("should create a deep table copy", function() --[[ Line: 5 | Upvalues: v1 (ref) ]]
			local t = {
				a = {
					b = {
						c = {
							d = 32
						}
					}
				}
			}
			local v12 = v1.Copy(t, true)

			expect(t).never.to.equal(v12)
			expect(t.a).never.to.equal(v12.a)
			expect(v12.a.b.c.d).to.equal(t.a.b.c.d)
		end)
	end)
	describe("Copy (Shallow)", function() --[[ Line: 14 | Upvalues: v1 (copy) ]]
		it("should create a shallow dictionary copy", function() --[[ Line: 15 | Upvalues: v1 (ref) ]]
			local t = {
				a = {
					b = {
						c = {
							d = 32
						}
					}
				}
			}
			local v12 = v1.Copy(t)

			expect(v12).never.to.equal(t)
			expect(v12.a).to.equal(t.a)
			expect(v12.a.b.c.d).to.equal(t.a.b.c.d)
		end)
		it("should create a shallow array copy", function() --[[ Line: 23 | Upvalues: v1 (ref) ]]
			local list = { 10, 20, 30, 40 }
			local v12 = v1.Copy(list)

			expect(v12).never.to.equal(list)

			for i, v in ipairs(list) do
				expect(v12[i]).to.equal(v)
			end
		end)
	end)
	describe("Sync", function() --[[ Line: 33 | Upvalues: v1 (copy) ]]
		it("should sync tables", function() --[[ Line: 34 | Upvalues: v1 (ref) ]]
			local t = {
				a = 32,
				b = 64,
				c = 128,
				e = {
					h = 1
				}
			}
			local v12 = v1.Sync({
				a = 32,
				b = 10,
				d = 1,
				e = {
					h = 2,
					n = 2
				},
				f = {
					x = 10
				}
			}, t)

			expect(v12.a).to.equal(t.a)
			expect(v12.b).to.equal(10)
			expect(v12.c).to.equal(t.c)
			expect(v12.d).never.to.be.ok()
			expect(v12.e.h).to.equal(2)
			expect(v12.e.n).never.to.be.ok()
			expect(v12.f).never.to.be.ok()
		end)
	end)
	describe("Reconcile", function() --[[ Line: 48 | Upvalues: v1 (copy) ]]
		it("should reconcile table", function() --[[ Line: 49 | Upvalues: v1 (ref) ]]
			local t = {
				kills = 0,
				deaths = 0,
				xp = 10,
				stuff2 = "abc",
				stuff = {},
				stuff3 = { "data" }
			}
			local t2 = {
				kills = 10,
				deaths = 4,
				extra = 5,
				stuff3 = true,
				stuff = { "abc", "xyz" },
				stuff2 = {
					abc = 10
				}
			}
			local v12 = v1.Reconcile(t2, t)

			expect(v12).never.to.equal(t2)
			expect(v12).never.to.equal(t)
			expect(v12.kills).to.equal(10)
			expect(v12.deaths).to.equal(4)
			expect(v12.xp).to.equal(10)
			expect(v12.stuff[1]).to.equal("abc")
			expect(v12.stuff[2]).to.equal("xyz")
			expect(v12.extra).to.equal(5)

			local v2 = expect

			v2((type(v12.stuff2))).to.equal("table")
			expect(v12.stuff2).never.to.equal(t2.stuff2)
			expect(v12.stuff2.abc).to.equal(10)

			local v3 = expect

			v3((type(v12.stuff3))).to.equal("boolean")
			expect(v12.stuff3).to.equal(true)
		end)
	end)
	describe("SwapRemove", function() --[[ Line: 70 | Upvalues: v1 (copy) ]]
		it("should swap remove index", function() --[[ Line: 71 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }

			v1.SwapRemove(t, 3)
			expect(#t).to.equal(4)
			expect(t[3]).to.equal(5)
		end)
	end)
	describe("SwapRemoveFirstValue", function() --[[ Line: 79 | Upvalues: v1 (copy) ]]
		it("should swap remove first value given", function() --[[ Line: 80 | Upvalues: v1 (ref) ]]
			local t = { "hello", "world", "goodbye", "planet" }

			v1.SwapRemoveFirstValue(t, "world")
			expect(#t).to.equal(3)
			expect(t[2]).to.equal("planet")
		end)
	end)
	describe("Map", function() --[[ Line: 88 | Upvalues: v1 (copy) ]]
		it("should map table", function() --[[ Line: 89 | Upvalues: v1 (ref) ]]
			local v12 = v1.Map({
				{
					FirstName = "John",
					LastName = "Doe"
				},
				{
					FirstName = "Jane",
					LastName = "Smith"
				}
			}, function(p1) --[[ Line: 94 ]]
				return p1.FirstName .. " " .. p1.LastName
			end)

			expect(v12[1]).to.equal("John Doe")
			expect(v12[2]).to.equal("Jane Smith")
		end)
	end)
	describe("Filter", function() --[[ Line: 102 | Upvalues: v1 (copy) ]]
		it("should filter table", function() --[[ Line: 103 | Upvalues: v1 (ref) ]]
			local v12 = v1.Filter({
				10,
				20,
				30,
				40,
				50,
				60,
				70,
				80,
				90
			}, function(p1) --[[ Line: 105 ]]
				return if p1 >= 30 then p1 <= 60 else false
			end)

			expect(#v12).to.equal(4)
			expect(v12[1]).to.equal(30)
			expect(v12[#v12]).to.equal(60)
		end)
	end)
	describe("Reduce", function() --[[ Line: 114 | Upvalues: v1 (copy) ]]
		it("should reduce table with numbers", function() --[[ Line: 115 | Upvalues: v1 (ref) ]]
			expect((v1.Reduce({ 1, 2, 3, 4, 5 }, function(p1, p2) --[[ Line: 117 ]]
				return p1 + p2
			end))).to.equal(15)
		end)
		it("should reduce table", function() --[[ Line: 123 | Upvalues: v1 (ref) ]]
			expect((v1.Reduce({
				{
					Score = 10
				},
				{
					Score = 20
				},
				{
					Score = 30
				}
			}, function(p1, p2) --[[ Line: 125 ]]
				return p1 + p2.Score
			end, 0))).to.equal(60)
		end)
		it("should reduce table with initial value", function() --[[ Line: 131 | Upvalues: v1 (ref) ]]
			expect((v1.Reduce({
				{
					Score = 10
				},
				{
					Score = 20
				},
				{
					Score = 30
				}
			}, function(p1, p2) --[[ Line: 133 ]]
				return p1 + p2.Score
			end, 40))).to.equal(100)
		end)
		it("should reduce functions", function() --[[ Line: 139 | Upvalues: v1 (ref) ]]
			expect((v1.Reduce({ function(p1) --[[ Square | Line: 140 ]]
					return p1 * p1
				end, function(p1) --[[ Double | Line: 143 ]]
					return p1 * 2
				end }, function(p1, p2) --[[ Line: 146 ]]
				return function(p12) --[[ Line: 147 | Upvalues: p1 (copy), p2 (copy) ]]
					return p1(p2(p12))
				end
			end)(10))).to.equal(400)
		end)
	end)
	describe("Assign", function() --[[ Line: 156 | Upvalues: v1 (copy) ]]
		it("should assign tables", function() --[[ Line: 157 | Upvalues: v1 (ref) ]]
			local v12 = v1.Assign({
				a = 32,
				x = 100
			}, {
				b = 64,
				c = 128
			}, {
				a = 10,
				c = 100,
				d = 200
			})

			expect(v12.a).to.equal(10)
			expect(v12.b).to.equal(64)
			expect(v12.c).to.equal(100)
			expect(v12.d).to.equal(200)
			expect(v12.x).to.equal(100)
		end)
	end)
	describe("Extend", function() --[[ Line: 170 | Upvalues: v1 (copy) ]]
		it("should extend tables", function() --[[ Line: 171 | Upvalues: v1 (ref) ]]
			expect(table.concat((v1.Extend({ "a", "b", "c" }, { "d", "e", "f" })))).to.equal("abcdef")
		end)
	end)
	describe("Reverse", function() --[[ Line: 179 | Upvalues: v1 (copy) ]]
		it("should create a table in reverse", function() --[[ Line: 180 | Upvalues: v1 (ref) ]]
			expect(table.concat((v1.Reverse({ 1, 2, 3 })))).to.equal("321")
		end)
	end)
	describe("Shuffle", function() --[[ Line: 187 | Upvalues: v1 (copy) ]]
		it("should shuffle a table", function() --[[ Line: 188 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }

			expect(function() --[[ Line: 190 | Upvalues: v1 (ref), t (copy) ]]
				v1.Shuffle(t)
			end).never.to.throw()
		end)
	end)
	describe("Sample", function() --[[ Line: 196 | Upvalues: v1 (copy) ]]
		it("should sample a table", function() --[[ Line: 197 | Upvalues: v1 (ref) ]]
			expect(#v1.Sample({ 1, 2, 3, 4, 5 }, 3)).to.equal(3)
		end)
	end)
	describe("Flat", function() --[[ Line: 204 | Upvalues: v1 (copy) ]]
		it("should flatten table", function() --[[ Line: 205 | Upvalues: v1 (ref) ]]
			expect(table.concat((v1.Flat({
				1,
				2,
				3,
				{
					4,
					5,
					{ 6, 7 }
				}
			}, 3)))).to.equal("1234567")
		end)
	end)
	describe("FlatMap", function() --[[ Line: 212 | Upvalues: v1 (copy) ]]
		it("should map and flatten table", function() --[[ Line: 213 | Upvalues: v1 (ref) ]]
			expect(table.concat((v1.FlatMap({ 1, 2, 3, 4, 5, 6, 7 }, function(p1) --[[ Line: 215 ]]
				return { p1, p1 * 2 }
			end)))).to.equal("12243648510612714")
		end)
	end)
	describe("Keys", function() --[[ Line: 222 | Upvalues: v1 (copy) ]]
		it("should give all keys of table", function() --[[ Line: 223 | Upvalues: v1 (ref) ]]
			local v12 = v1.Keys({
				a = 1,
				b = 2,
				c = 3
			})

			expect(#v12).to.equal(3)
			expect(table.find(v12, "a")).to.be.ok()
			expect(table.find(v12, "b")).to.be.ok()
			expect(table.find(v12, "c")).to.be.ok()
		end)
	end)
	describe("Values", function() --[[ Line: 233 | Upvalues: v1 (copy) ]]
		it("should give all values of table", function() --[[ Line: 234 | Upvalues: v1 (ref) ]]
			local v12 = v1.Values({
				a = 1,
				b = 2,
				c = 3
			})

			expect(#v12).to.equal(3)
			expect(table.find(v12, 1)).to.be.ok()
			expect(table.find(v12, 2)).to.be.ok()
			expect(table.find(v12, 3)).to.be.ok()
		end)
	end)
	describe("Find", function() --[[ Line: 244 | Upvalues: v1 (copy) ]]
		it("should find item in array", function() --[[ Line: 245 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.Find({ 10, 20, 30 }, function(p1) --[[ Line: 247 ]]
				return p1 == 20
			end)

			expect(v12).to.be.ok()
			expect(v2).to.equal(2)
			expect(v12).to.equal(20)
		end)
		it("should find item in dictionary", function() --[[ Line: 255 | Upvalues: v1 (ref) ]]
			local v12, v2 = v1.Find({
				{
					Score = 10
				},
				{
					Score = 20
				},
				{
					Score = 30
				}
			}, function(p1) --[[ Line: 257 ]]
				return p1.Score == 20
			end)

			expect(v12).to.be.ok()
			expect(v2).to.equal(2)
			expect(v12.Score).to.equal(20)
		end)
	end)
	describe("Every", function() --[[ Line: 266 | Upvalues: v1 (copy) ]]
		it("should see every value is above 20", function() --[[ Line: 267 | Upvalues: v1 (ref) ]]
			expect((v1.Every({ 21, 40, 200 }, function(p1) --[[ Line: 269 ]]
				return p1 > 20
			end))).to.equal(true)
		end)
		it("should see every value is not above 20", function() --[[ Line: 275 | Upvalues: v1 (ref) ]]
			expect((v1.Every({ 20, 40, 200 }, function(p1) --[[ Line: 277 ]]
				return p1 > 20
			end))).never.to.equal(true)
		end)
	end)
	describe("Some", function() --[[ Line: 284 | Upvalues: v1 (copy) ]]
		it("should see some value is above 20", function() --[[ Line: 285 | Upvalues: v1 (ref) ]]
			expect((v1.Some({ 5, 40, 1 }, function(p1) --[[ Line: 287 ]]
				return p1 > 20
			end))).to.equal(true)
		end)
		it("should see some value is not above 20", function() --[[ Line: 293 | Upvalues: v1 (ref) ]]
			expect((v1.Some({ 5, 15, 1 }, function(p1) --[[ Line: 295 ]]
				return p1 > 20
			end))).never.to.equal(true)
		end)
	end)
	describe("Truncate", function() --[[ Line: 302 | Upvalues: v1 (copy) ]]
		it("should truncate an array", function() --[[ Line: 303 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }
			local v12 = v1.Truncate(t, 3)

			expect(#v12).to.equal(3)
			expect(v12[1]).to.equal(t[1])
			expect(v12[2]).to.equal(t[2])
			expect(v12[3]).to.equal(t[3])
		end)
		it("should truncate an array with out of bounds sizes", function() --[[ Line: 312 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }

			expect(function() --[[ Line: 314 | Upvalues: v1 (ref), t (copy) ]]
				v1.Truncate(t, -1)
			end).to.never.throw()
			expect(function() --[[ Line: 317 | Upvalues: v1 (ref), t (copy) ]]
				v1.Truncate(t, #t + 1)
			end).to.never.throw()

			local v12 = v1.Truncate(t, #t + 10)

			expect(#v12).to.equal(#t)
			expect(v12).to.never.equal(t)
		end)
	end)
	describe("Lock", function() --[[ Line: 326 | Upvalues: v1 (copy) ]]
		it("should lock a table", function() --[[ Line: 327 | Upvalues: v1 (ref) ]]
			local t = {
				abc = {
					xyz = {
						num = 32
					}
				}
			}

			expect(function() --[[ Line: 329 | Upvalues: t (copy) ]]
				t.abc.xyz.num = 64
			end).never.to.throw()

			local v12 = v1.Lock(t)

			expect(t.abc.xyz.num).to.equal(64)
			expect(t).to.equal(v12)
			expect(function() --[[ Line: 335 | Upvalues: t (copy) ]]
				t.abc.xyz.num = 10
			end).to.throw()
		end)
	end)
	describe("Zip", function() --[[ Line: 341 | Upvalues: v1 (copy) ]]
		it("should zip arrays together", function() --[[ Line: 342 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }
			local t2 = { 9, 8, 7, 6, 5 }
			local t3 = { 1, 1, 1, 1, 1 }
			local v12 = 0

			for v2, v3 in v1.Zip(t, t2, t3) do
				expect(v3[1]).to.equal(t[v2])
				expect(v3[2]).to.equal(t2[v2])
				expect(v3[3]).to.equal(t3[v2])
				v12 = v2
			end

			expect(v12).to.equal((math.min(#t, #t2, #t3)))
		end)
		it("should zip arrays of different lengths together", function() --[[ Line: 356 | Upvalues: v1 (ref) ]]
			local t = { 1, 2, 3, 4, 5 }
			local t2 = { 9, 8, 7, 6 }
			local t3 = { 1, 1, 1 }
			local v12 = 0

			for v2, v3 in v1.Zip(t, t2, t3) do
				expect(v3[1]).to.equal(t[v2])
				expect(v3[2]).to.equal(t2[v2])
				expect(v3[3]).to.equal(t3[v2])
				v12 = v2
			end

			expect(v12).to.equal((math.min(#t, #t2, #t3)))
		end)
		it("should zip maps together", function() --[[ Line: 370 | Upvalues: v1 (ref) ]]
			local t = {
				a = 10,
				b = 20,
				c = 30
			}
			local t2 = {
				a = 100,
				b = 200,
				c = 300
			}
			local t3 = {
				a = 3000,
				b = 2000,
				c = 3000
			}

			for v12, v2 in v1.Zip(t, t2, t3) do
				expect(v2[1]).to.equal(t[v12])
				expect(v2[2]).to.equal(t2[v12])
				expect(v2[3]).to.equal(t3[v12])
			end
		end)
		it("should zip maps of different keys together", function() --[[ Line: 381 | Upvalues: v1 (ref) ]]
			local t = {
				a = 10,
				b = 20,
				c = 30,
				d = 40
			}
			local t2 = {
				a = 100,
				b = 200,
				c = 300,
				z = 10
			}
			local t3 = {
				a = 3000,
				b = 2000,
				c = 3000,
				x = 0
			}

			for v12, v2 in v1.Zip(t, t2, t3) do
				expect(v2[1]).to.equal(t[v12])
				expect(v2[2]).to.equal(t2[v12])
				expect(v2[3]).to.equal(t3[v12])
			end
		end)
	end)
	describe("IsEmpty", function() --[[ Line: 393 | Upvalues: v1 (copy) ]]
		it("should detect that table is empty", function() --[[ Line: 394 | Upvalues: v1 (ref) ]]
			expect((v1.IsEmpty({}))).to.equal(true)
		end)
		it("should detect that array is not empty", function() --[[ Line: 400 | Upvalues: v1 (ref) ]]
			expect((v1.IsEmpty({ 10, 20, 30 }))).to.equal(false)
		end)
		it("should detect that dictionary is not empty", function() --[[ Line: 406 | Upvalues: v1 (ref) ]]
			expect((v1.IsEmpty({
				a = 10,
				b = 20,
				c = 30
			}))).to.equal(false)
		end)
	end)
	describe("JSON", function() --[[ Line: 413 | Upvalues: v1 (copy) ]]
		it("should encode json", function() --[[ Line: 414 | Upvalues: v1 (ref) ]]
			expect((v1.EncodeJSON({
				hello = "world"
			}))).to.equal("{\"hello\":\"world\"}")
		end)
		it("should decode json", function() --[[ Line: 420 | Upvalues: v1 (ref) ]]
			local v12 = v1.DecodeJSON("{\"hello\":\"world\"}")

			expect(v12).to.be.a("table")
			expect(v12.hello).to.equal("world")
		end)
	end)
end