-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Type = require(script.Parent.Type)
    describe("of", function() -- line 4 | captures: Type
        it("should return nil if the value is not a table", function() -- line 5 | captures: Type
            expect(Type.of(1)).to.equal(nil)
            expect(Type.of(true)).to.equal(nil)
            expect(Type.of("test")).to.equal(nil)
            expect(Type.of(print)).to.equal(nil)
        end)
        it("should return nil if the table has no type", function() -- line 12 | captures: Type
            expect(Type.of({})).to.equal(nil)
        end)
        it("should return the assigned type", function() -- line 16 | captures: Type
            local v1 = { [Type] = Type.Element }
            expect(Type.of(v1)).to.equal(Type.Element)
        end)
    end)
end
