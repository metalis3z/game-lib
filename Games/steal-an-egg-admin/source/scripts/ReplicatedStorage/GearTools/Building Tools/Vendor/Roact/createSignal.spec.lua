-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createSignal = require(script.Parent.createSignal)
    local createSpy = require(script.Parent.createSpy)
    it("should fire subscribers and disconnect them", function() -- line 6 | captures: createSignal, createSpy
        local v1 = createSignal()
        local v2 = createSpy()
        local v3 = v1:subscribe(v2.value)
        expect(v2.callCount).to.equal(0)
        local v4 = {}
        v1:fire(1, v4, "hello")
        expect(v2.callCount).to.equal(1)
        v2:assertCalledWith(1, v4, "hello")
        v3()
        v1:fire()
        expect(v2.callCount).to.equal(1)
    end)
    it("should handle multiple subscribers", function() -- line 29 | captures: createSignal, createSpy
        local v5 = createSignal()
        local v6 = createSpy()
        local v7 = createSpy()
        local v8 = v5:subscribe(v6.value)
        local v9 = v5:subscribe(v7.value)
        expect(v6.callCount).to.equal(0)
        expect(v7.callCount).to.equal(0)
        local v10 = {}
        v5:fire(v10, 67)
        expect(v6.callCount).to.equal(1)
        v6:assertCalledWith(v10, 67)
        expect(v7.callCount).to.equal(1)
        v7:assertCalledWith(v10, 67)
        v8()
        v5:fire(67, v10)
        expect(v6.callCount).to.equal(1)
        expect(v7.callCount).to.equal(2)
        v7:assertCalledWith(67, v10)
        v9()
    end)
    it("should stop firing a connection if disconnected mid-fire", function() -- line 63 | captures: createSignal, createSpy
        local v11 = createSignal()
        local v12, v13
        local v14 = createSpy(function() -- line 73 | captures: v13
            v13()
        end)
        local v15 = createSpy(function() -- line 77 | captures: v12
            v12()
        end)
        v12 = v11:subscribe(v14.value)
        v13 = v11:subscribe(v15.value)
        v11:fire()
        expect(v14.callCount + v15.callCount).to.equal(1)
    end)
end
