-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.createElement)
    local oneChild = require(script.Parent.oneChild)
    it("should get zero children from a table", function() -- line 6 | captures: oneChild
        local v1 = {}
        expect(oneChild(v1)).to.equal(nil)
    end)
    it("should get exactly one child", function() -- line 12 | captures: createElement, oneChild
        local Frame = createElement("Frame")
        local v2 = { foo = Frame }
        expect(oneChild(v2)).to.equal(Frame)
    end)
    it("should error with more than one child", function() -- line 21 | captures: createElement, oneChild
        local v3 = {
            a = createElement("Frame"),
            b = createElement("Frame")
        }
        expect(function() -- line 27 | captures: v3, oneChild
            oneChild(v3)
        end).to.throw()
    end)
    it("should handle being passed nil", function() -- line 32 | captures: oneChild
        expect(oneChild(nil)).to.equal(nil)
    end)
end
