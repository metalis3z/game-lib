-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local ElementKind = require(script.Parent.ElementKind)
    local Type = require(script.Parent.Type)
    local createFragment = require(script.Parent.createFragment)
    it("should create new primitive elements", function() -- line 7 | captures: ElementKind, Type, createFragment
        local v1 = createFragment({})
        expect(v1).to.be.ok()
        expect(Type.of(v1)).to.equal(Type.Element)
        expect(ElementKind.of(v1)).to.equal(ElementKind.Fragment)
    end)
    it("should accept children", function() -- line 15 | captures: createFragment
        local v2 = createFragment({})
        local v3 = createFragment({ key = v2 })
        expect(v3.elements.key).to.equal(v2)
    end)
end
