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
        MyComponent.willUpdate = v2.value

        function MyComponent.render(v3) -- line 20
            return nil
        end

        local v4 = { a = 5 }
        local v5 = createElement(MyComponent, v4)
        local Test = v1.mountVirtualNode(v5, nil, "Test")
        local v6 = {
            a = 6,
            b = 2
        }
        local v7 = createElement(MyComponent, v6)
        v1.updateVirtualNode(Test, v7)
        expect(v2.callCount).to.equal(1)
        local newState = v2:captureValues("self", "newProps", "newState")
        expect(Type.of(newState.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(newState.newProps, v6)
        assertDeepEqual(newState.newState, {})
    end)
    it("it should be invoked when updated via setState", function() -- line 49 | captures: assertDeepEqual, createElement, createSpy, Type, Component, v1
        local MyComponent = Component:extend("MyComponent")
        local v8
        local v9 = createSpy()
        MyComponent.willUpdate = v9.value

        function MyComponent.init(v10) -- line 57 | captures: v8
            function v8(v11) -- line 58 | captures: v10
                v10:setState(v11)
            end

            v10:setState({ foo = 1 })
        end

        function MyComponent.render(v12) -- line 67
            return nil
        end

        local v13 = createElement(MyComponent)
        v1.mountVirtualNode(v13, nil, "Test")
        expect(v9.callCount).to.equal(0)
        v8({ foo = 2 })
        expect(v9.callCount).to.equal(1)
        local newState = v9:captureValues("self", "newProps", "newState")
        expect(Type.of(newState.self)).to.equal(Type.StatefulComponentInstance)
        assertDeepEqual(newState.newProps, {})
        assertDeepEqual(newState.newState, { foo = 2 })
    end)
end
