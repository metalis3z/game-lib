-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Type = require(script.Parent.Parent.Type)
    local Event = require(script.Parent.Event)
    it("should yield event objects when indexed", function() -- line 6 | captures: Type, Event
        expect(Type.of(Event.MouseButton1Click)).to.equal(Type.HostEvent)
        expect(Type.of(Event.Touched)).to.equal(Type.HostEvent)
    end)
    it("should yield the same object when indexed again", function() -- line 11 | captures: Event
        local MouseButton1Click = Event.MouseButton1Click
        local MouseButton1Click_2 = Event.MouseButton1Click
        local Touched = Event.Touched
        expect(MouseButton1Click).to.equal(MouseButton1Click_2)
        expect(MouseButton1Click).never.to.equal(Touched)
    end)
end
