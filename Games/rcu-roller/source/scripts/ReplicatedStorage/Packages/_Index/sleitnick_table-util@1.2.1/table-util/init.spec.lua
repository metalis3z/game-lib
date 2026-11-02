-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:18
-- Luau version 6, Types version 3
-- Time taken: 0.015835 seconds

return function() -- Line 1
	local Parent_upvr = require(script.Parent)
	describe("Copy (Deep)", function() -- Line 4
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should create a deep table copy", function() -- Line 5
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_19 = {
				a = {
					b = {
						c = {
							d = 32;
						};
					};
				};
			}
			local any_Copy_result1_3 = Parent_upvr.Copy(tbl_19, true)
			expect(tbl_19).never.to.equal(any_Copy_result1_3)
			expect(tbl_19.a).never.to.equal(any_Copy_result1_3.a)
			expect(any_Copy_result1_3.a.b.c.d).to.equal(tbl_19.a.b.c.d)
		end)
	end)
	describe("Copy (Shallow)", function() -- Line 14
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should create a shallow dictionary copy", function() -- Line 15
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_23 = {
				a = {
					b = {
						c = {
							d = 32;
						};
					};
				};
			}
			local any_Copy_result1_2 = Parent_upvr.Copy(tbl_23)
			expect(any_Copy_result1_2).never.to.equal(tbl_23)
			expect(any_Copy_result1_2.a).to.equal(tbl_23.a)
			expect(any_Copy_result1_2.a.b.c.d).to.equal(tbl_23.a.b.c.d)
		end)
		it("should create a shallow array copy", function() -- Line 23
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_2 = {10, 20, 30, 40}
			local any_Copy_result1 = Parent_upvr.Copy(tbl_2)
			expect(any_Copy_result1).never.to.equal(tbl_2)
			for i, v in ipairs(tbl_2) do
				expect(any_Copy_result1[i]).to.equal(v)
			end
		end)
	end)
	describe("Sync", function() -- Line 33
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should sync tables", function() -- Line 34
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_7 = {
				a = 32;
				b = 64;
				c = 128;
				e = {
					h = 1;
				};
			}
			local any_Sync_result1 = Parent_upvr.Sync({
				a = 32;
				b = 10;
				d = 1;
				e = {
					h = 2;
					n = 2;
				};
				f = {
					x = 10;
				};
			}, tbl_7)
			expect(any_Sync_result1.a).to.equal(tbl_7.a)
			expect(any_Sync_result1.b).to.equal(10)
			expect(any_Sync_result1.c).to.equal(tbl_7.c)
			expect(any_Sync_result1.d).never.to.be.ok()
			expect(any_Sync_result1.e.h).to.equal(2)
			expect(any_Sync_result1.e.n).never.to.be.ok()
			expect(any_Sync_result1.f).never.to.be.ok()
		end)
	end)
	describe("Reconcile", function() -- Line 48
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should reconcile table", function() -- Line 49
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_8 = {
				kills = 0;
				deaths = 0;
				xp = 10;
				stuff = {};
				stuff2 = "abc";
				stuff3 = {"data"};
			}
			local tbl_24 = {
				kills = 10;
				deaths = 4;
				stuff = {"abc", "xyz"};
				extra = 5;
				stuff2 = {
					abc = 10;
				};
				stuff3 = true;
			}
			local any_Reconcile_result1 = Parent_upvr.Reconcile(tbl_24, tbl_8)
			expect(any_Reconcile_result1).never.to.equal(tbl_24)
			expect(any_Reconcile_result1).never.to.equal(tbl_8)
			expect(any_Reconcile_result1.kills).to.equal(10)
			expect(any_Reconcile_result1.deaths).to.equal(4)
			expect(any_Reconcile_result1.xp).to.equal(10)
			expect(any_Reconcile_result1.stuff[1]).to.equal("abc")
			expect(any_Reconcile_result1.stuff[2]).to.equal("xyz")
			expect(any_Reconcile_result1.extra).to.equal(5)
			expect(type(any_Reconcile_result1.stuff2)).to.equal("table")
			expect(any_Reconcile_result1.stuff2).never.to.equal(tbl_24.stuff2)
			expect(any_Reconcile_result1.stuff2.abc).to.equal(10)
			expect(type(any_Reconcile_result1.stuff3)).to.equal("boolean")
			expect(any_Reconcile_result1.stuff3).to.equal(true)
		end)
	end)
	describe("SwapRemove", function() -- Line 70
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should swap remove index", function() -- Line 71
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_21 = {1, 2, 3, 4, 5}
			Parent_upvr.SwapRemove(tbl_21, 3)
			expect(#tbl_21).to.equal(4)
			expect(tbl_21[3]).to.equal(5)
		end)
	end)
	describe("SwapRemoveFirstValue", function() -- Line 79
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should swap remove first value given", function() -- Line 80
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_5 = {"hello", "world", "goodbye", "planet"}
			Parent_upvr.SwapRemoveFirstValue(tbl_5, "world")
			expect(#tbl_5).to.equal(3)
			expect(tbl_5[2]).to.equal("planet")
		end)
	end)
	describe("Map", function() -- Line 88
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should map table", function() -- Line 89
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Map_result1 = Parent_upvr.Map({{
				FirstName = "John";
				LastName = "Doe";
			}, {
				FirstName = "Jane";
				LastName = "Smith";
			}}, function(arg1) -- Line 94
				return arg1.FirstName..' '..arg1.LastName
			end)
			expect(any_Map_result1[1]).to.equal("John Doe")
			expect(any_Map_result1[2]).to.equal("Jane Smith")
		end)
	end)
	describe("Filter", function() -- Line 102
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should filter table", function() -- Line 103
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Filter_result1 = Parent_upvr.Filter({10, 20, 30, 40, 50, 60, 70, 80, 90}, function(arg1) -- Line 105
				local var60 = false
				if 30 <= arg1 then
					if arg1 > 60 then
						var60 = false
					else
						var60 = true
					end
				end
				return var60
			end)
			expect(#any_Filter_result1).to.equal(4)
			expect(any_Filter_result1[1]).to.equal(30)
			expect(any_Filter_result1[#any_Filter_result1]).to.equal(60)
		end)
	end)
	describe("Reduce", function() -- Line 114
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should reduce table with numbers", function() -- Line 115
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Reduce({1, 2, 3, 4, 5}, function(arg1, arg2) -- Line 117
				return arg1 + arg2
			end)).to.equal(15)
		end)
		it("should reduce table", function() -- Line 123
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Reduce({{
				Score = 10;
			}, {
				Score = 20;
			}, {
				Score = 30;
			}}, function(arg1, arg2) -- Line 125
				return arg1 + arg2.Score
			end, 0)).to.equal(60)
		end)
		it("should reduce table with initial value", function() -- Line 131
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Reduce({{
				Score = 10;
			}, {
				Score = 20;
			}, {
				Score = 30;
			}}, function(arg1, arg2) -- Line 133
				return arg1 + arg2.Score
			end, 40)).to.equal(100)
		end)
		it("should reduce functions", function() -- Line 139
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Reduce({function(arg1) -- Line 140, Named "Square"
				return arg1 * arg1
			end, function(arg1) -- Line 143, Named "Double"
				return arg1 * 2
			end}, function(arg1, arg2) -- Line 146
				return function(arg1_2) -- Line 147
					--[[ Upvalues[2]:
						[1]: arg1 (readonly)
						[2]: arg2 (readonly)
					]]
					return arg1(arg2(arg1_2))
				end
			end)(10)).to.equal(400)
		end)
	end)
	describe("Assign", function() -- Line 156
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should assign tables", function() -- Line 157
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Assign_result1 = Parent_upvr.Assign({
				a = 32;
				x = 100;
			}, {
				b = 64;
				c = 128;
			}, {
				a = 10;
				c = 100;
				d = 200;
			})
			expect(any_Assign_result1.a).to.equal(10)
			expect(any_Assign_result1.b).to.equal(64)
			expect(any_Assign_result1.c).to.equal(100)
			expect(any_Assign_result1.d).to.equal(200)
			expect(any_Assign_result1.x).to.equal(100)
		end)
	end)
	describe("Extend", function() -- Line 170
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should extend tables", function() -- Line 171
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(table.concat(Parent_upvr.Extend({'a', 'b', 'c'}, {'d', 'e', 'f'}))).to.equal("abcdef")
		end)
	end)
	describe("Reverse", function() -- Line 179
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should create a table in reverse", function() -- Line 180
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(table.concat(Parent_upvr.Reverse({1, 2, 3}))).to.equal("321")
		end)
	end)
	describe("Shuffle", function() -- Line 187
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should shuffle a table", function() -- Line 188
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_9_upvr = {1, 2, 3, 4, 5}
			expect(function() -- Line 190
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: tbl_9_upvr (readonly)
				]]
				Parent_upvr.Shuffle(tbl_9_upvr)
			end).never.to.throw()
		end)
	end)
	describe("Sample", function() -- Line 196
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should sample a table", function() -- Line 197
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(#Parent_upvr.Sample({1, 2, 3, 4, 5}, 3)).to.equal(3)
		end)
	end)
	describe("Flat", function() -- Line 204
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should flatten table", function() -- Line 205
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(table.concat(Parent_upvr.Flat({1, 2, 3, {4, 5, {6, 7}}}, 3))).to.equal("1234567")
		end)
	end)
	describe("FlatMap", function() -- Line 212
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should map and flatten table", function() -- Line 213
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(table.concat(Parent_upvr.FlatMap({1, 2, 3, 4, 5, 6, 7}, function(arg1) -- Line 215
				local module = {}
				module[1] = arg1
				module[2] = arg1 * 2
				return module
			end))).to.equal("12243648510612714")
		end)
	end)
	describe("Keys", function() -- Line 222
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should give all keys of table", function() -- Line 223
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Keys_result1 = Parent_upvr.Keys({
				a = 1;
				b = 2;
				c = 3;
			})
			expect(#any_Keys_result1).to.equal(3)
			expect(table.find(any_Keys_result1, 'a')).to.be.ok()
			expect(table.find(any_Keys_result1, 'b')).to.be.ok()
			expect(table.find(any_Keys_result1, 'c')).to.be.ok()
		end)
	end)
	describe("Values", function() -- Line 233
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should give all values of table", function() -- Line 234
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Values_result1 = Parent_upvr.Values({
				a = 1;
				b = 2;
				c = 3;
			})
			expect(#any_Values_result1).to.equal(3)
			expect(table.find(any_Values_result1, 1)).to.be.ok()
			expect(table.find(any_Values_result1, 2)).to.be.ok()
			expect(table.find(any_Values_result1, 3)).to.be.ok()
		end)
	end)
	describe("Find", function() -- Line 244
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should find item in array", function() -- Line 245
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Find_result1, any_Find_result2_2 = Parent_upvr.Find({10, 20, 30}, function(arg1) -- Line 247
				if arg1 ~= 20 then
				else
				end
				return true
			end)
			expect(any_Find_result1).to.be.ok()
			expect(any_Find_result2_2).to.equal(2)
			expect(any_Find_result1).to.equal(20)
		end)
		it("should find item in dictionary", function() -- Line 255
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_Find_result1_2, any_Find_result2 = Parent_upvr.Find({{
				Score = 10;
			}, {
				Score = 20;
			}, {
				Score = 30;
			}}, function(arg1) -- Line 257
				local var132
				if arg1.Score ~= 20 then
					var132 = false
				else
					var132 = true
				end
				return var132
			end)
			expect(any_Find_result1_2).to.be.ok()
			expect(any_Find_result2).to.equal(2)
			expect(any_Find_result1_2.Score).to.equal(20)
		end)
	end)
	describe("Every", function() -- Line 266
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should see every value is above 20", function() -- Line 267
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Every({21, 40, 200}, function(arg1) -- Line 269
				local var139
				if 20 >= arg1 then
					var139 = false
				else
					var139 = true
				end
				return var139
			end)).to.equal(true)
		end)
		it("should see every value is not above 20", function() -- Line 275
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Every({20, 40, 200}, function(arg1) -- Line 277
				local var143
				if 20 >= arg1 then
					var143 = false
				else
					var143 = true
				end
				return var143
			end)).never.to.equal(true)
		end)
	end)
	describe("Some", function() -- Line 284
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should see some value is above 20", function() -- Line 285
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Some({5, 40, 1}, function(arg1) -- Line 287
				local var148
				if 20 >= arg1 then
					var148 = false
				else
					var148 = true
				end
				return var148
			end)).to.equal(true)
		end)
		it("should see some value is not above 20", function() -- Line 293
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.Some({5, 15, 1}, function(arg1) -- Line 295
				local var152
				if 20 >= arg1 then
					var152 = false
				else
					var152 = true
				end
				return var152
			end)).never.to.equal(true)
		end)
	end)
	describe("Truncate", function() -- Line 302
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should truncate an array", function() -- Line 303
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_3 = {1, 2, 3, 4, 5}
			local any_Truncate_result1_2 = Parent_upvr.Truncate(tbl_3, 3)
			expect(#any_Truncate_result1_2).to.equal(3)
			expect(any_Truncate_result1_2[1]).to.equal(tbl_3[1])
			expect(any_Truncate_result1_2[2]).to.equal(tbl_3[2])
			expect(any_Truncate_result1_2[3]).to.equal(tbl_3[3])
		end)
		it("should truncate an array with out of bounds sizes", function() -- Line 312
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_20_upvr = {1, 2, 3, 4, 5}
			expect(function() -- Line 314
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: tbl_20_upvr (readonly)
				]]
				Parent_upvr.Truncate(tbl_20_upvr, -1)
			end).to.never.throw()
			expect(function() -- Line 317
				--[[ Upvalues[2]:
					[1]: Parent_upvr (copied, readonly)
					[2]: tbl_20_upvr (readonly)
				]]
				Parent_upvr.Truncate(tbl_20_upvr, #tbl_20_upvr + 1)
			end).to.never.throw()
			local any_Truncate_result1 = Parent_upvr.Truncate(tbl_20_upvr, #tbl_20_upvr + 10)
			expect(#any_Truncate_result1).to.equal(#tbl_20_upvr)
			expect(any_Truncate_result1).to.never.equal(tbl_20_upvr)
		end)
	end)
	describe("Lock", function() -- Line 326
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should lock a table", function() -- Line 327
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_18_upvr = {
				abc = {
					xyz = {
						num = 32;
					};
				};
			}
			expect(function() -- Line 329
				--[[ Upvalues[1]:
					[1]: tbl_18_upvr (readonly)
				]]
				tbl_18_upvr.abc.xyz.num = 64
			end).never.to.throw()
			expect(tbl_18_upvr.abc.xyz.num).to.equal(64)
			expect(tbl_18_upvr).to.equal(Parent_upvr.Lock(tbl_18_upvr))
			expect(function() -- Line 335
				--[[ Upvalues[1]:
					[1]: tbl_18_upvr (readonly)
				]]
				tbl_18_upvr.abc.xyz.num = 10
			end).to.throw()
		end)
	end)
	describe("Zip", function() -- Line 341
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should zip arrays together", function() -- Line 342
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_17 = {1, 2, 3, 4, 5}
			local tbl_16 = {9, 8, 7, 6, 5}
			local tbl_22 = {1, 1, 1, 1, 1}
			local var181
			for i_2, v_2 in Parent_upvr.Zip(tbl_17, tbl_16, tbl_22) do
				expect(v_2[1]).to.equal(tbl_17[i_2])
				expect(v_2[2]).to.equal(tbl_16[i_2])
				expect(v_2[3]).to.equal(tbl_22[i_2])
			end
			expect(nil).to.equal(math.min(#tbl_17, #tbl_16, #tbl_22))
		end)
		it("should zip arrays of different lengths together", function() -- Line 356
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl = {1, 2, 3, 4, 5}
			local tbl_15 = {9, 8, 7, 6}
			local tbl_14 = {1, 1, 1}
			local var193
			for i_3, v_3 in Parent_upvr.Zip(tbl, tbl_15, tbl_14) do
				expect(v_3[1]).to.equal(tbl[i_3])
				expect(v_3[2]).to.equal(tbl_15[i_3])
				expect(v_3[3]).to.equal(tbl_14[i_3])
			end
			expect(nil).to.equal(math.min(#tbl, #tbl_15, #tbl_14))
		end)
		it("should zip maps together", function() -- Line 370
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_13 = {
				a = 10;
				b = 20;
				c = 30;
			}
			local tbl_4 = {
				a = 100;
				b = 200;
				c = 300;
			}
			local tbl_12 = {
				a = 3000;
				b = 2000;
				c = 3000;
			}
			for i_4, v_4 in Parent_upvr.Zip(tbl_13, tbl_4, tbl_12) do
				expect(v_4[1]).to.equal(tbl_13[i_4])
				expect(v_4[2]).to.equal(tbl_4[i_4])
				expect(v_4[3]).to.equal(tbl_12[i_4])
			end
		end)
		it("should zip maps of different keys together", function() -- Line 381
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local tbl_11 = {
				a = 10;
				b = 20;
				c = 30;
				d = 40;
			}
			local tbl_10 = {
				a = 100;
				b = 200;
				c = 300;
				z = 10;
			}
			local tbl_6 = {
				a = 3000;
				b = 2000;
				c = 3000;
				x = 0;
			}
			for i_5, v_5 in Parent_upvr.Zip(tbl_11, tbl_10, tbl_6) do
				expect(v_5[1]).to.equal(tbl_11[i_5])
				expect(v_5[2]).to.equal(tbl_10[i_5])
				expect(v_5[3]).to.equal(tbl_6[i_5])
			end
		end)
	end)
	describe("IsEmpty", function() -- Line 393
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should detect that table is empty", function() -- Line 394
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.IsEmpty({})).to.equal(true)
		end)
		it("should detect that array is not empty", function() -- Line 400
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.IsEmpty({10, 20, 30})).to.equal(false)
		end)
		it("should detect that dictionary is not empty", function() -- Line 406
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.IsEmpty({
				a = 10;
				b = 20;
				c = 30;
			})).to.equal(false)
		end)
	end)
	describe("JSON", function() -- Line 413
		--[[ Upvalues[1]:
			[1]: Parent_upvr (readonly)
		]]
		it("should encode json", function() -- Line 414
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			expect(Parent_upvr.EncodeJSON({
				hello = "world";
			})).to.equal("{\"hello\":\"world\"}")
		end)
		it("should decode json", function() -- Line 420
			--[[ Upvalues[1]:
				[1]: Parent_upvr (copied, readonly)
			]]
			local any_DecodeJSON_result1 = Parent_upvr.DecodeJSON("{\"hello\":\"world\"}")
			expect(any_DecodeJSON_result1).to.be.a("table")
			expect(any_DecodeJSON_result1.hello).to.equal("world")
		end)
	end)
end