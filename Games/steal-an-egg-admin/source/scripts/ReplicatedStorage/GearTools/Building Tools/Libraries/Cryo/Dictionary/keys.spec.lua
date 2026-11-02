-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local keys = require(script.Parent.keys)
    local None = require(script.Parent.Parent.None)
    it("should not mutate the given table", function() -- line 5 | captures: keys
        local v1 = {
            Foo = "FooValue",
            Bar = "BarValue"
        }
        local v2 = {
            Foo = "FooValue",
            Bar = "BarValue"
        }
        keys(v1)
        for v3, v4 in pairs(v1) do
            expect(v2[v3]).to.equal(v4)
        end
        for v5, v6 in pairs(v2) do
            expect(v1[v5]).to.equal(v6)
        end
    end)
    it("should return the correct keys", function() -- line 25 | captures: keys
        local v7 = {
            Foo = "FooValue",
            Bar = "BarValue",
            Test = "TestValue"
        }
        local v8 = {
            Foo = 1,
            Bar = 1,
            Test = 1
        }
        local v9 = keys(v7)
        expect(#v9).to.equal(3)
        for v10, v11 in ipairs(v9) do
            expect(v8[v11]).never.to.equal(nil)
            v8[v11] -= 1
        end
        for v12, v13 in pairs(v8) do
            expect(v13).to.equal(0)
        end
    end)
    it("should work with an empty table", function() -- line 48 | captures: keys
        local v14 = keys({})
        expect(next(v14)).to.equal(nil)
    end)
    it("should contain a None element if there is a None key in the dictionary", function() -- line 54 | captures: keys, None
        local v15 = {}
        v15[None] = "Foo"
        v15.Bar = "BarValue"
        local v16 = {}
        v16[None] = 1
        v16.Bar = 1
        local v17 = keys(v15)
        expect(#v17).to.equal(2)
        for v18, v19 in ipairs(v17) do
            expect(v16[v19]).never.to.equal(nil)
            v16[v19] -= 1
        end
        for v20, v21 in pairs(v16) do
            expect(v21).to.equal(0)
        end
    end)
end
