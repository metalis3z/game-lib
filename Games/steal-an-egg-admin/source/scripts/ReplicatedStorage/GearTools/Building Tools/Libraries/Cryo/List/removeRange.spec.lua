-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local removeRange = require(script.Parent.removeRange)
    local None = require(script.Parent.Parent.None)
    it("should remove elements properly", function() -- line 5 | captures: removeRange
        local v1 = { 1, 2, 3 }
        local v2 = removeRange(v1, 2, 2)
        expect(#v2).to.equal(2)
        expect(v2[1]).to.equal(1)
        expect(v2[2]).to.equal(3)
        local v3 = { 1, 2, 3, 4, 5, 6 }
        local v4 = removeRange(v3, 1, 4)
        expect(#v4).to.equal(2)
        expect(v4[1]).to.equal(5)
        expect(v4[2]).to.equal(6)
        local v5 = removeRange(v3, 2, 5)
        expect(#v5).to.equal(2)
        expect(v5[1]).to.equal(1)
        expect(v5[2]).to.equal(6)
    end)
    it("should throw when the start index is higher than the end index", function() -- line 27 | captures: removeRange
        local v6 = { 1, 2, 3 }
        expect(function() -- line 30 | captures: v6, removeRange
            removeRange(v6, 2, 0)
        end).to.throw()
        expect(function() -- line 34 | captures: v6, removeRange
            removeRange(v6, 1, -1)
        end).to.throw()
    end)
    it("should copy the table when then indexes are higher than the list length", function() -- line 39 | captures: removeRange
        local v7 = { 1, 2, 3 }
        local v8 = removeRange(v7, 4, 7)
        expect(#v8).to.equal(3)
        expect(v8[1]).to.equal(1)
        expect(v8[2]).to.equal(2)
        expect(v8[3]).to.equal(3)
    end)
    it("should work when the start index is smaller than 1", function() -- line 49 | captures: removeRange
        local v9 = { 1, 2, 3, 4 }
        local v10 = removeRange(v9, -5, 2)
        expect(#v10).to.equal(2)
        expect(v10[1]).to.equal(3)
        expect(v10[2]).to.equal(4)
    end)
    it("should work when the end index is greater than the list length", function() -- line 58 | captures: removeRange
        local v11 = { 1, 2, 3, 4 }
        local v12 = removeRange(v11, 3, 8)
        expect(#v12).to.equal(2)
        expect(v12[1]).to.equal(1)
        expect(v12[2]).to.equal(2)
    end)
    it("should work with a None element", function() -- line 67 | captures: removeRange, None
        local v13 = { 1, None, 3 }
        local v14 = removeRange(v13, 1, 1)
        expect(#v14).to.equal(2)
        expect(v14[1]).to.equal(None)
        expect(v14[2]).to.equal(3)
    end)
end
