-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local removeValue = require(script.Parent.removeValue)
    local None = require(script.Parent.Parent.None)
    it("should remove the given value", function() -- line 5 | captures: removeValue
        local v1 = { 1, 4, 3 }
        local v2 = removeValue(v1, 4)
        expect(v2[1]).to.equal(1)
        expect(v2[2]).to.equal(3)
    end)
    it("should remove all occurences of the same given value", function() -- line 13 | captures: removeValue
        local v3 = { 1, 2, 2, 3 }
        local v4 = removeValue(v3, 2)
        expect(#v4).to.equal(2)
        expect(v4[1]).to.equal(1)
        expect(v4[2]).to.equal(3)
    end)
    it("should work with an empty list", function() -- line 22 | captures: removeValue
        local v5 = removeValue({}, 1)
        expect(v5).to.be.a("table")
        expect(#v5).to.equal(0)
    end)
    it("should work with a None element", function() -- line 29 | captures: removeValue, None
        local v6 = { 1, 2, None, 3 }
        local v7 = removeValue(v6, 2)
        expect(#v7).to.equal(3)
        expect(v7[1]).to.equal(1)
        expect(v7[2]).to.equal(None)
        expect(v7[3]).to.equal(3)
        local v8 = removeValue(v6, None)
        expect(v8[3]).to.equal(3)
        expect(#v8).to.equal(3)
    end)
end
