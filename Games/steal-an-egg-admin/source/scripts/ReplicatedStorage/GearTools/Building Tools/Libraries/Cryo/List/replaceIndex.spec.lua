-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local replaceIndex = require(script.Parent.replaceIndex)
    it("should return a new table", function() -- line 4 | captures: replaceIndex
        local v1 = { 1, 2, 3 }
        expect(replaceIndex(v1, 2, 0)).never.to.equal(v1)
    end)
    it("should not mutate the original list", function() -- line 10 | captures: replaceIndex
        local v2 = { false, "foo", 3 }
        local v3 = {}
        replaceIndex(v2, 2, v3)
        expect(#v2).to.equal(3)
        expect(v2[1]).to.equal(false)
        expect(v2[2]).to.equal("foo")
        expect(v2[3]).to.equal(3)
    end)
    it("should replace the value at the given index", function() -- line 21 | captures: replaceIndex
        local v4 = { 1, 2, 3 }
        local v5 = {}
        local v6 = replaceIndex(v4, 2, v5)
        expect(v6[1]).to.equal(1)
        expect(v6[2]).to.equal(v5)
        expect(v6[3]).to.equal(3)
        expect(next(v6[2])).to.equal(nil)
    end)
    it("should throw if the given index is higher than the list length", function() -- line 32 | captures: replaceIndex
        local v7 = { 1 }
        expect(function() -- line 35 | captures: v7, replaceIndex
            replaceIndex(v7, #v7 + 1, {})
        end).to.throw()
    end)
    it("should be able to replace to a falsy value", function() -- line 40 | captures: replaceIndex
        local v8 = {}
        local v9 = { v8, false, "value", true }
        local v10 = replaceIndex(v9, 3, false)
        expect(v10[1]).to.equal(v8)
        expect(v10[2]).to.equal(false)
        expect(v10[3]).to.equal(false)
        expect(v10[4]).to.equal(true)
    end)
end
