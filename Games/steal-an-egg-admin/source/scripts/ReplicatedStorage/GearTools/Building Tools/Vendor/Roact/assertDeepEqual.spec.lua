-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.assertDeepEqual)
    it("should fail with a message when args are not equal", function() -- line 4 | captures: assertDeepEqual
        local v1, v2 = pcall(assertDeepEqual, 1, 2)
        expect(v1).to.equal(false)
        expect(v2:find("first ~= second")).to.be.ok()
        local v3, v4 = pcall(assertDeepEqual, { foo = 1 }, { foo = 2 })
        expect(v3).to.equal(false)
        expect(v4:find("first%[foo%] ~= second%[foo%]")).to.be.ok()
    end)
    it("should compare non-table values using standard '==' equality", function() -- line 20 | captures: assertDeepEqual
        assertDeepEqual(1, 1)
        assertDeepEqual("hello", "hello")
        assertDeepEqual(nil, nil)

        local function v5() -- line 25
        end

        assertDeepEqual(v5, v5)
        local v6 = { foo = v5 }
        local v7 = { foo = v5 }
        assertDeepEqual(v6, v7)
    end)
    it("should fail when types differ", function() -- line 40 | captures: assertDeepEqual
        local v8, v9 = pcall(assertDeepEqual, 1, "1")
        expect(v8).to.equal(false)
        expect(v9:find("first is of type number, but second is of type string")).to.be.ok()
    end)
    it("should compare (and report about) nested tables", function() -- line 47 | captures: assertDeepEqual
        local v10 = {
            foo = "bar",
            nested = {
                foo = 1,
                bar = 2
            }
        }
        local v11 = {
            foo = "bar",
            nested = {
                foo = 1,
                bar = 2
            }
        }
        assertDeepEqual(v10, v11)
        local v12 = {
            foo = "bar",
            nested = {
                foo = 1,
                bar = 3
            }
        }
        local v13, v14 = pcall(assertDeepEqual, v10, v12)
        expect(v13).to.equal(false)
        expect(v14:find("first%[nested%]%[bar%] ~= second%[nested%]%[bar%]")).to.be.ok()
    end)
    it("should be commutative", function() -- line 79 | captures: assertDeepEqual
        local v15 = {
            foo = "bar",
            hello = "world"
        }
        local v16 = {
            foo = "bar",
            hello = "world"
        }
        assertDeepEqual(v15, v16)
        assertDeepEqual(v16, v15)
        local v17 = { foo = "bar" }
        expect(function() -- line 96 | captures: v15, v17, assertDeepEqual
            assertDeepEqual(v15, v17)
        end).to.throw()
        expect(function() -- line 97 | captures: v15, v17, assertDeepEqual
            assertDeepEqual(v17, v15)
        end).to.throw()
    end)
end
