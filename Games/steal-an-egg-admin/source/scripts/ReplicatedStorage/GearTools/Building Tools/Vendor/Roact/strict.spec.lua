-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local strict = require(script.Parent.strict)
    it("should error when getting a nonexistent key", function() -- line 4 | captures: strict
        local v1 = strict({
            a = 1,
            b = 2
        })
        expect(function() -- line 10 | captures: v1
            return v1.c
        end).to.throw()
    end)
    it("should error when setting a nonexistent key", function() -- line 15 | captures: strict
        local v2 = strict({
            a = 1,
            b = 2
        })
        expect(function() -- line 21 | captures: v2
            v2.c = 3
        end).to.throw()
    end)
end
