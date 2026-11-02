-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Parent = require(script.Parent)
    describe("Copy (Deep)", function() -- line 4 | captures: Parent
        it("should create a deep table copy", function() -- line 5 | captures: Parent
            local v1 = {
                a = {
                    b = {
                        c = { d = 32 }
                    }
                }
            }
            local v2 = Parent.Copy(v1, true)
            expect(v1).never.to.equal(v2)
            expect(v1.a).never.to.equal(v2.a)
            expect(v2.a.b.c.d).to.equal(v1.a.b.c.d)
        end)
    end)
    describe("Copy (Shallow)", function() -- line 14 | captures: Parent
        it("should create a shallow dictionary copy", function() -- line 15 | captures: Parent
            local v3 = {
                a = {
                    b = {
                        c = { d = 32 }
                    }
                }
            }
            local v4 = Parent.Copy(v3)
            expect(v4).never.to.equal(v3)
            expect(v4.a).to.equal(v3.a)
            expect(v4.a.b.c.d).to.equal(v3.a.b.c.d)
        end)
        it("should create a shallow array copy", function() -- line 23 | captures: Parent
            local v5 = { 10, 20, 30, 40 }
            local v6 = Parent.Copy(v5)
            expect(v6).never.to.equal(v5)
            for v7, v8 in ipairs(v5) do
                expect(v6[v7]).to.equal(v8)
            end
        end)
    end)
    describe("Sync", function() -- line 33 | captures: Parent
        it("should sync tables", function() -- line 34 | captures: Parent
            local v9 = {
                a = 32,
                b = 64,
                c = 128,
                e = { h = 1 }
            }
            local v10 = {
                a = 32,
                b = 10,
                d = 1,
                e = {
                    h = 2,
                    n = 2
                },
                f = { x = 10 }
            }
            local v11 = Parent.Sync(v10, v9)
            expect(v11.a).to.equal(v9.a)
            expect(v11.b).to.equal(10)
            expect(v11.c).to.equal(v9.c)
            expect(v11.d).never.to.be.ok()
            expect(v11.e.h).to.equal(2)
            expect(v11.e.n).never.to.be.ok()
            expect(v11.f).never.to.be.ok()
        end)
    end)
    describe("Reconcile", function() -- line 48 | captures: Parent
        it("should reconcile table", function() -- line 49 | captures: Parent
            local v12 = {
                kills = 0,
                deaths = 0,
                xp = 10,
                stuff2 = "abc",
                stuff = {},
                stuff3 = { "data" }
            }
            local v13 = {
                kills = 10,
                deaths = 4,
                extra = 5,
                stuff3 = true,
                stuff = { "abc", "xyz" },
                stuff2 = { abc = 10 }
            }
            local v14 = Parent.Reconcile(v13, v12)
            expect(v14).never.to.equal(v13)
            expect(v14).never.to.equal(v12)
            expect(v14.kills).to.equal(10)
            expect(v14.deaths).to.equal(4)
            expect(v14.xp).to.equal(10)
            expect(v14.stuff[1]).to.equal("abc")
            expect(v14.stuff[2]).to.equal("xyz")
            expect(v14.extra).to.equal(5)
            local expect_2 = expect
            local stuff2 = v14.stuff2
            expect_2((type(stuff2))).to.equal("table")
            expect(v14.stuff2).never.to.equal(v13.stuff2)
            expect(v14.stuff2.abc).to.equal(10)
            local expect_3 = expect
            local stuff3 = v14.stuff3
            expect_3((type(stuff3))).to.equal("boolean")
            expect(v14.stuff3).to.equal(true)
        end)
    end)
    describe("SwapRemove", function() -- line 70 | captures: Parent
        it("should swap remove index", function() -- line 71 | captures: Parent
            local v15 = { 1, 2, 3, 4, 5 }
            Parent.SwapRemove(v15, 3)
            expect(#v15).to.equal(4)
            expect(v15[3]).to.equal(5)
        end)
    end)
    describe("SwapRemoveFirstValue", function() -- line 79 | captures: Parent
        it("should swap remove first value given", function() -- line 80 | captures: Parent
            local v16 = { "hello", "world", "goodbye", "planet" }
            Parent.SwapRemoveFirstValue(v16, "world")
            expect(#v16).to.equal(3)
            expect(v16[2]).to.equal("planet")
        end)
    end)
    describe("Map", function() -- line 88 | captures: Parent
        it("should map table", function() -- line 89 | captures: Parent
            local v17 = {
                {
                    FirstName = "John",
                    LastName = "Doe"
                },
                {
                    FirstName = "Jane",
                    LastName = "Smith"
                }
            }
            local v18 = Parent.Map(v17, function(v19) -- line 94
                return v19.FirstName .. " " .. v19.LastName
            end)
            expect(v18[1]).to.equal("John Doe")
            expect(v18[2]).to.equal("Jane Smith")
        end)
    end)
    describe("Filter", function() -- line 102 | captures: Parent
        it("should filter table", function() -- line 103 | captures: Parent
            local v20 = {
                10,
                20,
                30,
                40,
                50,
                60,
                70,
                80,
                90
            }
            local v21 = Parent.Filter(v20, function(v22) -- line 105
                if v22 >= 30 then
                    return v22 <= 60
                end
                return false
            end)
            expect(#v21).to.equal(4)
            expect(v21[1]).to.equal(30)
            expect(v21[#v21]).to.equal(60)
        end)
    end)
    describe("Reduce", function() -- line 114 | captures: Parent
        it("should reduce table with numbers", function() -- line 115 | captures: Parent
            local v23 = { 1, 2, 3, 4, 5 }
            local v24 = Parent.Reduce(v23, function(v25, v26) -- line 117
                return v25 + v26
            end)
            expect(v24).to.equal(15)
        end)
        it("should reduce table", function() -- line 123 | captures: Parent
            local v27 = {
                { Score = 10 },
                { Score = 20 },
                { Score = 30 }
            }
            local v28 = Parent.Reduce(v27, function(v29, v30) -- line 125
                return v29 + v30.Score
            end, 0)
            expect(v28).to.equal(60)
        end)
        it("should reduce table with initial value", function() -- line 131 | captures: Parent
            local v31 = {
                { Score = 10 },
                { Score = 20 },
                { Score = 30 }
            }
            local v32 = Parent.Reduce(v31, function(v33, v34) -- line 133
                return v33 + v34.Score
            end, 40)
            expect(v32).to.equal(100)
        end)
        it("should reduce functions", function() -- line 139 | captures: Parent
            local function Square(v35) -- line 140
                return v35 * v35
            end

            local function Double(v36) -- line 143
                return v36 * 2
            end

            local v37 = Parent.Reduce({ Square, Double }, function(v38, v39) -- line 146
                return function(v40) -- line 147 | captures: v38, v39
                    return v38(v39(v40))
                end
            end)(10)
            expect(v37).to.equal(400)
        end)
    end)
    describe("Assign", function() -- line 156 | captures: Parent
        it("should assign tables", function() -- line 157 | captures: Parent
            local v41 = {
                a = 32,
                x = 100
            }
            local v42 = {
                b = 64,
                c = 128
            }
            local v43 = {
                a = 10,
                c = 100,
                d = 200
            }
            local v44 = Parent.Assign(v41, v42, v43)
            expect(v44.a).to.equal(10)
            expect(v44.b).to.equal(64)
            expect(v44.c).to.equal(100)
            expect(v44.d).to.equal(200)
            expect(v44.x).to.equal(100)
        end)
    end)
    describe("Extend", function() -- line 170 | captures: Parent
        it("should extend tables", function() -- line 171 | captures: Parent
            local v45 = { "a", "b", "c" }
            local v46 = { "d", "e", "f" }
            local v47 = Parent.Extend(v45, v46)
            expect(table.concat(v47)).to.equal("abcdef")
        end)
    end)
    describe("Reverse", function() -- line 179 | captures: Parent
        it("should create a table in reverse", function() -- line 180 | captures: Parent
            local v48 = { 1, 2, 3 }
            local v49 = Parent.Reverse(v48)
            expect(table.concat(v49)).to.equal("321")
        end)
    end)
    describe("Shuffle", function() -- line 187 | captures: Parent
        it("should shuffle a table", function() -- line 188 | captures: Parent
            local v50 = { 1, 2, 3, 4, 5 }
            expect(function() -- line 190 | captures: v50, Parent
                Parent.Shuffle(v50)
            end).never.to.throw()
        end)
    end)
    describe("Sample", function() -- line 196 | captures: Parent
        it("should sample a table", function() -- line 197 | captures: Parent
            local v51 = { 1, 2, 3, 4, 5 }
            local v52 = Parent.Sample(v51, 3)
            expect(#v52).to.equal(3)
        end)
    end)
    describe("Flat", function() -- line 204 | captures: Parent
        it("should flatten table", function() -- line 205 | captures: Parent
            local v53 = {
                1,
                2,
                3,
                {
                    4,
                    5,
                    { 6, 7 }
                }
            }
            local v54 = Parent.Flat(v53, 3)
            expect(table.concat(v54)).to.equal("1234567")
        end)
    end)
    describe("FlatMap", function() -- line 212 | captures: Parent
        it("should map and flatten table", function() -- line 213 | captures: Parent
            local v55 = { 1, 2, 3, 4, 5, 6, 7 }
            local v56 = Parent.FlatMap(v55, function(v57) -- line 215
                return {
                    v57,
                    v57 * 2
                }
            end)
            expect(table.concat(v56)).to.equal("12243648510612714")
        end)
    end)
    describe("Keys", function() -- line 222 | captures: Parent
        it("should give all keys of table", function() -- line 223 | captures: Parent
            local v58 = {
                a = 1,
                b = 2,
                c = 3
            }
            local v59 = Parent.Keys(v58)
            expect(#v59).to.equal(3)
            expect(table.find(v59, "a")).to.be.ok()
            expect(table.find(v59, "b")).to.be.ok()
            expect(table.find(v59, "c")).to.be.ok()
        end)
    end)
    describe("Values", function() -- line 233 | captures: Parent
        it("should give all values of table", function() -- line 234 | captures: Parent
            local v60 = {
                a = 1,
                b = 2,
                c = 3
            }
            local v61 = Parent.Values(v60)
            expect(#v61).to.equal(3)
            expect(table.find(v61, 1)).to.be.ok()
            expect(table.find(v61, 2)).to.be.ok()
            expect(table.find(v61, 3)).to.be.ok()
        end)
    end)
    describe("Find", function() -- line 244 | captures: Parent
        it("should find item in array", function() -- line 245 | captures: Parent
            local v62 = { 10, 20, 30 }
            local v63, v64 = Parent.Find(v62, function(v65) -- line 247
                return v65 == 20
            end)
            expect(v63).to.be.ok()
            expect(v64).to.equal(2)
            expect(v63).to.equal(20)
        end)
        it("should find item in dictionary", function() -- line 255 | captures: Parent
            local v66 = {
                { Score = 10 },
                { Score = 20 },
                { Score = 30 }
            }
            local v67, v68 = Parent.Find(v66, function(v69) -- line 257
                return v69.Score == 20
            end)
            expect(v67).to.be.ok()
            expect(v68).to.equal(2)
            expect(v67.Score).to.equal(20)
        end)
    end)
    describe("Every", function() -- line 266 | captures: Parent
        it("should see every value is above 20", function() -- line 267 | captures: Parent
            local v70 = { 21, 40, 200 }
            local v71 = Parent.Every(v70, function(v72) -- line 269
                return v72 > 20
            end)
            expect(v71).to.equal(true)
        end)
        it("should see every value is not above 20", function() -- line 275 | captures: Parent
            local v73 = { 20, 40, 200 }
            local v74 = Parent.Every(v73, function(v75) -- line 277
                return v75 > 20
            end)
            expect(v74).never.to.equal(true)
        end)
    end)
    describe("Some", function() -- line 284 | captures: Parent
        it("should see some value is above 20", function() -- line 285 | captures: Parent
            local v76 = { 5, 40, 1 }
            local v77 = Parent.Some(v76, function(v78) -- line 287
                return v78 > 20
            end)
            expect(v77).to.equal(true)
        end)
        it("should see some value is not above 20", function() -- line 293 | captures: Parent
            local v79 = { 5, 15, 1 }
            local v80 = Parent.Some(v79, function(v81) -- line 295
                return v81 > 20
            end)
            expect(v80).never.to.equal(true)
        end)
    end)
    describe("Truncate", function() -- line 302 | captures: Parent
        it("should truncate an array", function() -- line 303 | captures: Parent
            local v82 = { 1, 2, 3, 4, 5 }
            local v83 = Parent.Truncate(v82, 3)
            expect(#v83).to.equal(3)
            expect(v83[1]).to.equal(v82[1])
            expect(v83[2]).to.equal(v82[2])
            expect(v83[3]).to.equal(v82[3])
        end)
        it("should truncate an array with out of bounds sizes", function() -- line 312 | captures: Parent
            local v84 = { 1, 2, 3, 4, 5 }
            expect(function() -- line 314 | captures: v84, Parent
                Parent.Truncate(v84, -1)
            end).to.never.throw()
            expect(function() -- line 317 | captures: v84, Parent
                Parent.Truncate(v84, #v84 + 1)
            end).to.never.throw()
            local v85 = Parent.Truncate(v84, #v84 + 10)
            expect(#v85).to.equal(#v84)
            expect(v85).to.never.equal(v84)
        end)
    end)
    describe("Lock", function() -- line 326 | captures: Parent
        it("should lock a table", function() -- line 327 | captures: Parent
            local v86 = {
                abc = {
                    xyz = { num = 32 }
                }
            }
            expect(function() -- line 329 | captures: v86
                v86.abc.xyz.num = 64
            end).never.to.throw()
            local v87 = Parent.Lock(v86)
            expect(v86.abc.xyz.num).to.equal(64)
            expect(v86).to.equal(v87)
            expect(function() -- line 335 | captures: v86
                v86.abc.xyz.num = 10
            end).to.throw()
        end)
    end)
    describe("Zip", function() -- line 341 | captures: Parent
        it("should zip arrays together", function() -- line 342 | captures: Parent
            local v88 = { 1, 2, 3, 4, 5 }
            local v89 = { 9, 8, 7, 6, 5 }
            local v90 = { 1, 1, 1, 1, 1 }
            local v91 = 0
            for v92, v93 in Parent.Zip(v88, v89, v90) do
                expect(v93[1]).to.equal(v88[v92])
                expect(v93[2]).to.equal(v89[v92])
                expect(v93[3]).to.equal(v90[v92])
                v91 = v92
            end
            local equal = expect(v91).to.equal
            local v94 = #v88
            local v95 = #v89
            local v96 = #v90
            equal((math.min(v94, v95, v96)))
        end)
        it("should zip arrays of different lengths together", function() -- line 356 | captures: Parent
            local v97 = { 1, 2, 3, 4, 5 }
            local v98 = { 9, 8, 7, 6 }
            local v99 = { 1, 1, 1 }
            local v100 = 0
            for v101, v102 in Parent.Zip(v97, v98, v99) do
                expect(v102[1]).to.equal(v97[v101])
                expect(v102[2]).to.equal(v98[v101])
                expect(v102[3]).to.equal(v99[v101])
                v100 = v101
            end
            local equal = expect(v100).to.equal
            local v103 = #v97
            local v104 = #v98
            local v105 = #v99
            equal((math.min(v103, v104, v105)))
        end)
        it("should zip maps together", function() -- line 370 | captures: Parent
            local v106 = {
                a = 10,
                b = 20,
                c = 30
            }
            local v107 = {
                a = 100,
                b = 200,
                c = 300
            }
            local v108 = {
                a = 3000,
                b = 2000,
                c = 3000
            }
            for v109, v110 in Parent.Zip(v106, v107, v108) do
                expect(v110[1]).to.equal(v106[v109])
                expect(v110[2]).to.equal(v107[v109])
                expect(v110[3]).to.equal(v108[v109])
            end
        end)
        it("should zip maps of different keys together", function() -- line 381 | captures: Parent
            local v111 = {
                a = 10,
                b = 20,
                c = 30,
                d = 40
            }
            local v112 = {
                a = 100,
                b = 200,
                c = 300,
                z = 10
            }
            local v113 = {
                a = 3000,
                b = 2000,
                c = 3000,
                x = 0
            }
            for v114, v115 in Parent.Zip(v111, v112, v113) do
                expect(v115[1]).to.equal(v111[v114])
                expect(v115[2]).to.equal(v112[v114])
                expect(v115[3]).to.equal(v113[v114])
            end
        end)
    end)
    describe("IsEmpty", function() -- line 393 | captures: Parent
        it("should detect that table is empty", function() -- line 394 | captures: Parent
            local v116 = {}
            local v117 = Parent.IsEmpty(v116)
            expect(v117).to.equal(true)
        end)
        it("should detect that array is not empty", function() -- line 400 | captures: Parent
            local v118 = { 10, 20, 30 }
            local v119 = Parent.IsEmpty(v118)
            expect(v119).to.equal(false)
        end)
        it("should detect that dictionary is not empty", function() -- line 406 | captures: Parent
            local v120 = {
                a = 10,
                b = 20,
                c = 30
            }
            local v121 = Parent.IsEmpty(v120)
            expect(v121).to.equal(false)
        end)
    end)
    describe("JSON", function() -- line 413 | captures: Parent
        it("should encode json", function() -- line 414 | captures: Parent
            local v122 = { hello = "world" }
            local v123 = Parent.EncodeJSON(v122)
            expect(v123).to.equal("{\"hello\":\"world\"}")
        end)
        it("should decode json", function() -- line 420 | captures: Parent
            local v124 = Parent.DecodeJSON("{\"hello\":\"world\"}")
            expect(v124).to.be.a("table")
            expect(v124.hello).to.equal("world")
        end)
    end)
end
