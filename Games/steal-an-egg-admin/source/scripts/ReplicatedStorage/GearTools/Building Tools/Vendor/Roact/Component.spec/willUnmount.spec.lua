-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local createSpy = require(script.Parent.Parent.createSpy)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Type = require(script.Parent.Parent.Type)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be invoked when unmounted", function() -- line 12 | captures: createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v2 = createSpy()
        MyComponent.willUnmount = v2.value

        function MyComponent.render(v3) -- line 19
            return nil
        end

        local v4 = createElement(MyComponent)
        local Test = v1.mountVirtualNode(v4, nil, "Test")
        v1.unmountVirtualNode(Test)
        expect(v2.callCount).to.equal(1)
        local self = v2:captureValues("self")
        expect(Type.of(self.self)).to.equal(Type.StatefulComponentInstance)
    end)
end
