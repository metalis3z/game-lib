-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local sort = require(script.Parent.sort)
    it("should return a new table", function() -- line 4 | captures: sort
        local v1 = {}
        expect(sort(v1)).never.to.equal(v1)
    end)
    it("should not mutate the given table", function() -- line 10 | captures: sort
        local v2 = { 77, "foo", 2 }

        local function order(v3, v4) -- line 12
            return tostring(v3) < tostring(v4)
        end

        sort(v2, order)
        expect(#v2).to.equal(3)
        expect(v2[1]).to.equal(77)
        expect(v2[2]).to.equal("foo")
        expect(v2[3]).to.equal(2)
    end)
    it("should contain the same elements from the given table", function() -- line 23 | captures: sort
        local v5 = { "Foo", "Bar", "Test" }
        local v6 = {
            Foo = true,
            Bar = true,
            Test = true
        }
        local v7 = sort(v5)
        expect(#v7).to.equal(3)
        for v8, v9 in ipairs(v7) do
            expect(v6[v9]).to.equal(true)
        end
    end)
    it("should sort with the default table.sort when no callback is given", function() -- line 42 | captures: sort
        local v10 = { 4, 2, 5, 3, 1 }
        local v11 = sort(v10)
        table.sort(v10)
        expect(#v11).to.equal(#v10)
        local v12 = #v10
        for v13 = 1, v12 do
            expect(v11[v13]).to.equal(v10[v13])
        end
    end)
    it("should sort with the given callback", function() -- line 54 | captures: sort
        local v14 = { 1, 2, 5, 3, 4 }

        local function order(v15, v16) -- line 56
            return v16 < v15
        end

        local v17 = sort(v14, order)
        table.sort(v14, order)
        expect(#v17).to.equal(#v14)
        local v18 = #v14
        for v19 = 1, v18 do
            expect(v17[v19]).to.equal(v14[v19])
        end
    end)
    it("should work with an empty table", function() -- line 69 | captures: sort
        local v20 = sort({})
        expect(#v20).to.equal(0)
    end)
end
