-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Binding = require(script.Parent.Binding)
    local Type = require(script.Parent.Type)
    local createRef = require(script.Parent.createRef)
    it("should create refs, which are specialized bindings", function() -- line 7 | captures: Type, createRef
        local v1 = createRef()
        expect(Type.of(v1)).to.equal(Type.Binding)
        expect(v1.current).to.equal(nil)
    end)
    it("should have a 'current' field that is the same as the internal binding's value", function() -- line 14 | captures: Binding, createRef
        local v2 = createRef()
        expect(v2.current).to.equal(nil)
        Binding.update(v2, 10)
        expect(v2.current).to.equal(10)
    end)
    it("should support tostring on refs", function() -- line 23 | captures: Binding, createRef
        local v3 = createRef()
        expect(v3.current).to.equal(nil)
        expect((tostring(v3))).to.equal("RoactRef(nil)")
        Binding.update(v3, 10)
        expect((tostring(v3))).to.equal("RoactRef(10)")
    end)
    it("should not allow assignments to the 'current' field", function() -- line 33 | captures: Binding, createRef
        local v4 = createRef()
        expect(v4.current).to.equal(nil)
        Binding.update(v4, 99)
        expect(v4.current).to.equal(99)
        expect(function() -- line 41 | captures: v4
            v4.current = 77
        end).to.throw()
        expect(v4.current).to.equal(99)
    end)
    it("should return the same thing from getValue as its current field", function() -- line 48 | captures: Binding, createRef
        local v5 = createRef()
        Binding.update(v5, 10)
        expect(v5:getValue()).to.equal(10)
        expect(v5:getValue()).to.equal(v5.current)
    end)
end
