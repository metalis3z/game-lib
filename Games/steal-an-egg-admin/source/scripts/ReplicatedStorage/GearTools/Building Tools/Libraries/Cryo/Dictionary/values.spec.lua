-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local values = require(script.Parent.values)
    local None = require(script.Parent.Parent.None)
    it("should not mutate the given table", function() -- line 5 | captures: values
        local v1 = {
            Foo = "FooValue",
            Bar = "BarValue"
        }
        local v2 = {
            Foo = "FooValue",
            Bar = "BarValue"
        }
        values(v1)
        for v3, v4 in pairs(v1) do
            expect(v2[v3]).to.equal(v4)
        end
        for v5, v6 in pairs(v2) do
            expect(v1[v5]).to.equal(v6)
        end
    end)
    it("should return the correct values", function() -- line 25 | captures: values
        local v7 = {
            Foo = "FooValue",
            Bar = "BarValue",
            Test = "TestValue"
        }
        local v8 = {
            FooValue = 1,
            BarValue = 1,
            TestValue = 1
        }
        local v9 = values(v7)
        expect(#v9).to.equal(3)
        for v10, v11 in ipairs(v9) do
            expect(v8[v11]).never.to.equal(nil)
            v8[v11] -= 1
        end
        for v12, v13 in pairs(v8) do
            expect(v13).to.equal(0)
        end
    end)
    it("should return duplicates if two values are the same", function() -- line 48 | captures: values
        local v14 = {
            Foo = "FooValue",
            Bar = "BarValue",
            Test = "FooValue"
        }
        local v15 = {
            FooValue = 2,
            BarValue = 1
        }
        local v16 = values(v14)
        expect(#v16).to.equal(3)
        for v17, v18 in ipairs(v16) do
            expect(v15[v18]).never.to.equal(nil)
            v15[v18] -= 1
        end
        for v19, v20 in pairs(v15) do
            expect(v20).to.equal(0)
        end
    end)
    it("should work with an empty table", function() -- line 70 | captures: values
        local v21 = values({})
        expect(next(v21)).to.equal(nil)
    end)
    it("should contain a None element if there is a None value in the dictionary", function() -- line 76 | captures: values, None
        local v22 = {
            Bar = "BarValue",
            Foo = None
        }
        local v23 = {}
        v23[None] = 1
        v23.BarValue = 1
        local v24 = values(v22)
        expect(#v24).to.equal(2)
        for v25, v26 in ipairs(v24) do
            expect(v23[v26]).never.to.equal(nil)
            v23[v26] -= 1
        end
        for v27, v28 in pairs(v23) do
            expect(v28).to.equal(0)
        end
    end)
end
