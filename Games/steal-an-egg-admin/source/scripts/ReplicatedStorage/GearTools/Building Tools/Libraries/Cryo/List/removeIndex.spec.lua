-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local removeIndex = require(script.Parent.removeIndex)
    local None = require(script.Parent.Parent.None)
    it("should remove the element at the given index", function() -- line 5 | captures: removeIndex
        local v1 = { "first", "second", "third" }
        local v2 = removeIndex(v1, 2)
        expect(#v2).to.equal(2)
        expect(v2[1]).to.equal("first")
        expect(v2[2]).to.equal("third")
    end)
    it("should not remove any element if index is out of bound", function() -- line 19 | captures: removeIndex
        local v3 = { "first", "second", "third" }
        local v4 = removeIndex(v3, 4)
        expect(#v4).to.equal(#v3)
        local v5 = #v3
        for v6 = 1, v5 do
            expect(v4[v6]).to.equal(v3[v6])
        end
        local v7 = removeIndex(v3, -2)
        expect(#v7).to.equal(#v3)
        local v8 = #v3
        for v9 = 1, v8 do
            expect(v7[v9]).to.equal(v3[v9])
        end
    end)
    it("should work with a None element", function() -- line 40 | captures: removeIndex, None
        local v10 = { "first", None, "third" }
        local v11 = removeIndex(v10, 1)
        expect(#v11).to.equal(2)
        expect(v11[1]).to.equal(None)
        expect(v11[2]).to.equal("third")
    end)
end
