-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Type = require(script.Parent.Parent.Type)
    local Component = require(script.Parent.Parent.Component)
    it("should be extendable", function() -- line 6 | captures: Type, Component
        local v1 = Component:extend("The Senate")
        expect(v1).to.be.ok()
        expect(Type.of(v1)).to.equal(Type.StatefulComponentClass)
    end)
    it("should prevent extending a user component", function() -- line 13 | captures: Component
        local Sheev = Component:extend("Sheev")
        expect(function() -- line 16 | captures: Sheev
            Sheev:extend("Frank")
        end).to.throw()
    end)
    it("should use a given name", function() -- line 21 | captures: Component
        local FooBar = Component:extend("FooBar")
        local v2 = tostring(FooBar)
        expect(v2).to.be.a("string")
        expect(v2:find("FooBar")).to.be.ok()
    end)
end
