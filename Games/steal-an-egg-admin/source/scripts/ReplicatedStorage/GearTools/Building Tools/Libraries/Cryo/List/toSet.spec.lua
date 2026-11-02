-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local toSet = require(script.Parent.toSet)
    it("should return a new table", function() -- line 4 | captures: toSet
        local v1 = { 1, 2, 3 }
        expect(toSet(v1)).never.to.equal(v1)
    end)
    it("should not mutate the given table", function() -- line 10 | captures: toSet
        local v2 = { "a", "b", "c" }
        toSet(v2)
        for v3, v4 in pairs(v2) do
            if v3 == 1 then
                expect(v4).to.equal("a")
            elseif v3 == 2 then
                expect(v4).to.equal("b")
            elseif v3 == 3 then
                expect(v4).to.equal("c")
            else
                error("Extra key was added to table a")
            end
        end
    end)
    it("should have every value in a as a key mapped to true in b", function() -- line 27 | captures: toSet
        local v5 = { 1, 2, 3, "a", "b", "c" }
        local v6 = toSet(v5)
        expect(#v6).to.equal(3)
        expect(v6[1]).to.equal(true)
        expect(v6[2]).to.equal(true)
        expect(v6[3]).to.equal(true)
        expect(v6[4]).to.equal(nil)
        expect(v6.a).to.equal(true)
        expect(v6.b).to.equal(true)
        expect(v6.c).to.equal(true)
    end)
end
