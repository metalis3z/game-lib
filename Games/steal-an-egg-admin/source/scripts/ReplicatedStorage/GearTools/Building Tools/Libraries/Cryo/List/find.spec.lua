-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local find = require(script.Parent.find)
    it("should return the correct index", function() -- line 4 | captures: find
        local v1 = { 5, 4, 3, 2, 1 }
        expect(find(v1, 1)).to.equal(5)
        expect(find(v1, 2)).to.equal(4)
        expect(find(v1, 3)).to.equal(3)
        expect(find(v1, 4)).to.equal(2)
        expect(find(v1, 5)).to.equal(1)
    end)
    it("should work with an empty table", function() -- line 14 | captures: find
        expect(find({}, 1)).to.equal(nil)
    end)
    it("should return nil when the given value is not found", function() -- line 18 | captures: find
        local function v2(...)
            return (type(...))
        end

        local v3 = { 1, 2, 3 }
        expect(find(v3, 4)).to.equal(nil)
        expect((v2(find(v3, 4)))).to.equal("nil")
    end)
    it("should return the index of the first value found", function() -- line 25 | captures: find
        local v4 = { 1, 2, 2 }
        expect(find(v4, 2)).to.equal(2)
    end)
end
