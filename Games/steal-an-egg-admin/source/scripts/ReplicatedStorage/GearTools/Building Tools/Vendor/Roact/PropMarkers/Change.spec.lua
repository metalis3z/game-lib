-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Type = require(script.Parent.Parent.Type)
    local Change = require(script.Parent.Change)
    it("should yield change listener objects when indexed", function() -- line 6 | captures: Type, Change
        expect(Type.of(Change.Text)).to.equal(Type.HostChangeEvent)
        expect(Type.of(Change.Selected)).to.equal(Type.HostChangeEvent)
    end)
    it("should yield the same object when indexed again", function() -- line 11 | captures: Change
        local Text = Change.Text
        local Text_2 = Change.Text
        local Selected = Change.Selected
        expect(Text).to.equal(Text_2)
        expect(Text).never.to.equal(Selected)
    end)
end
