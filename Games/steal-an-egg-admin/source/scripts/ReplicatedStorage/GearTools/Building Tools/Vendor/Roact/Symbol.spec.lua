-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Symbol = require(script.Parent.Symbol)
    describe("named", function() -- line 4 | captures: Symbol
        it("should give an opaque object", function() -- line 5 | captures: Symbol
            local foo = Symbol.named("foo")
            expect(foo).to.be.a("userdata")
        end)
        it("should coerce to the given name", function() -- line 11 | captures: Symbol
            local foo = Symbol.named("foo")
            expect(tostring(foo):find("foo")).to.be.ok()
        end)
        it("should be unique when constructed", function() -- line 17 | captures: Symbol
            local abc = Symbol.named("abc")
            local abc_2 = Symbol.named("abc")
            expect(abc).never.to.equal(abc_2)
        end)
    end)
end
