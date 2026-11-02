-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local reverse = require(script.Parent.reverse)
    it("should return a new table", function() -- line 4 | captures: reverse
        local v1 = { 1, 2, 3 }
        expect(reverse(v1)).never.to.equal(v1)
    end)
    it("should not mutate the given table", function() -- line 10 | captures: reverse
        local v2 = { 1, 2, 3 }
        reverse(v2)
        expect(#v2).to.equal(3)
        expect(v2[1]).to.equal(1)
        expect(v2[2]).to.equal(2)
        expect(v2[3]).to.equal(3)
    end)
    it("should contain the same elements", function() -- line 20 | captures: reverse
        local v3 = { "Foo", "Bar" }
        local v4 = {
            Foo = true,
            Bar = true
        }
        local v5 = reverse(v3)
        expect(#v5).to.equal(2)
        for v6, v7 in ipairs(v5) do
            expect(v4[v7]).to.equal(true)
        end
    end)
    it("should reverse the list", function() -- line 37 | captures: reverse
        local v8 = { 1, 2, 3, 4 }
        local v9 = reverse(v8)
        expect(v9[1]).to.equal(4)
        expect(v9[2]).to.equal(3)
        expect(v9[3]).to.equal(2)
        expect(v9[4]).to.equal(1)
    end)
end
