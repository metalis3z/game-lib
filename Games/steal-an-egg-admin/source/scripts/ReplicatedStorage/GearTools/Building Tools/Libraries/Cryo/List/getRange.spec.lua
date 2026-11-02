-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local getRange = require(script.Parent.getRange)
    it("should return the correct range", function() -- line 4 | captures: getRange
        local v1 = { 1, 2, 3, 4 }
        local v2 = getRange(v1, 2, 3)
        expect(v2[1]).to.equal(2)
        expect(v2[2]).to.equal(3)
        expect(#v2).to.equal(2)
        local v3 = getRange(v1, 4, 4)
        expect(#v3).to.equal(1)
        expect(v3[1]).to.equal(4)
    end)
    it("should throw when the start index is higher than the end index", function() -- line 17 | captures: getRange
        local v4 = { 5, 8, 7, 2, 3, 7 }
        expect(function() -- line 20 | captures: v4, getRange
            getRange(v4, 4, 1)
        end).to.throw()
    end)
    it("should copy the table", function() -- line 25 | captures: getRange
        local v5 = { 6, 8, 1, 3, 7, 2 }
        local v6 = getRange(v5, 1, #v5)
        for v7, v8 in pairs(v5) do
            expect(v6[v7]).to.equal(v8)
        end
        for v9, v10 in pairs(v6) do
            expect(v10).to.equal(v5[v9])
        end
    end)
    it("should work with an empty table", function() -- line 38 | captures: getRange
        local v11 = getRange({}, 1, 5)
        expect(v11).to.be.a("table")
        expect(#v11).to.equal(0)
    end)
    it("should work when the start index is smaller that 1", function() -- line 45 | captures: getRange
        local v12 = { 1, 2, 3, 4 }
        local v13 = getRange(v12, -2, 2)
        expect(#v13).to.equal(2)
        expect(v13[1]).to.equal(1)
        expect(v13[2]).to.equal(2)
    end)
    it("should work when the end index is larger that the list length", function() -- line 54 | captures: getRange
        local v14 = { 1, 2, 3, 4 }
        local v15 = getRange(v14, 3, 18)
        expect(#v15).to.equal(2)
        expect(v15[1]).to.equal(3)
        expect(v15[2]).to.equal(4)
    end)
end
