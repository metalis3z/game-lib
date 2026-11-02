-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.Parent.assertDeepEqual)
    local createElement = require(script.Parent.Parent.createElement)
    local createReconciler = require(script.Parent.Parent.createReconciler)
    local createSpy = require(script.Parent.Parent.createSpy)
    local NoopRenderer = require(script.Parent.Parent.NoopRenderer)
    local Type = require(script.Parent.Parent.Type)
    local Component = require(script.Parent.Parent.Component)
    local v1 = createReconciler(NoopRenderer)
    it("should be invoked when updated via updateVirtualNode", function() -- line 13 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v2 = createSpy()
        MyComponent.didUpdate = v2.value

        function MyComponent.render(v3) -- line 19
            return nil
        end

        local v4 = { a = 5 }
        local v5 = createElement(MyComponent, v4)
        local Test = v1.mountVirtualNode(v5, nil, "Test")
        expect(v2.callCount).to.equal(0)
        local v6 = {
            a = 6,
            b = 2
        }
        local v7 = createElement(MyComponent, v6)
        v1.updateVirtualNode(Test, v7)
        expect(v2.callCount).to.equal(1)
        local oldState = v2:captureValues("self", "oldProps", "oldState")
        expect(Type.of(oldState.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(oldState.oldProps, v4)
        assertDeepEqual(oldState.oldState, {})
    end)
    it("should be invoked when updated via setState", function() -- line 50 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v8 = createSpy()
        MyComponent.didUpdate = v8.value
        local v9 = { a = 4 }
        local v10

        function MyComponent.init(v11) -- line 61 | captures: v10, v9
            function v10(...) -- line 62 | captures: v11
                return v11:setState(...)
            end

            v11:setState(v9)
        end

        function MyComponent.render(v12) -- line 69
        end

        local v13 = createElement(MyComponent)
        v1.mountVirtualNode(v13, nil, "Test")
        expect(v8.callCount).to.equal(0)
        v10({ a = 5 })
        expect(v8.callCount).to.equal(1)
        local oldState = v8:captureValues("self", "oldProps", "oldState")
        expect(Type.of(oldState.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(oldState.oldProps, {})
        assertDeepEqual(oldState.oldState, v9)
    end)
end
